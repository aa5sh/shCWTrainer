#tag Class
Protected Class SoftwareKeyer
	#tag Method, Flags = &h21
		Private Sub EnterIdle()
		  mState = StateIdle
		  mDitLatched = False
		  mDahLatched = False
		  mDitAtElementStart = False
		  mDahAtElementStart = False
		  mDitAtSpaceStart = False
		  mDahAtSpaceStart = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasNextElement() As Boolean
		  If Mode = "Ultimatic" And mDitDown And mDahDown Then Return True
		  If mLastElementWasDit Or mState = StateIdle Then
		    If mDahLatched Or mDahDown Then Return True
		    If mDitLatched Or mDitDown Then Return True
		    If Mode = "Iambic B" And mDahAtElementStart And Not mDitDown And Not mDahDown Then Return True
		  Else
		    If mDitLatched Or mDitDown Then Return True
		    If mDahLatched Or mDahDown Then Return True
		    If Mode = "Iambic B" And mDitAtElementStart And Not mDitDown And Not mDahDown Then Return True
		  End If
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NextElementIsDah() As Boolean
		  If Mode = "Ultimatic" And mDitDown And mDahDown Then Return mLastPressedWasDah
		  If mState = StateIdle And mDitDown And mDahDown Then Return False
		  If mLastElementWasDit Or mState = StateIdle Then
		    If mDahLatched Or mDahDown Then Return True
		    If mDitLatched Or mDitDown Then Return False
		    If Mode = "Iambic B" And mDahAtElementStart And Not mDitDown And Not mDahDown Then Return True
		  Else
		    If mDitLatched Or mDitDown Then Return False
		    If mDahLatched Or mDahDown Then Return True
		    If Mode = "Iambic B" And mDitAtElementStart And Not mDitDown And Not mDahDown Then Return False
		  End If
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PaddleChanged(note As Integer, isDown As Boolean, nowMilliseconds As Double)
		  If Mode = "Straight Key" Then
		    If note = 20 Then mDitDown = isDown
		    If note = 21 Then mDahDown = isDown
		    If note = 20 Or note = 21 Then
		      SetStraightKey(mDitDown Or mDahDown)
		    ElseIf note = 30 Then
		      SetStraightKey(isDown)
		    End If
		    Return
		  End If
		  If note <> 20 And note <> 21 Then Return
		  If note = 20 Then
		    mDitDown = isDown
		  Else
		    mDahDown = isDown
		  End If
		  If Mode = "Ultimatic" And isDown Then mLastPressedWasDah = (note = 21)
		  Select Case mState
		  Case StateIdle
		    If mDitDown Or mDahDown Then StartNextElement(nowMilliseconds)
		  Case StateTone
		    If mLastElementWasDit And mDahDown And Not mDahAtElementStart Then mDahLatched = True
		    If Not mLastElementWasDit And mDitDown And Not mDitAtElementStart Then mDitLatched = True
		  Case StateSpace
		    If mDitDown And Not mDitAtSpaceStart Then mDitLatched = True
		    If mDahDown And Not mDahAtSpaceStart Then mDahLatched = True
		  End Select
		  Tick(nowMilliseconds)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  If mToneOn Then RaiseEvent ToneChanged(False)
		  mToneOn = False
		  mStraightDown = False
		  mDitDown = False
		  mDahDown = False
		  EnterIdle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetStraightKey(isDown As Boolean)
		  If isDown = mStraightDown Then Return
		  mStraightDown = isDown
		  mToneOn = isDown
		  RaiseEvent ToneChanged(isDown)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartNextElement(nowMilliseconds As Double)
		  Dim sendDah As Boolean = NextElementIsDah
		  mDitAtElementStart = mDitDown
		  mDahAtElementStart = mDahDown
		  mDitLatched = False
		  mDahLatched = False
		  mLastElementWasDit = Not sendDah
		  mState = StateTone
		  If sendDah Then
		    mStateEndsAt = nowMilliseconds + DitMilliseconds * 3.0
		  Else
		    mStateEndsAt = nowMilliseconds + DitMilliseconds
		  End If
		  mToneOn = True
		  ElementCount = ElementCount + 1
		  RaiseEvent ToneChanged(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StateDescription() As String
		  Select Case mState
		  Case StateTone
		    Return "Tone"
		  Case StateSpace
		    Return "Space"
		  Else
		    Return "Idle"
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tick(nowMilliseconds As Double)
		  If mStraightDown Then Return
		  If mState = StateTone And nowMilliseconds >= mStateEndsAt Then
		    mToneOn = False
		    RaiseEvent ToneChanged(False)
		    mState = StateSpace
		    mDitAtSpaceStart = mDitDown
		    mDahAtSpaceStart = mDahDown
		    mStateEndsAt = mStateEndsAt + DitMilliseconds
		  End If
		  If mState = StateSpace And nowMilliseconds >= mStateEndsAt Then
		    If HasNextElement Then
		      StartNextElement(nowMilliseconds)
		    Else
		      EnterIdle
		    End If
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ToneChanged(isOn As Boolean)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mDahDown
			End Get
		#tag EndGetter
		DahIsDown As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mDitDown
			End Get
		#tag EndGetter
		DitIsDown As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return 1200.0 / WPM
			End Get
		#tag EndGetter
		Private DitMilliseconds As Double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		ElementCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDahAtElementStart As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDahAtSpaceStart As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDahDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDahLatched As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDitAtElementStart As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDitAtSpaceStart As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDitDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDitLatched As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastElementWasDit As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastPressedWasDah As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Mode As String = "Iambic B"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mState As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStateEndsAt As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStraightDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToneOn As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		WPM As Integer = 20
	#tag EndProperty


	#tag Constant, Name = StateIdle, Type = Integer, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StateSpace, Type = Integer, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant

	#tag Constant, Name = StateTone, Type = Integer, Dynamic = False, Default = \"", Scope = Private
	#tag EndConstant


End Class
#tag EndClass
