#tag Class
Protected Class SidetonePlayer
	#tag ExternalMethod, Flags = &h21
		Private Declare Sub AudioClose Lib kAudioShim Alias "shcw_audio_close" ()
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Sub AudioGate Lib kAudioShim Alias "shcw_audio_gate" (isOn As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function AudioOpen Lib kAudioShim Alias "shcw_audio_open" (frequency As Single, volume As Single) As Integer
	#tag EndExternalMethod
	#tag ExternalMethod, Flags = &h21
		Private Declare Function NativePlaybackActive Lib kAudioShim Alias "shcw_playback_active" () As Integer
	#tag EndExternalMethod
	#tag ExternalMethod, Flags = &h21
		Private Declare Sub NativePlaybackStart Lib kAudioShim Alias "shcw_playback_start" (text As CString, wpm As Integer)
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Sub Configure(newPitch As Integer, newVolume As Integer)
		  If newPitch < 300 Then newPitch = 300
		  If newPitch > 1200 Then newPitch = 1200
		  If newVolume < 0 Then newVolume = 0
		  If newVolume > 100 Then newVolume = 100
		  If newPitch = Pitch And newVolume = Volume Then Return
		  Pitch = newPitch
		  Volume = newVolume
		  #If TargetMacOS Then
		    Dim result As Integer = AudioOpen(Pitch, Volume / 100.0)
		    If result <> 0 Then LastError = "Core Audio could not update (" + result.ToString + ")."
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Pitch = 600
		  Volume = 70
		  #If TargetMacOS Then
		    Dim result As Integer = AudioOpen(Pitch, Volume / 100.0)
		    If result <> 0 Then LastError = "Core Audio could not start (" + result.ToString + ")."
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsPlaying() As Boolean
		  #If TargetMacOS Then
		    Return NativePlaybackActive <> 0
		  #Else
		    Return False
		  #EndIf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlayText(text As String, wpm As Integer)
		  #If TargetMacOS Then
		    NativePlaybackStart(text, wpm)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Shutdown()
		  #If TargetMacOS Then
		    AudioClose
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StartTone()
		  #If TargetMacOS Then
		    AudioGate(1)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StopTone()
		  #If TargetMacOS Then
		    AudioGate(0)
		  #EndIf
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		LastError As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Pitch As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Volume As Integer
	#tag EndProperty


	#tag Constant, Name = kAudioShim, Type = String, Dynamic = False, Default = "/Users/michaelmorgan/Documents/GitHub/shCWTrainer/shCWTrainer/native/libshcwmidi.dylib", Scope = Private
	#tag EndConstant


End Class
#tag EndClass
