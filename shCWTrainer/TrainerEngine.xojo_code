#tag Class
Protected Class TrainerEngine
	#tag Method, Flags = &h0
		Sub BeginAttempt(target As String)
		  CurrentTarget = target.Uppercase
		  ReceivedText = ""
		  CurrentPattern = ""
		  LastResult = "Listen, then send it back."
		  mKeyIsDown = False
		  mLastKeyUp = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CheckIdle(atMilliseconds As Double)
		  If mKeyIsDown Or CurrentPattern = "" Or mLastKeyUp = 0 Then Return
		  If atMilliseconds - mLastKeyUp >= CharacterGapMilliseconds Then FinishCharacter
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  mCodec = New MorseCodec
		  LoadCallsigns
		  ResetSession
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EvaluateIfComplete()
		  Dim compactReceived As String = ReceivedText.ReplaceAll(" ", "")
		  Dim compactTarget As String = CurrentTarget.ReplaceAll(" ", "")
		  If compactReceived.Length < compactTarget.Length Then Return
		  Attempts = Attempts + 1
		  If compactReceived = compactTarget Then
		    Correct = Correct + 1
		    Streak = Streak + 1
		    LastResult = "Correct — good copy!"
		  Else
		    Streak = 0
		    LastResult = "Not quite. Target: " + CurrentTarget + "   You sent: " + ReceivedText
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FinishCharacter()
		  If CurrentPattern = "" Then Return
		  ReceivedText = ReceivedText + mCodec.Decode(CurrentPattern)
		  CurrentPattern = ""
		  EvaluateIfComplete
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeyDown(atMilliseconds As Double)
		  If mKeyIsDown Then Return
		  If mLastKeyUp > 0 And CurrentPattern <> "" Then
		    Dim gap As Double = atMilliseconds - mLastKeyUp
		    If gap >= WordGapMilliseconds Then
		      FinishCharacter
		      If ReceivedText <> "" And Not ReceivedText.EndsWith(" ") Then ReceivedText = ReceivedText + " "
		    ElseIf gap >= CharacterGapMilliseconds Then
		      FinishCharacter
		    End If
		  End If
		  mKeyIsDown = True
		  mKeyDownAt = atMilliseconds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub KeyUp(atMilliseconds As Double)
		  If Not mKeyIsDown Then Return
		  Dim duration As Double = atMilliseconds - mKeyDownAt
		  If duration < 10 Then duration = 10
		  If duration < ElementThresholdMilliseconds Then
		    CurrentPattern = CurrentPattern + "."
		  Else
		    CurrentPattern = CurrentPattern + "-"
		  End If
		  mKeyIsDown = False
		  mLastKeyUp = atMilliseconds
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LessonCharacters(lesson As Integer) As String
		  Dim order As String = "ETANIMSOUDRCQYHGPXJKVBFWLZ0123456789"
		  Dim counts() As Integer = Array(2, 4, 6, 8, 10, 12, 15, 18, 22, 26, 36)
		  Dim index As Integer = lesson
		  If index < 0 Then index = 0
		  If index > counts.LastIndex Then index = counts.LastIndex
		  Return order.Left(counts(index))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadCallsigns()
		  Try
		    Dim source As New FolderItem("/Users/michaelmorgan/Documents/GitHub/shCWTrainer/shCWTrainer/MASTER.SCP", FolderItem.PathModes.Native)
		    If source Is Nil Or Not source.Exists Then Return
		    Dim stream As BinaryStream = BinaryStream.Open(source)
		    Dim contents As String = stream.Read(stream.Length, Encodings.UTF8)
		    stream.Close
		    contents = contents.ReplaceLineEndings(EndOfLine)
		    For Each rawLine As String In contents.Split(EndOfLine)
		      Dim callsign As String = rawLine.Trim.Uppercase
		      If callsign = "" Or callsign.BeginsWith("#") Or callsign.BeginsWith("!") Then Continue
		      If callsign.Length < 3 Or callsign.Length > 12 Then Continue
		      Dim valid As Boolean = True
		      For Each character As String In callsign.Characters
		        If Not mCodec.IsValid(character) Then valid = False
		      Next
		      If valid Then mCallsigns.Add(callsign)
		    Next
		    CallsignSource = "Super Check Partial · " + mCallsigns.Count.ToString + " calls"
		  Catch error As RuntimeException
		    CallsignSource = "Built-in callsign fallback"
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextPrompt(mode As String, lesson As Integer) As String
		  Dim pool As String = LessonCharacters(lesson)
		  If mode = "Callsigns" Then
		    If mCallsigns.Count > 0 Then
		      Dim selected As String
		      For attempt As Integer = 0 To 5
		        selected = mCallsigns(System.Random.InRange(0, mCallsigns.LastIndex))
		        If selected <> mLastCallsign Then Exit
		      Next
		      mLastCallsign = selected
		      Return selected
		    End If
		    Dim fallback() As String = Array("K5ZD", "W9KKN", "AA5SH", "N6MTS", "VE3NE", "DL1A", "JA1ABC")
		    Return fallback(System.Random.InRange(0, fallback.LastIndex))
		  End If
		  If mode = "Words" Then
		    Dim words() As String = Array("THE", "AND", "RADIO", "MORSE", "CODE", "SIGNAL", "ANTENNA", "POWER", "NAME", "QTH")
		    Dim candidates() As String
		    For Each word As String In words
		      Dim allowed As Boolean = True
		      For Each character As String In word.Characters
		        If pool.IndexOf(character) < 0 Then allowed = False
		      Next
		      If allowed Then candidates.Add(word)
		    Next
		    If candidates.Count > 0 Then Return candidates(System.Random.InRange(0, candidates.LastIndex))
		  End If
		  Return pool.Middle(System.Random.InRange(0, pool.Length - 1), 1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResetSession()
		  Attempts = 0
		  Correct = 0
		  Streak = 0
		  CurrentTarget = ""
		  ReceivedText = ""
		  CurrentPattern = ""
		  LastResult = "Choose a drill and press Start."
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Attempts As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		CallsignSource As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return DitMilliseconds * 2.5
			End Get
		#tag EndGetter
		Private CharacterGapMilliseconds As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Correct As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentPattern As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CurrentTarget As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return 1200.0 / WPM
			End Get
		#tag EndGetter
		DitMilliseconds As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return DitMilliseconds * 2.0
			End Get
		#tag EndGetter
		Private ElementThresholdMilliseconds As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		LastResult As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCallsigns() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCodec As MorseCodec
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyDownAt As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyIsDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastCallsign As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastKeyUp As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		ReceivedText As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Streak As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return DitMilliseconds * 6.0
			End Get
		#tag EndGetter
		Private WordGapMilliseconds As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		WPM As Integer = 20
	#tag EndProperty


End Class
#tag EndClass
