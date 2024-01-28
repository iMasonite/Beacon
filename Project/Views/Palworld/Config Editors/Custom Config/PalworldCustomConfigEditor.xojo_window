#tag DesktopWindow
Begin PalworldConfigEditor PalworldCustomConfigEditor Implements NotificationKit.Receiver
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   382
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   True
   LockLeft        =   True
   LockRight       =   True
   LockTop         =   True
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   Visible         =   True
   Width           =   608
   Begin CodeEditor ConfigArea
      AutoDeactivate  =   True
      Enabled         =   True
      HasBorder       =   False
      Height          =   341
      HorizontalScrollPosition=   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectionLength =   0
      ShowInfoBar     =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      VerticalScrollPosition=   0
      Visible         =   True
      Width           =   608
   End
   Begin OmniBar ConfigToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   41
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftPadding     =   -1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RightPadding    =   -1
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   608
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  NotificationKit.Ignore(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  NotificationKit.Watch(Self, App.Notification_AppearanceChanged)
		End Sub
	#tag EndEvent

	#tag Event
		Function ParsingFinished(Project As Palworld.Project) As Boolean
		  Var Identity As Beacon.Identity = App.IdentityManager.CurrentIdentity
		  Var SelfProject As Palworld.Project = Self.Project
		  Var CreatedEditorNames() As String
		  Var Config As Palworld.Configs.CustomContent = Self.Config(False)
		  Var Organizer As New Palworld.ConfigOrganizer(Palworld.ConfigFileSettings, Palworld.HeaderPalworldSettings, Config.SettingsIniContent)
		  
		  For Each CreatedConfig As Palworld.ConfigGroup In Project.ImplementedConfigs(Project.ActiveConfigSet)
		    Var InternalName As String = CreatedConfig.InternalName
		    If InternalName = Palworld.Configs.NameCustomConfig Then
		      Continue
		    End If
		    
		    If Palworld.Configs.ConfigUnlocked(InternalName, Identity) = False Then
		      // Do not import code for groups that the user has not purchased
		      Continue
		    End If
		    
		    If CreatedConfig.IsImplicit Then
		      // This was just there to support other editors, don't import it.
		      Continue
		    End If
		    
		    If SelfProject.HasConfigGroup(InternalName) Then
		      Var CurrentConfig As Palworld.ConfigGroup = SelfProject.ConfigGroup(InternalName, False)
		      If (CurrentConfig Is Nil) = False Then
		        Var Configs(1) As Palworld.ConfigGroup
		        Configs(0) = CurrentConfig
		        Configs(1) = CreatedConfig
		        
		        Var Merged As Palworld.ConfigGroup = Palworld.Configs.Merge(Configs, True)
		        SelfProject.AddConfigGroup(Merged)
		      Else
		        SelfProject.AddConfigGroup(CreatedConfig)
		      End If
		    Else
		      SelfProject.AddConfigGroup(CreatedConfig)
		    End If
		    
		    Organizer.Remove(CreatedConfig.ManagedKeys)
		    
		    CreatedEditorNames.Add(Language.LabelForConfig(InternalName))
		  Next
		  
		  If CreatedEditorNames.Count > 0 Then
		    Call Self.Config(True)
		    Config.SettingsIniContent() = Organizer
		    Self.Modified = True
		  End If
		  
		  Self.SetupUI()
		  
		  If CreatedEditorNames.Count = 0 Then
		    Self.ShowAlert("No supported editor content found", "Beacon was unable to find any lines in PalWorldSettings.ini that it has a guided editor for.")
		  ElseIf CreatedEditorNames.Count = 1 Then
		    Self.ShowAlert("Finished converting Custom Config Content", "Beacon found and setup the a guided editor for " + CreatedEditorNames(0) + ".")
		  Else
		    Self.ShowAlert("Finished converting Custom Config Content", "Beacon found and setup the following guided editors: " + Language.EnglishOxfordList(CreatedEditorNames) + ".")
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub RunTool(Tool As Palworld.ProjectTool)
		  Select Case Tool.ToolId
		  Case "4add8d2b-fca9-4f37-9eb3-aae75b2c21fc"
		    Self.LookForSupportedContent()
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Select Case Self.ActiveButtonName
		  Case "SettingsIniButton"
		    Self.ConfigArea.Text = Self.Config(False).SettingsIniContent
		    Self.mSettingsIniState.ApplyTo(Self.ConfigArea)
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As Palworld.Configs.CustomContent
		  Return Palworld.Configs.CustomContent(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Project As Palworld.Project)
		  Self.mSettingsIniState = New TextAreaState
		  
		  Super.Constructor(Project)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CurrentFile() As String
		  Select Case Self.ActiveButtonName
		  Case "SettingsIniButton"
		    Return Palworld.ConfigFileSettings
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function CurrentHeader() As String
		  Var CurrentLineNum As Integer = Self.ConfigArea.LineFromPosition(Self.ConfigArea.Position)
		  If Self.mCachedHeaderLine = CurrentLineNum Then
		    Return Self.mCachedHeader
		  End If
		  
		  Var Header As String
		  Select Case Self.ActiveButtonName
		  Case "SettingsIniButton"
		    Header = Palworld.HeaderPalworldSettings
		  End Select
		  
		  For LineNum As Integer = CurrentLineNum DownTo 0
		    Var Line As String = Self.ConfigArea.Line(LineNum).Trim
		    If Line.BeginsWith("[") And Line.EndsWith("]") Then
		      Header = Line.Middle(1, Line.Length - 2)
		      Exit For LineNum
		    End If
		  Next LineNum
		  
		  Self.mCachedHeader = Header
		  Self.mCachedHeaderLine = CurrentLineNum
		  
		  Return Header
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return Palworld.Configs.NameCustomConfig
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LookForSupportedContent(Confirm As Boolean = True)
		  If Confirm Then
		    If Not Self.ShowConfirm("Do you want Beacon to search your Custom Config Content for lines that are supported by guided editors?", "Beacon will import your Custom Config Content and automatically setup guided editors for the lines it can support. Config lines will be merged according to Beacon's standard config merging guidelines.", "Continue", "Cancel") Then
		      Return
		    End If
		  End If
		  
		  Var Config As Palworld.Configs.CustomContent = Self.Config(False)
		  Self.Parse(Config.SettingsIniContent, "Custom Config Content")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotificationKit_NotificationReceived(Notification As NotificationKit.Notification)
		  // Part of the NotificationKit.Receiver interface.
		  
		  Select Case Notification.Name
		  Case App.Notification_AppearanceChanged
		    Self.UpdateTextColors()
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectionIsCommented() As Boolean
		  Var FirstLineNum As Integer = Self.ConfigArea.LineFromPosition(Self.ConfigArea.SelectionStart)
		  Var FirstLine As String = Self.ConfigArea.Line(FirstLineNum)
		  Return FirstLine.BeginsWith("//")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SelectionIsEncrypted() As Boolean
		  If Self.ConfigArea.SelectionStart >= Self.ConfigArea.Text.Length Then
		    Return False
		  End If
		  
		  Var StartPos As Integer = Self.ConfigArea.SelectionStart
		  Var EndPos As Integer = StartPos + Max(Self.ConfigArea.SelectionLength, 1)
		  For Each Range As Beacon.Range In Self.mEncryptedRanges
		    If StartPos >= Range.Min And EndPos <= Range.Max Then
		      Return True
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAutocomplete()
		  Var CurrentLine As String = Self.ConfigArea.CurrentLine.Trim
		  Var Position As Integer = Self.ConfigArea.PositionInLine
		  If Position = 0 Or Position <> CurrentLine.Length Or CurrentLine.IndexOf("=") > -1 Then
		    // Only show autocomplete if we are at the end of the line, and the line
		    // does not contain an equal sign
		    Self.ConfigArea.AutoCompleteCancel
		    Return
		  End If
		  
		  // Next, the word list should be based on the entire typed line
		  Var Matches() As String
		  Var MaxWidth As Integer
		  For Each Possible As String In Self.mAutocompleteWords
		    If Possible.BeginsWith(CurrentLine) Then
		      Matches.Add(Possible)
		      MaxWidth = Max(MaxWidth, Possible.Length)
		    End If
		  Next Possible
		  
		  If Matches.Count = 0 Then
		    Self.ConfigArea.AutoCompleteCancel
		    Return
		  End If
		  
		  Self.ConfigArea.AutoCompleteIgnoreCase = True
		  Self.ConfigArea.AutoCompleteMaxHeight = 9
		  Self.ConfigArea.AutoCompleteMaxWidth = 0
		  Self.ConfigArea.AutoCompleteSeparator = 32
		  Self.ConfigArea.AutoCompleteSetFillUps("=")
		  Self.ConfigArea.AutoCompleteShow(CurrentLine.Length, String.FromArray(Matches, " "))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleComment()
		  Var FirstLineNum As Integer = Self.ConfigArea.LineFromPosition(Self.ConfigArea.SelectionStart)
		  Var LastLineNum As Integer = Self.ConfigArea.LineFromPosition(Self.ConfigArea.SelectionEnd)
		  Var AddComment As Boolean = Not Self.SelectionIsCommented
		  
		  Var NewLines() As String
		  For LineNum As Integer = FirstLineNum To LastLineNum
		    Var Line As String = Self.ConfigArea.Line(LineNum)
		    If Line.BeginsWith("//") = True And AddComment = False Then
		      Line = Line.Middle(2).Trim
		    ElseIf Line.BeginsWith("//") = False And AddComment = True Then
		      Line = "// " + Line.Trim
		    Else
		      Line = Line.Trim
		    End If
		    NewLines.Add(Line)
		  Next LineNum
		  
		  Var EOL As String = Self.ConfigArea.Text.DetectLineEnding
		  Self.ConfigArea.SelectionStart = Self.ConfigArea.LineStart(FirstLineNum)
		  Self.ConfigArea.SelectionEnd = Self.ConfigArea.LineEndPosition(LastLineNum)
		  Self.ConfigArea.ReplaceSelection(String.FromArray(NewLines, EOL))
		  
		  // Select again when done
		  Self.ConfigArea.SelectionStart = Self.ConfigArea.LineStart(FirstLineNum)
		  Self.ConfigArea.SelectionEnd = Self.ConfigArea.LineEndPosition(LastLineNum)
		  
		  Self.UpdateCommentButton()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ToggleEncryption()
		  Var Tag As String = Palworld.Configs.CustomContent.EncryptedTag
		  Var TagLen As Integer = Tag.Length
		  Var Source As String = Self.ConfigArea.Text
		  
		  If Self.SelectionIsEncrypted Then
		    Var StartPos As Integer = Self.ConfigArea.SelectionStart
		    For I As Integer = StartPos DownTo TagLen
		      If Source.Middle((I - TagLen), TagLen) = Tag Then
		        StartPos = I
		        Exit For I
		      End If
		    Next
		    Var EndPos As Integer = Source.IndexOf(StartPos, Tag)
		    If EndPos = -1 Then
		      EndPos = Source.Length
		      Source = Source + Tag
		    End If
		    
		    Var ContentLen As Integer = EndPos - StartPos
		    Var Prefix As String = Source.Left(StartPos - TagLen)
		    Var Content As String = Source.Middle(StartPos, ContentLen)
		    Var Suffix As String = Source.Middle(EndPos + TagLen)
		    
		    Self.ConfigArea.Text = Prefix + Content + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length
		    Self.ConfigArea.SelectionLength = Content.Length
		  Else
		    Var Start As Integer = Self.ConfigArea.SelectionStart
		    Var Length As Integer = Self.ConfigArea.SelectionLength
		    Var Prefix As String = Source.Left(Start)
		    Var Content As String = Source.Middle(Start, Length)
		    Var Suffix As String = Source.Right(Source.Length - (Start + Length))
		    
		    Self.ConfigArea.Text = Prefix + Tag + Content + Tag + Suffix
		    Self.ConfigArea.SelectionStart = Prefix.Length + TagLen
		    Self.ConfigArea.SelectionLength = Content.Length
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateAutoComplete()
		  Var CurrentFile As String = Self.CurrentFile
		  Var CurrentHeader As String = Self.CurrentHeader
		  Var CurrentLocation As String = CurrentFile + ":" + CurrentHeader
		  If CurrentLocation = Self.mLastAutocompleteHeader Then
		    Return
		  End If
		  
		  Var Configs() As Palworld.ConfigOption = Palworld.DataSource.Pool.Get(False).GetConfigOptions(CurrentFile, CurrentHeader, "", "", False)
		  Self.mAutocompleteWords.ResizeTo(Configs.LastIndex)
		  For Idx As Integer = Configs.FirstIndex To Configs.LastIndex
		    Self.mAutocompleteWords(Idx) = Configs(Idx).Key
		  Next Idx
		  
		  Self.mLastAutocompleteHeader = CurrentLocation
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateCommentButton()
		  Var CommentButton As OmniBarItem = Self.ConfigToolbar.Item("CommentButton")
		  If CommentButton Is Nil Then
		    Return
		  End If
		  
		  If Self.SelectionIsCommented Then
		    CommentButton.HelpTag = "Uncomment the current line"
		    CommentButton.Caption = "Uncomment"
		    CommentButton.Icon = IconToolbarUncomment
		  Else
		    CommentButton.HelpTag = "Comment the current line"
		    CommentButton.Caption = "Comment"
		    CommentButton.Icon = IconToolbarComment
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateEncryptButton()
		  Var EncryptButton As OmniBarItem = Self.ConfigToolbar.Item("EncryptButton")
		  If EncryptButton Is Nil Then
		    Return
		  End If
		  
		  If Self.SelectionIsEncrypted Then
		    EncryptButton.HelpTag = "Convert the encrypted value to plain text"
		    EncryptButton.Caption = "Decrypt"
		    EncryptButton.Enabled = True
		    EncryptButton.Icon = IconToolbarUnlock
		  Else
		    EncryptButton.HelpTag = "Encrypt the selected text when saving"
		    EncryptButton.Caption = "Encrypt"
		    EncryptButton.Enabled = Self.ConfigArea.SelectionLength > 0
		    EncryptButton.Icon = IconToolbarLock
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateTextColors()
		  Self.mEncryptedRanges.ResizeTo(-1)
		  
		  Var Pos As Integer
		  Var Source As String = Self.ConfigArea.Text
		  Var Tag As String = Palworld.Configs.CustomContent.EncryptedTag
		  Var TagLen As Integer = Tag.Length
		  
		  Do
		    If Pos > Source.Length Then
		      Exit
		    End If
		    Pos = Source.IndexOf(Pos, Tag)
		    If Pos = -1 Then
		      Exit
		    End If
		    
		    Var StartPos As Integer = Pos + TagLen
		    Var EndPos As Integer = Source.IndexOf(StartPos, Tag)
		    If EndPos = -1 Then
		      EndPos = Source.Length
		    End If
		    
		    Self.mEncryptedRanges.Add(New Beacon.Range(StartPos, EndPos))
		    
		    Pos = EndPos + TagLen
		  Loop
		  
		  Self.UpdateEncryptButton()
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Return "SettingsIniButton"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var SettingsIniButton As OmniBarItem = Self.ConfigToolbar.Item("SettingsIniButton")
			  If (SettingsIniButton Is Nil) = False Then
			    SettingsIniButton.Toggled = True
			  End If
			End Set
		#tag EndSetter
		Private ActiveButtonName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAutocompleteWords() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCachedHeader As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCachedHeaderLine As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEncryptedRanges() As Beacon.Range
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastAutocompleteHeader As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingsIniState As TextAreaState
	#tag EndProperty


#tag EndWindowCode

#tag Events ConfigArea
	#tag Event
		Sub TextChanged()
		  Self.UpdateTextColors()
		  Self.UpdateAutoComplete()
		  
		  If Self.SettingUp Then
		    Return
		  End If
		  
		  Var SanitizedText As String = Beacon.SanitizeText(Me.Text)
		  If SanitizedText <> Me.Text Then
		    Var SelectionStart As Integer = Me.SelectionStart
		    Var SelectionLength As Integer = Me.SelectionLength
		    Me.Text = SanitizedText
		    Me.SelectionStart = SelectionStart
		    Me.SelectionLength = SelectionLength
		  End If
		  
		  Select Case Self.ActiveButtonName
		  Case "SettingsIniButton"
		    Self.Config(True).SettingsIniContent = SanitizedText
		    Self.Modified = True
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Self.UpdateEncryptButton()
		  Self.UpdateCommentButton()
		  Self.UpdateAutoComplete()
		End Sub
	#tag EndEvent
	#tag Event
		Sub CharacterAdded(Character as Integer, CharacterSource as Integer)
		  #Pragma Unused Character
		  #Pragma Unused CharacterSource
		  
		  If Me.SelectionEnd = Me.SelectionStart And Me.SelectionStart > 0 And Me.AutoCompleteActive = False Then
		    Self.ShowAutocomplete()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SetupNeeded()
		  Palworld.SetupCodeEditor(Me)
		End Sub
	#tag EndEvent
	#tag Event
		Sub DWellEnd(Position as Integer, X as Integer, Y as Integer)
		  #Pragma Unused Position
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Me.CallTipCancel
		End Sub
	#tag EndEvent
	#tag Event
		Sub DWellStart(Position as Integer, X as Integer, Y as Integer)
		  #Pragma Unused Position
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  If Position = -1 Then
		    Me.CallTipCancel
		    Return
		  End If
		  Var LineNum As Integer = Me.LineFromPosition(Position)
		  Var PositionInLine As Integer = Position - Me.LineStart(LineNum)
		  Var Line As String = Me.Line(LineNum).Trim
		  
		  Var EqualsPosition As Integer = Line.IndexOf("=")
		  If EqualsPosition = -1 Then
		    EqualsPosition = Line.Length
		  End If
		  
		  If PositionInLine > EqualsPosition Then 
		    Me.CallTipCancel
		    Return
		  End If
		  
		  Var Key As Palworld.ConfigOption = Palworld.DataSource.Pool.Get(False).GetConfigOption(Self.CurrentFile, Self.CurrentHeader, "", Line.Left(EqualsPosition))
		  If Key Is Nil Or Key.Description.IsEmpty Then
		    Me.CallTipCancel
		    Return
		  End If
		  
		  Me.CallTipShow(Me.LineStart(LineNum), Key.Description)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.MouseDwellTime = 1500
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateTab("SettingsIniButton", "PalWorldSettings.ini"))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("EncryptButton", "Encrypt", IconToolbarLock, "Encrypt the selected text when saving", False))
		  Me.Append(OmniBarItem.CreateButton("CommentButton", "Comment", IconToolbarComment, "Comment the current line"))
		  
		  Me.Item("SettingsIniButton").Toggled = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "EncryptButton"
		    Self.ToggleEncryption()
		  Case "CommentButton"
		    Self.ToggleComment()
		  Case "SettingsIniButton"
		    // Don't do anything
		    Return
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Modified"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composited"
		Visible=true
		Group="Window Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewTitle"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ViewIcon"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Progress"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Double"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowAutoDeactivate"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocusRing"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowFocus"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="AllowTabs"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Behavior"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="300"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="InitialParent"
		Visible=false
		Group="Position"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabPanelIndex"
		Visible=false
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabStop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
