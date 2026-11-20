# SH CW Trainer

A native desktop Morse-code trainer built with [Xojo](https://www.xojo.com/) for the HaliKey MIDI paddle interface.

SH CW Trainer plays a character, word, or amateur-radio callsign and asks you to send it back with your own key. It generates a local sidetone, decodes your response, and reports whether you copied and sent the prompt correctly. No radio connection is required.

> **Development status:** This project is under active development. The current native MIDI/audio layer targets macOS on Apple silicon.

## Features

- Listen-and-repeat drills for characters, words, and callsigns
- Progressive character lessons from `E T` through letters and numbers
- Real contest callsigns loaded from the Super Check Partial master file
- Iambic A, Iambic B, Ultimatic, and straight-key modes
- Adjustable Iambic B release timing
- Optional dit/dah paddle inversion
- Adjustable speed from 5–60 WPM
- Adjustable sidetone from 300–1200 Hz (600 Hz by default)
- Low-latency, sample-clocked Core Audio sidetone and prompt playback
- CoreMIDI input from HaliKey
- Score and consecutive-correct streak tracking
- Persistent speed, tone, lesson, keyer, and paddle settings
- Spacebar straight-key fallback for testing without hardware

## How a drill works

1. Select **Characters**, **Words**, or **Callsigns**.
2. Choose a lesson and set the desired WPM and sidetone frequency.
3. Click **Connect HaliKey** if you are using the MIDI device.
4. Click **Start / Next** and listen to the prompt.
5. Send the prompt back with your paddle or straight key.
6. The trainer decodes your sending and shows the result, score, and streak.

Prompt transmission uses standard Morse timing: one dit between elements, three dits between characters, and seven dits between words.

## HaliKey MIDI mapping

The application currently expects these MIDI note messages:

| MIDI note | Input |
| ---: | --- |
| 20 | Left paddle |
| 21 | Right paddle |
| 30 | Straight-key output |

Use **Swap paddles** if the physical dit and dah sides are opposite your preference.

## Requirements

### Running from source

- macOS
- Apple-silicon Mac (`arm64`)
- A recent Xojo Desktop release; the project was created with Xojo 2026r3.1
- Apple Command Line Tools/Clang for rebuilding the native library
- HaliKey MIDI device and a paddle or key (optional when using the spacebar fallback)

The trainer does not key or control a radio.

## Building

Clone the repository and rebuild the native MIDI/audio library:

```sh
git clone https://github.com/aa5sh/shCWTrainer.git
cd shCWTrainer/shCWTrainer
clang -arch arm64 -dynamiclib native/shcwmidi.c \
  -framework CoreMIDI \
  -framework AudioToolbox \
  -framework CoreFoundation \
  -o native/libshcwmidi.dylib
```

Then open [`shCWTrainer/shCWTrainer.xojo_project`](shCWTrainer/shCWTrainer.xojo_project) in Xojo and run or build the desktop project.

### Development-path note

The current Xojo source contains absolute development paths for the native library and `MASTER.SCP`. After cloning elsewhere, update:

- `kMidiShim` in `MidiInputManager.xojo_code`
- `kAudioShim` in `SidetonePlayer.xojo_code`
- The Super Check Partial path in `TrainerEngine.xojo_code`

Packaging these files as application resources is planned. Until then, the paths must point to the files in your local checkout.

## Project layout

```text
shCWTrainer/
├── README.md
├── LICENSE
└── shCWTrainer/
    ├── shCWTrainer.xojo_project   # Xojo desktop project
    ├── Window1.xojo_window        # Main application window
    ├── TrainerEngine.xojo_code    # Lessons, scoring, and response decoding
    ├── MorseCodec.xojo_code       # Morse encode/decode table
    ├── MidiInputManager.xojo_code # HaliKey/CoreMIDI bridge
    ├── SidetonePlayer.xojo_code   # Native audio interface
    ├── SoftwareKeyer.xojo_code    # Xojo keyer implementation/reference
    ├── MASTER.SCP                 # Callsign training data
    └── native/
        ├── shcwmidi.c             # CoreMIDI, keyer, and Core Audio engine
        └── libshcwmidi.dylib      # Prebuilt arm64 development library
```

## Callsign data

Callsign drills use the `MASTER.SCP` database from [Super Check Partial](https://www.supercheckpartial.com/). The included file can be replaced with a newer master file as updates become available.

## Background and acknowledgements

- HaliKey MIDI integration and keyer behavior were informed by the open-source [netKeyer](https://github.com/netKeyer/netkeyer) project.
- Callsign practice data is provided by [Super Check Partial](https://www.supercheckpartial.com/).
- The training workflow is inspired by listen-and-repeat CW practice and progressive character-learning methods.

## Contributing

Bug reports, testing feedback, and pull requests are welcome. Particularly useful areas include:

- Testing with different HaliKey and paddle configurations
- Improving training lessons and word lists
- Packaging the native library and callsign database as application resources
- Intel Mac, Windows, and Linux support
- Accessibility and user-interface improvements

When reporting keying issues, please include your macOS version, Mac model, selected keyer mode, WPM, B timing, and whether paddle inversion was enabled.

## License

SH CW Trainer is distributed under the [GNU General Public License v3.0](LICENSE).
