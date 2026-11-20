#include <CoreFoundation/CoreFoundation.h>
#include <CoreMIDI/CoreMIDI.h>
#include <AudioToolbox/AudioToolbox.h>
#include <math.h>
#include <stdatomic.h>
#include <stdint.h>
#include <string.h>

#define QUEUE_SIZE 512
#define PLAYBACK_SEGMENTS 2048

typedef struct {
  uint8_t note;
  uint8_t down;
} key_event;

static MIDIClientRef client_ref = 0;
static MIDIPortRef input_port = 0;
static key_event event_queue[QUEUE_SIZE];
static _Atomic unsigned int write_index = 0;
static _Atomic unsigned int read_index = 0;
static AudioComponentInstance audio_unit = NULL;
static _Atomic int audio_gate = 0;
static _Atomic int paddle_dit = 0;
static _Atomic int paddle_dah = 0;
static _Atomic int keyer_mode = 1;
static _Atomic int keyer_wpm = 20;
static _Atomic int keyer_swap = 0;
static _Atomic int keyer_enabled = 1;
static _Atomic int keyer_b_timing_percent = 50;
static int keyer_state = 0;
static int keyer_samples_left = 0;
static int keyer_last_was_dit = 1;
static int keyer_dit_latched = 0;
static int keyer_dah_latched = 0;
static int keyer_dit_at_start = 0;
static int keyer_dah_at_start = 0;
static int keyer_dit_at_space = 0;
static int keyer_dah_at_space = 0;
static int keyer_element_total_samples = 0;
static int keyer_b_trailing_armed = 0;
static key_event key_queue[QUEUE_SIZE];
static _Atomic unsigned int key_write_index = 0;
static _Atomic unsigned int key_read_index = 0;
static _Atomic float audio_frequency = 600.0f;
static _Atomic float audio_volume = 0.7f;
static double audio_phase = 0.0;
static float audio_envelope = 0.0f;
static const double audio_sample_rate = 48000.0;
static int playback_tones[PLAYBACK_SEGMENTS];
static int playback_lengths[PLAYBACK_SEGMENTS];
static int playback_count = 0;
static int playback_index = 0;
static int playback_samples_left = 0;
static int playback_tone = 0;
static _Atomic int playback_active = 0;

static const char *morse_for_char(char character) {
  switch (character) {
    case 'A': return ".-"; case 'B': return "-..."; case 'C': return "-.-.";
    case 'D': return "-.."; case 'E': return "."; case 'F': return "..-.";
    case 'G': return "--."; case 'H': return "...."; case 'I': return "..";
    case 'J': return ".---"; case 'K': return "-.-"; case 'L': return ".-..";
    case 'M': return "--"; case 'N': return "-."; case 'O': return "---";
    case 'P': return ".--."; case 'Q': return "--.-"; case 'R': return ".-.";
    case 'S': return "..."; case 'T': return "-"; case 'U': return "..-";
    case 'V': return "...-"; case 'W': return ".--"; case 'X': return "-..-";
    case 'Y': return "-.--"; case 'Z': return "--..";
    case '1': return ".----"; case '2': return "..---"; case '3': return "...--";
    case '4': return "....-"; case '5': return "....."; case '6': return "-....";
    case '7': return "--..."; case '8': return "---.."; case '9': return "----.";
    case '0': return "-----"; case '/': return "-..-.";
    default: return NULL;
  }
}

void shcw_playback_start(const char *text, int wpm) {
  atomic_store_explicit(&playback_active, 0, memory_order_release);
  if (text == NULL) return;
  if (wpm < 5) wpm = 5;
  if (wpm > 60) wpm = 60;
  int dit = (int)(audio_sample_rate * 1.2 / wpm);
  int count = 0;
  for (size_t character_index = 0; text[character_index] != '\0'; character_index++) {
    char character = text[character_index];
    if (character >= 'a' && character <= 'z') character -= 32;
    if (character == ' ') {
      if (count > 0 && playback_tones[count - 1] == 0) playback_lengths[count - 1] = dit * 7;
      continue;
    }
    const char *pattern = morse_for_char(character);
    if (pattern == NULL) continue;
    for (size_t element = 0; pattern[element] != '\0' && count + 2 < PLAYBACK_SEGMENTS; element++) {
      playback_tones[count] = 1;
      playback_lengths[count++] = pattern[element] == '-' ? dit * 3 : dit;
      playback_tones[count] = 0;
      playback_lengths[count++] = dit;
    }
    if (count > 0) playback_lengths[count - 1] = dit * 3;
  }
  playback_count = count;
  playback_index = 0;
  playback_samples_left = 0;
  playback_tone = 0;
  if (count > 0) atomic_store_explicit(&playback_active, 1, memory_order_release);
}

int shcw_playback_active(void) {
  return atomic_load_explicit(&playback_active, memory_order_acquire);
}

static void enqueue_key(int down) {
  unsigned int write = atomic_load_explicit(&key_write_index, memory_order_relaxed);
  unsigned int next = (write + 1) % QUEUE_SIZE;
  if (next == atomic_load_explicit(&key_read_index, memory_order_acquire)) return;
  key_queue[write].note = 30;
  key_queue[write].down = down ? 1 : 0;
  atomic_store_explicit(&key_write_index, next, memory_order_release);
}

static void keyer_start_element(int send_dah, int dit_samples) {
  keyer_last_was_dit = !send_dah;
  keyer_dit_at_start = atomic_load(&paddle_dit);
  keyer_dah_at_start = atomic_load(&paddle_dah);
  keyer_dit_latched = 0;
  keyer_dah_latched = 0;
  keyer_samples_left = send_dah ? dit_samples * 3 : dit_samples;
  keyer_element_total_samples = keyer_samples_left;
  int b_percent = atomic_load(&keyer_b_timing_percent);
  keyer_b_trailing_armed = (b_percent <= 0 && keyer_dit_at_start && keyer_dah_at_start);
  keyer_state = 1;
  enqueue_key(1);
}

static int keyer_next_is_dah(int dit, int dah, int mode) {
  if (mode == 2 && dit && dah) return keyer_dah_at_start && !keyer_dit_at_start;
  if (keyer_state == 0 && dit && dah) return 0;
  if (keyer_last_was_dit || keyer_state == 0) {
    if (keyer_dah_latched || dah) return 1;
    if (keyer_dit_latched || dit) return 0;
    if (mode == 1 && keyer_b_trailing_armed && !dit && !dah) return 1;
  } else {
    if (keyer_dit_latched || dit) return 0;
    if (keyer_dah_latched || dah) return 1;
    if (mode == 1 && keyer_b_trailing_armed && !dit && !dah) return 0;
  }
  return -1;
}

static OSStatus audio_render(void *context, AudioUnitRenderActionFlags *flags,
                             const AudioTimeStamp *time, UInt32 bus,
                             UInt32 frames, AudioBufferList *buffers) {
  (void)context; (void)flags; (void)time; (void)bus;
  const float frequency = atomic_load_explicit(&audio_frequency, memory_order_relaxed);
  const float volume = atomic_load_explicit(&audio_volume, memory_order_relaxed);
  const float target = atomic_load_explicit(&audio_gate, memory_order_relaxed) ? volume : 0.0f;
  const float ramp_step = 1.0f / (float)(audio_sample_rate * 0.004);
  const double phase_step = 2.0 * M_PI * frequency / audio_sample_rate;
  for (UInt32 frame = 0; frame < frames; frame++) {
    if (atomic_load_explicit(&playback_active, memory_order_acquire)) {
      if (playback_samples_left <= 0) {
        if (playback_index >= playback_count) {
          playback_tone = 0;
          atomic_store_explicit(&playback_active, 0, memory_order_release);
        } else {
          playback_tone = playback_tones[playback_index];
          playback_samples_left = playback_lengths[playback_index];
          playback_index++;
        }
      }
      if (playback_samples_left > 0) playback_samples_left--;
    }
    int dit = atomic_load_explicit(&paddle_dit, memory_order_relaxed);
    int dah = atomic_load_explicit(&paddle_dah, memory_order_relaxed);
    int mode = atomic_load_explicit(&keyer_mode, memory_order_relaxed);
    int wpm = atomic_load_explicit(&keyer_wpm, memory_order_relaxed);
    if (wpm < 5) wpm = 5;
    if (wpm > 60) wpm = 60;
    int dit_samples = (int)(audio_sample_rate * 1.2 / wpm);
    if (atomic_load_explicit(&keyer_enabled, memory_order_relaxed)) {
      if (keyer_state == 0 && (dit || dah)) {
        keyer_dit_at_start = dit;
        keyer_dah_at_start = dah;
        int next = keyer_next_is_dah(dit, dah, mode);
        keyer_start_element(next > 0, dit_samples);
      } else if (keyer_state == 1) {
        if (keyer_last_was_dit && dah && !keyer_dah_at_start) keyer_dah_latched = 1;
        if (!keyer_last_was_dit && dit && !keyer_dit_at_start) keyer_dit_latched = 1;
        int b_percent = atomic_load_explicit(&keyer_b_timing_percent, memory_order_relaxed);
        int elapsed = keyer_element_total_samples - keyer_samples_left;
        if (mode == 1 && dit && dah && elapsed * 100 >= keyer_element_total_samples * b_percent) {
          keyer_b_trailing_armed = 1;
        }
        if (--keyer_samples_left <= 0) {
          keyer_state = 2;
          keyer_samples_left = dit_samples;
          keyer_dit_at_space = dit;
          keyer_dah_at_space = dah;
          enqueue_key(0);
        }
      } else if (keyer_state == 2) {
        if (dit && !keyer_dit_at_space) keyer_dit_latched = 1;
        if (dah && !keyer_dah_at_space) keyer_dah_latched = 1;
        if (--keyer_samples_left <= 0) {
          int next = keyer_next_is_dah(dit, dah, mode);
          if (next >= 0) keyer_start_element(next, dit_samples);
          else keyer_state = 0;
        }
      }
    }
    float effective_target = (atomic_load_explicit(&audio_gate, memory_order_relaxed) || keyer_state == 1 || playback_tone) ? volume : 0.0f;
    if (audio_envelope < effective_target) {
      audio_envelope += ramp_step;
      if (audio_envelope > effective_target) audio_envelope = effective_target;
    } else if (audio_envelope > effective_target) {
      audio_envelope -= ramp_step;
      if (audio_envelope < effective_target) audio_envelope = effective_target;
    }
    float sample = (float)sin(audio_phase) * audio_envelope;
    audio_phase += phase_step;
    if (audio_phase >= 2.0 * M_PI) audio_phase -= 2.0 * M_PI;
    for (UInt32 buffer_index = 0; buffer_index < buffers->mNumberBuffers; buffer_index++) {
      AudioBuffer *buffer = &buffers->mBuffers[buffer_index];
      float *output = (float *)buffer->mData;
      UInt32 channels = buffer->mNumberChannels;
      for (UInt32 channel = 0; channel < channels; channel++) {
        output[frame * channels + channel] = sample;
      }
    }
  }
  return noErr;
}

int shcw_audio_open(float frequency, float volume) {
  atomic_store(&audio_frequency, frequency);
  atomic_store(&audio_volume, volume);
  if (audio_unit != NULL) return 0;
  AudioComponentDescription description = {0};
  description.componentType = kAudioUnitType_Output;
  description.componentSubType = kAudioUnitSubType_DefaultOutput;
  description.componentManufacturer = kAudioUnitManufacturer_Apple;
  AudioComponent component = AudioComponentFindNext(NULL, &description);
  if (component == NULL) return -1;
  OSStatus status = AudioComponentInstanceNew(component, &audio_unit);
  if (status != noErr) return (int)status;
  AURenderCallbackStruct callback = { audio_render, NULL };
  status = AudioUnitSetProperty(audio_unit, kAudioUnitProperty_SetRenderCallback,
                                kAudioUnitScope_Input, 0, &callback, sizeof(callback));
  if (status != noErr) return (int)status;
  AudioStreamBasicDescription format = {0};
  format.mSampleRate = audio_sample_rate;
  format.mFormatID = kAudioFormatLinearPCM;
  format.mFormatFlags = kAudioFormatFlagIsFloat | kAudioFormatFlagIsPacked;
  format.mBytesPerPacket = sizeof(float) * 2;
  format.mFramesPerPacket = 1;
  format.mBytesPerFrame = sizeof(float) * 2;
  format.mChannelsPerFrame = 2;
  format.mBitsPerChannel = 32;
  status = AudioUnitSetProperty(audio_unit, kAudioUnitProperty_StreamFormat,
                                kAudioUnitScope_Input, 0, &format, sizeof(format));
  if (status != noErr) return (int)status;
  status = AudioUnitInitialize(audio_unit);
  if (status != noErr) return (int)status;
  return (int)AudioOutputUnitStart(audio_unit);
}

void shcw_audio_gate(int is_on) {
  atomic_store_explicit(&audio_gate, is_on ? 1 : 0, memory_order_relaxed);
}

void shcw_audio_close(void) {
  atomic_store(&audio_gate, 0);
  atomic_store(&playback_active, 0);
  if (audio_unit == NULL) return;
  AudioOutputUnitStop(audio_unit);
  AudioUnitUninitialize(audio_unit);
  AudioComponentInstanceDispose(audio_unit);
  audio_unit = NULL;
  audio_phase = 0.0;
  audio_envelope = 0.0f;
}

static void enqueue(uint8_t note, uint8_t down) {
  unsigned int write = atomic_load_explicit(&write_index, memory_order_relaxed);
  unsigned int next = (write + 1) % QUEUE_SIZE;
  if (next == atomic_load_explicit(&read_index, memory_order_acquire)) return;
  event_queue[write].note = note;
  event_queue[write].down = down;
  atomic_store_explicit(&write_index, next, memory_order_release);
}

static void midi_read(const MIDIPacketList *packets, void *context, void *source) {
  (void)context;
  (void)source;
  const MIDIPacket *packet = &packets->packet[0];
  for (UInt32 packet_number = 0; packet_number < packets->numPackets; packet_number++) {
    UInt16 position = 0;
    uint8_t running_status = 0;
    while (position < packet->length) {
      uint8_t value = packet->data[position];
      if (value >= 0xF8) { position++; continue; }
      if (value & 0x80) {
        running_status = value;
        position++;
      }
      if ((running_status & 0xF0) != 0x80 && (running_status & 0xF0) != 0x90) {
        position++;
        continue;
      }
      if (position + 1 >= packet->length) break;
      uint8_t note = packet->data[position++];
      uint8_t velocity = packet->data[position++];
      if (note == 20 || note == 21 || note == 30) {
        uint8_t down = ((running_status & 0xF0) == 0x90 && velocity > 0) ? 1 : 0;
        if (note == 20 || note == 21) {
          int swap = atomic_load_explicit(&keyer_swap, memory_order_relaxed);
          int is_dit = (note == 20) ^ swap;
          if (is_dit) atomic_store_explicit(&paddle_dit, down, memory_order_relaxed);
          else atomic_store_explicit(&paddle_dah, down, memory_order_relaxed);
        }
        enqueue(note, down);
      }
    }
    packet = MIDIPacketNext(packet);
  }
}

int shcw_midi_open(void) {
  if (client_ref != 0) return 0;
  atomic_store(&write_index, 0);
  atomic_store(&read_index, 0);
  CFStringRef client_name = CFSTR("SH CW Trainer");
  CFStringRef port_name = CFSTR("HaliKey Input");
  OSStatus status = MIDIClientCreate(client_name, NULL, NULL, &client_ref);
  if (status != noErr) return (int)status;
  status = MIDIInputPortCreate(client_ref, port_name, midi_read, NULL, &input_port);
  if (status != noErr) {
    MIDIClientDispose(client_ref);
    client_ref = 0;
    return (int)status;
  }
  ItemCount source_count = MIDIGetNumberOfSources();
  if (source_count == 0) {
    MIDIPortDispose(input_port);
    MIDIClientDispose(client_ref);
    input_port = 0;
    client_ref = 0;
    return -1000;
  }
  for (ItemCount index = 0; index < source_count; index++) {
    MIDIEndpointRef endpoint = MIDIGetSource(index);
    if (endpoint != 0) MIDIPortConnectSource(input_port, endpoint, NULL);
  }
  return (int)source_count;
}

int shcw_midi_poll(int *note, int *down) {
  unsigned int read = atomic_load_explicit(&read_index, memory_order_relaxed);
  if (read == atomic_load_explicit(&write_index, memory_order_acquire)) return 0;
  *note = event_queue[read].note;
  *down = event_queue[read].down;
  atomic_store_explicit(&read_index, (read + 1) % QUEUE_SIZE, memory_order_release);
  return 1;
}

int shcw_keyer_poll(int *down) {
  unsigned int read = atomic_load_explicit(&key_read_index, memory_order_relaxed);
  if (read == atomic_load_explicit(&key_write_index, memory_order_acquire)) return 0;
  *down = key_queue[read].down;
  atomic_store_explicit(&key_read_index, (read + 1) % QUEUE_SIZE, memory_order_release);
  return 1;
}

void shcw_keyer_configure(int wpm, int mode, int swap, int enabled, int b_timing_percent) {
  atomic_store(&keyer_wpm, wpm);
  atomic_store(&keyer_mode, mode);
  atomic_store(&keyer_swap, swap ? 1 : 0);
  atomic_store(&keyer_enabled, enabled ? 1 : 0);
  if (b_timing_percent < 0) b_timing_percent = 0;
  if (b_timing_percent > 100) b_timing_percent = 100;
  atomic_store(&keyer_b_timing_percent, b_timing_percent);
}

void shcw_midi_close(void) {
  if (input_port != 0) MIDIPortDispose(input_port);
  if (client_ref != 0) MIDIClientDispose(client_ref);
  input_port = 0;
  client_ref = 0;
  atomic_store(&write_index, 0);
  atomic_store(&read_index, 0);
  atomic_store(&paddle_dit, 0);
  atomic_store(&paddle_dah, 0);
  atomic_store(&key_write_index, 0);
  atomic_store(&key_read_index, 0);
  keyer_state = 0;
}
