#tag DesktopWindow
Begin DesktopWindow Window1
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   True
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   HasTitleBar     =   True
   Height          =   624
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1360570367
   MenuBarVisible  =   True
   MinimumHeight   =   584
   MinimumWidth    =   760
   Resizeable      =   True
   Title           =   "SH CW Trainer"
   Type            =   0
   Visible         =   True
   Width           =   880
   Begin DesktopLabel TitleLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   28.0
      FontUnit        =   0
      Height          =   38
      Index           =   -2147483648
      Italic          =   False
      Left            =   30
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "SH CW Trainer"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   22
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   350
   End
   Begin DesktopLabel SubtitleLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   24
      Index           =   -2147483648
      Italic          =   False
      Left            =   32
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Listen. Send it back. Build clean, confident Morse."
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   62
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   600
   End
   Begin DesktopPopupMenu ModePopup
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   28
      Index           =   -2147483648
      InitialValue    =   "Characters\nWords\nCallsigns"
      Italic          =   False
      Left            =   30
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   1
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   110
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   160
   End
   Begin DesktopPopupMenu LessonPopup
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   28
      Index           =   -2147483648
      InitialValue    =   "1 · E T\n2 · E T A N\n3 · + I M\n4 · + S O\n5 · + U D\n6 · + R C\n7 · + Q Y H\n8 · + G P X\n9 · + J K V B\n10 · Full alphabet\n11 · Letters + numbers"
      Italic          =   False
      Left            =   202
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   4
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   110
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   190
   End
   Begin DesktopTextField WPMField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   28
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   526
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "20"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   110
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   44
   End
   Begin DesktopPopupMenu KeyerModePopup
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   28
      Index           =   -2147483648
      InitialValue    =   "Iambic A\nIambic B\nUltimatic\nStraight Key"
      Italic          =   False
      Left            =   404
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      SelectedRowIndex=   1
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "Mode B adds a trailing opposite element; tune its release window with B timing"
      Top             =   110
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   112
   End
   Begin DesktopLabel WPMLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   575
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "WPM"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   114
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   50
   End
   Begin DesktopButton ConnectButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Connect HaliKey"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   32
      Index           =   -2147483648
      Italic          =   False
      Left            =   620
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   108
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
   End
   Begin DesktopButton StartButton
      AllowAutoDeactivate=   True
      Bold            =   True
      Cancel          =   False
      Caption         =   "Start / Next"
      Default         =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   32
      Index           =   -2147483648
      Italic          =   False
      Left            =   740
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   108
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   110
   End
   Begin DesktopLabel PitchLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   404
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Sidetone"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   153
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   64
   End
   Begin DesktopTextField PitchField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   26
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   472
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "600"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   "Sidetone pitch, 300–1200 Hz"
      Top             =   148
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   54
   End
   Begin DesktopLabel HertzLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   532
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Hz"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   153
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   30
   End
   Begin DesktopCheckBox SwapPaddlesCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Swap paddles"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   590
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   0
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   "Reverse the dit and dah paddles"
      Top             =   151
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   130
   End
   Begin DesktopLabel BTimingLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   22
      Index           =   -2147483648
      Italic          =   False
      Left            =   726
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "B timing"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   "0 is eager Curtis B; 100 approaches Mode A release timing"
      Top             =   153
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   58
   End
   Begin DesktopTextField BTimingField
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   False
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      Height          =   26
      Hint            =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   790
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "50"
      TextAlignment   =   2
      TextColor       =   &c000000
      Tooltip         =   "Enhanced Mode B timing percentage, 0–100"
      Top             =   148
      Transparent     =   False
      Underline       =   False
      ValidationMask  =   ""
      Visible         =   True
      Width           =   50
   End
   Begin DesktopRectangle PracticeCard
      AllowAutoDeactivate=   True
      BorderColor     =   &cD6DAE1
      BorderThickness =   1.0
      CornerSize      =   12.0
      Enabled         =   True
      FillColor       =   &cF7F8FA
      Height          =   282
      Index           =   -2147483648
      Left            =   30
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   8
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   188
      Transparent     =   False
      Visible         =   True
      Width           =   820
   End
   Begin DesktopLabel PromptLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   16.0
      FontUnit        =   0
      Height          =   28
      Index           =   -2147483648
      Italic          =   False
      Left            =   56
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Press Start / Next to hear the first prompt"
      TextAlignment   =   1
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   214
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   768
   End
   Begin DesktopLabel SentLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   40.0
      FontUnit        =   0
      Height          =   60
      Index           =   -2147483648
      Italic          =   False
      Left            =   56
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "—"
      TextAlignment   =   1
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   260
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   768
   End
   Begin DesktopLabel PatternLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   18.0
      FontUnit        =   0
      Height          =   28
      Index           =   -2147483648
      Italic          =   False
      Left            =   56
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   1
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   328
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   768
   End
   Begin DesktopLabel ResultLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   16.0
      FontUnit        =   0
      Height          =   48
      Index           =   -2147483648
      Italic          =   False
      Left            =   56
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Keyboard fallback: hold Space to key the sidetone"
      TextAlignment   =   1
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   380
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   768
   End
   Begin DesktopLabel StatusLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   24
      Index           =   -2147483648
      Italic          =   False
      Left            =   30
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "MIDI: not connected"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   494
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   500
   End
   Begin DesktopLabel ScoreLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   24
      Index           =   -2147483648
      Italic          =   False
      Left            =   548
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Score 0 / 0    Streak 0"
      TextAlignment   =   3
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   494
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   302
   End
   Begin DesktopLabel HelpLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   62
      Index           =   -2147483648
      Italic          =   False
      Left            =   30
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "HaliKey MIDI notes: 20 left paddle, 21 right paddle, 30 straight key. Spacebar is the straight-key fallback. For scored copy, use the HaliKey keyer/straight-key output (note 30)."
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   538
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   820
   End
   Begin Timer UiTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   30
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin Timer PlaybackTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   5
      Scope           =   0
      TabPanelIndex   =   0
   End
   Begin Timer KeyerTimer
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   10
      Scope           =   0
      TabPanelIndex   =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  SaveSettings
		  If mMidi <> Nil Then mMidi.Disconnect
		  If mSidetone <> Nil Then mSidetone.Shutdown
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(key As String) As Boolean
		  If key = " " And Not mSpaceDown Then
		    mSpaceDown = True
		    HandleKeyState(True)
		    Return True
		  End If
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Sub KeyUp(key As String)
		  If key = " " And mSpaceDown Then
		    mSpaceDown = False
		    HandleKeyState(False)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  mEngine = New TrainerEngine
		  mSidetone = New SidetonePlayer
		  mMidi = New MidiInputManager
		  mKeyer = New SoftwareKeyer
		  LoadSettings
		  AddHandler mMidi.PaddleChanged, AddressOf MidiPaddleChanged
		  AddHandler mMidi.NativeKeyChanged, AddressOf NativeKeyChanged
		  AddHandler mKeyer.ToneChanged, AddressOf KeyerToneChanged
		  Dim keyerTest As New SoftwareKeyer
		  keyerTest.WPM = 20
		  keyerTest.Mode = "Iambic B"
		  keyerTest.PaddleChanged(20, True, 0)
		  keyerTest.Tick(61)
		  keyerTest.Tick(121)
		  If keyerTest.ElementCount < 2 Then StatusLabel.Text = "Keyer self-test failed"
		  UpdateDisplay
		  app.AllowAutoQuit = True
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AdvancePlayback()
		  If Not mPlaybackActive Then Return
		  If Not mSidetone.IsPlaying Then
		    mSidetone.StopTone
		    mPlaybackActive = False
		    PromptLabel.Text = "Your turn — send it back"
		    ResultLabel.Text = "Hold Space, or key your HaliKey"
		    StartButton.Caption = "Next"
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildPlayback(text As String)
		  mPlaybackDurations.RemoveAll
		  mPlaybackTones.RemoveAll
		  Dim codec As New MorseCodec
		  Dim dit As Integer = mEngine.DitMilliseconds
		  For characterIndex As Integer = 0 To text.Length - 1
		    Dim pattern As String = codec.Encode(text.Middle(characterIndex, 1))
		    For elementIndex As Integer = 0 To pattern.Length - 1
		      mPlaybackTones.Add(True)
		      If pattern.Middle(elementIndex, 1) = "." Then
		        mPlaybackDurations.Add(dit)
		      Else
		        mPlaybackDurations.Add(dit * 3)
		      End If
		      mPlaybackTones.Add(False)
		      mPlaybackDurations.Add(dit)
		    Next
		    If mPlaybackDurations.Count > 0 Then mPlaybackDurations(mPlaybackDurations.LastIndex) = dit * 3
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleKeyState(isDown As Boolean)
		  If mEngine Is Nil Then Return
		  If isDown Then
		    mSidetone.StartTone
		    mEngine.KeyDown(NowMilliseconds)
		  Else
		    mSidetone.StopTone
		    mEngine.KeyUp(NowMilliseconds)
		  End If
		  UpdateDisplay
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub KeyerToneChanged(sender As SoftwareKeyer, isOn As Boolean)
		  #Pragma Unused sender
		  HandleKeyState(isOn)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LoadSettings()
		  Try
		    Dim settingsFile As FolderItem = SpecialFolder.Preferences.Child("SH CW Trainer Settings.txt")
		    If settingsFile Is Nil Or Not settingsFile.Exists Then Return
		    Dim input As TextInputStream = TextInputStream.Open(settingsFile)
		    While Not input.EndOfFile
		      Dim line As String = input.ReadLine
		      Dim separator As Integer = line.IndexOf("=")
		      If separator < 1 Then Continue
		      Dim key As String = line.Left(separator)
		      Dim value As String = line.Middle(separator + 1)
		      Select Case key
		      Case "WPM"
		        Dim speed As Integer = value.ToInteger
		        If speed >= 5 And speed <= 60 Then WPMField.Text = speed.ToString
		      Case "Pitch"
		        Dim pitch As Integer = value.ToInteger
		        If pitch >= 300 And pitch <= 1200 Then PitchField.Text = pitch.ToString
		      Case "Mode"
		        Dim modeIndex As Integer = value.ToInteger
		        If modeIndex >= 0 And modeIndex < ModePopup.RowCount Then ModePopup.SelectedRowIndex = modeIndex
		      Case "Lesson"
		        Dim lessonIndex As Integer = value.ToInteger
		        If lessonIndex >= 0 And lessonIndex < LessonPopup.RowCount Then LessonPopup.SelectedRowIndex = lessonIndex
		      Case "KeyerMode"
		        Dim keyerIndex As Integer = value.ToInteger
		        If keyerIndex >= 0 And keyerIndex < KeyerModePopup.RowCount Then KeyerModePopup.SelectedRowIndex = keyerIndex
		      Case "SwapPaddles"
		        SwapPaddlesCheck.Value = value = "1"
		      Case "BTiming"
		        Dim timing As Integer = value.ToInteger
		        If timing >= 0 And timing <= 100 Then BTimingField.Text = timing.ToString
		      End Select
		    Wend
		    input.Close
		  Catch error As RuntimeException
		    StatusLabel.Text = "Settings could not be restored: " + error.Message
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MidiPaddleChanged(sender As MidiInputManager, note As Integer, isDown As Boolean)
		  #Pragma Unused sender
		  If note = 20 Then mRawLeftDown = isDown
		  If note = 21 Then mRawRightDown = isDown
		  If KeyerModePopup.SelectedRowValue = "Straight Key" Then
		    If note = 20 Or note = 21 Or note = 30 Then HandleKeyState(isDown)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub NativeKeyChanged(sender As MidiInputManager, isDown As Boolean)
		  #Pragma Unused sender
		  If isDown Then mNativeElementCount = mNativeElementCount + 1
		  If isDown Then
		    mSidetone.StartTone
		    mEngine.KeyDown(NowMilliseconds)
		  Else
		    mSidetone.StopTone
		    mEngine.KeyUp(NowMilliseconds)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NowMilliseconds() As Double
		  Return System.Microseconds / 1000.0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveSettings()
		  Try
		    Dim settingsFile As FolderItem = SpecialFolder.Preferences.Child("SH CW Trainer Settings.txt")
		    If settingsFile Is Nil Then Return
		    Dim output As TextOutputStream = TextOutputStream.Create(settingsFile)
		    output.WriteLine("WPM=" + WPMField.Text)
		    output.WriteLine("Pitch=" + PitchField.Text)
		    output.WriteLine("Mode=" + ModePopup.SelectedRowIndex.ToString)
		    output.WriteLine("Lesson=" + LessonPopup.SelectedRowIndex.ToString)
		    output.WriteLine("KeyerMode=" + KeyerModePopup.SelectedRowIndex.ToString)
		    output.WriteLine("SwapPaddles=" + If(SwapPaddlesCheck.Value, "1", "0"))
		    output.WriteLine("BTiming=" + BTimingField.Text)
		    output.Close
		  Catch error As RuntimeException
		    StatusLabel.Text = "Settings could not be saved: " + error.Message
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub StartNextPrompt()
		  Dim speed As Integer = WPMField.Text.ToInteger
		  If speed < 5 Then speed = 5
		  If speed > 60 Then speed = 60
		  WPMField.Text = speed.ToString
		  mEngine.WPM = speed
		  Dim target As String = mEngine.NextPrompt(ModePopup.SelectedRowValue, LessonPopup.SelectedRowIndex)
		  mEngine.BeginAttempt(target)
		  BuildPlayback(target)
		  PromptLabel.Text = "Listen…"
		  SentLabel.Text = "—"
		  ResultLabel.Text = ""
		  StartButton.Caption = "Replay / New"
		  mPlaybackActive = True
		  mSidetone.PlayText(target, speed)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateDisplay()
		  If mEngine Is Nil Then Return
		  If mEngine.ReceivedText = "" Then
		    SentLabel.Text = "—"
		  Else
		    SentLabel.Text = mEngine.ReceivedText
		  End If
		  PatternLabel.Text = mEngine.CurrentPattern
		  ResultLabel.Text = mEngine.LastResult
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mEngine As TrainerEngine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyer As SoftwareKeyer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKeyerClock As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMidi As MidiInputManager
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNativeElementCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlaybackActive As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlaybackDeadline As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlaybackDurations() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlaybackIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPlaybackTones() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRawLeftDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRawRightDown As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSidetone As SidetonePlayer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSpaceDown As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events KeyerModePopup
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused item
		  If mKeyer <> Nil Then mKeyer.Reset
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConnectButton
	#tag Event
		Sub Pressed()
		  If mMidi.Connected Then
		    mMidi.Disconnect
		    ConnectButton.Caption = "Connect HaliKey"
		    StatusLabel.Text = "MIDI: not connected"
		  ElseIf mMidi.OpenInput Then
		    ConnectButton.Caption = "Disconnect"
		    StatusLabel.Text = "MIDI: connected · " + mMidi.DeviceSummary
		  Else
		    StatusLabel.Text = "MIDI: " + mMidi.LastError
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events StartButton
	#tag Event
		Sub Pressed()
		  StartNextPrompt
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events UiTimer
	#tag Event
		Sub Action()
		  If mEngine Is Nil Then Return
		  If mSidetone <> Nil Then
		    Dim pitch As Integer = PitchField.Text.ToInteger
		    If pitch < 300 Then pitch = 300
		    If pitch > 1200 Then pitch = 1200
		    mSidetone.Configure(pitch, 70)
		  End If
		  If mMidi <> Nil And mMidi.Connected And mKeyer <> Nil Then
		    Dim leftState As String = If(mRawLeftDown, "DOWN", "up")
		    Dim rightState As String = If(mRawRightDown, "DOWN", "up")
		    StatusLabel.Text = "MIDI connected · L " + leftState + " · R " + rightState + " · Native elements " + mNativeElementCount.ToString
		  End If
		  mEngine.CheckIdle(NowMilliseconds)
		  UpdateDisplay
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PlaybackTimer
	#tag Event
		Sub Action()
		  AdvancePlayback
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events KeyerTimer
	#tag Event
		Sub Action()
		  mKeyerClock = mKeyerClock + KeyerTimer.Period
		  If mMidi <> Nil Then mMidi.DispatchPendingEvents
		  If mKeyer Is Nil Then Return
		  mKeyer.WPM = WPMField.Text.ToInteger
		  If mKeyer.WPM < 5 Then mKeyer.WPM = 5
		  If mKeyer.WPM > 60 Then mKeyer.WPM = 60
		  mKeyer.Mode = KeyerModePopup.SelectedRowValue
		  Dim nativeMode As Integer = KeyerModePopup.SelectedRowIndex
		  Dim nativeEnabled As Boolean = KeyerModePopup.SelectedRowValue <> "Straight Key"
		  Dim bTiming As Integer = BTimingField.Text.ToInteger
		  If bTiming < 0 Then bTiming = 0
		  If bTiming > 100 Then bTiming = 100
		  mMidi.ConfigureKeyer(mKeyer.WPM, nativeMode, SwapPaddlesCheck.Value, nativeEnabled, bTiming)
		End Sub
	#tag EndEvent
#tag EndEvents
