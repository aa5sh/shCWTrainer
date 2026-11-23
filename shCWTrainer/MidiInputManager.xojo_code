#tag Class
Protected Class MidiInputManager
	#tag Method, Flags = &h0
		Sub ConfigureKeyer(wpm As Integer, mode As Integer, swap As Boolean, enabled As Boolean, bTimingPercent As Integer)
		  #If TargetMacOS Then
		    KeyerConfigure(wpm, mode, If(swap, 1, 0), If(enabled, 1, 0), bTimingPercent)
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Disconnect()
		  #If TargetMacOS Then
		    ShimClose
		  #EndIf
		  Connected = False
		  DeviceSummary = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DispatchPendingEvents()
		  #If TargetMacOS Then
		    If Not Connected Then Return
		    Dim note As Integer
		    Dim down As Integer
		    While ShimPoll(note, down) = 1
		      RaiseEvent PaddleChanged(note, down <> 0)
		    Wend
		    While KeyerPoll(down) = 1
		      RaiseEvent NativeKeyChanged(down <> 0)
		    Wend
		  #EndIf
		End Sub
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Sub KeyerConfigure Lib kMidiShim Alias "shcw_keyer_configure" (wpm As Integer, mode As Integer, swap As Integer, enabled As Integer, bTimingPercent As Integer)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function KeyerPoll Lib kMidiShim Alias "shcw_keyer_poll" (ByRef isDown As Integer) As Integer
	#tag EndExternalMethod

	#tag Method, Flags = &h0
		Function OpenInput() As Boolean
		  #If TargetMacOS Then
		    Disconnect
		    Dim result As Integer = ShimOpen
		    If result > 0 Then
		      Connected = True
		      DeviceSummary = result.ToString + " MIDI input source(s)"
		      LastError = ""
		      Return True
		    End If
		    If result = -1000 Then
		      LastError = "No MIDI inputs found. Connect the HaliKey and try again."
		    Else
		      LastError = "CoreMIDI could not open the HaliKey input (" + result.ToString + ")."
		    End If
		    Return False
		  #Else
		    LastError = "MIDI input currently requires macOS. Use the spacebar fallback."
		    Return False
		  #EndIf
		End Function
	#tag EndMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Sub ShimClose Lib kMidiShim Alias "shcw_midi_close" ()
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function ShimOpen Lib kMidiShim Alias "shcw_midi_open" () As Integer
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h21
		Private Declare Function ShimPoll Lib kMidiShim Alias "shcw_midi_poll" (ByRef note As Integer, ByRef isDown As Integer) As Integer
	#tag EndExternalMethod


	#tag Hook, Flags = &h0
		Event NativeKeyChanged(isDown As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PaddleChanged(note As Integer, isDown As Boolean)
	#tag EndHook


	#tag Property, Flags = &h0
		Connected As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		DeviceSummary As String
	#tag EndProperty

	#tag Property, Flags = &h0
		LastError As String
	#tag EndProperty


	#tag Constant, Name = kMidiShim, Type = String, Dynamic = False, Default = \"Users/michaelmorgan/Documents/GitHub/shCWTrainer/shCWTrainer/native/libshcwmidi.dylib", Scope = Private
	#tag EndConstant


End Class
#tag EndClass
