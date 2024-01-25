#tag DesktopWindow
Begin BeaconDialog PalworldExportWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   8
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   600
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   600
   MinimizeButton  =   False
   MinWidth        =   848
   Placement       =   1
   Resizable       =   "True"
   Resizeable      =   True
   SystemUIVisible =   "True"
   Title           =   "Export"
   Visible         =   True
   Width           =   848
   Begin UITweaks.ResizedPushButton ActionButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Finished"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   732
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   560
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   96
   End
   Begin CodeEditor ContentArea
      AutoDeactivate  =   True
      Enabled         =   True
      HasBorder       =   False
      Height          =   428
      HorizontalScrollPosition=   0
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      SelectionLength =   0
      ShowInfoBar     =   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   111
      VerticalScrollPosition=   0
      Visible         =   True
      Width           =   597
   End
   Begin FadedSeparator TopSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   60
      Transparent     =   True
      Visible         =   True
      Width           =   597
   End
   Begin UITweaks.ResizedPopupMenu ProfileMenu
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      SelectedRowIndex=   0
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   86
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   210
   End
   Begin DesktopProgressWheel RewritingSpinner
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   16
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   564
      Transparent     =   False
      Visible         =   False
      Width           =   16
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopLabel RewritingStatusLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "SmallSystem"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   16
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   48
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   17
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Building config…"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   564
      Transparent     =   False
      Underline       =   False
      Visible         =   False
      Width           =   182
   End
   Begin FadedSeparator LeftSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   600
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   250
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin Shelf Switcher
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      DrawCaptions    =   True
      Enabled         =   True
      Height          =   60
      Index           =   -2147483648
      InitialParent   =   ""
      IsVertical      =   False
      Left            =   251
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Visible         =   True
      Width           =   597
   End
   Begin OmniBar ExportToolbar
      Alignment       =   0
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      BackgroundColor =   ""
      ContentHeight   =   0
      Enabled         =   True
      Height          =   50
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
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
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   61
      Transparent     =   True
      Visible         =   True
      Width           =   597
   End
   Begin FadedSeparator BottomSeparator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   1
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   15
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   539
      Transparent     =   True
      Visible         =   True
      Width           =   597
   End
   Begin DesktopLabel SettingsHeaderLabel
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Export Settings"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   210
   End
   Begin DesktopLabel ProfileLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Server:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   60
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   210
   End
   Begin DesktopLabel ConfigSetsLabel
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Config Sets:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   126
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   210
   End
   Begin UITweaks.ResizedPushButton ConfigSetsButton
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Choose…"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   140
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   14
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   178
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   90
   End
   Begin UITweaks.ResizedLabel ConfigSetsField
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Base"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   152
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   210
   End
   Begin DesktopCheckBox ConfigSetsOverrideCheck
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   "Override Server's Config Sets"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   -81
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      VisualState     =   0
      Width           =   210
   End
   Begin Palworld.Rewriter SharedRewriter
      DebugIdentifier =   ""
      FinishedSettingsIniContent=   ""
      Index           =   -2147483648
      InitialSettingsIniContent=   ""
      LockedInPosition=   False
      Priority        =   5
      Scope           =   2
      Source          =   ""
      StackSize       =   0
      TabPanelIndex   =   0
      ThreadID        =   0
      ThreadState     =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Closing()
		  Self.SharedRewriter.Cancel
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CanCopy(Content As String, Filename As String, Verb As String = "Copy") As Boolean
		  Var MissingHeaders() As String = Palworld.ValidateIniContent(Content, Filename)
		  Var MissingCount As Integer = MissingHeaders.Count
		  If MissingCount > 0 Then
		    Var Message As String = "This content is missing required groups. Do you want to " + Verb.Lowercase + " it anyway?"
		    Var Explanation As String = "The " + MissingHeaders.EnglishOxfordList + " " + If(MissingCount = 1, "group is", "groups are") + " missing. Ark will not start up correctly if this file is used in its current state. Use the ""Smart Copy"" or ""Smart Save"" buttons to have Beacon correctly update your existing ini content."
		    Var Choice As BeaconUI.ConfirmResponses = Self.ShowConfirm(Message, Explanation, Verb + " Anyway", "Cancel", "Help")
		    Select Case Choice
		    Case BeaconUI.ConfirmResponses.Action
		      Return True
		    Case BeaconUI.ConfirmResponses.Cancel
		      Return False
		    Case BeaconUI.ConfirmResponses.Alternate
		      System.GotoURL(Beacon.WebURL("/help/updating_your_server_manually"))
		      Return False
		    End Select
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckButtons()
		  If Self.ExportToolbar.IndexOf("SmartCopy") = -1 Then
		    Return
		  End If
		  
		  Var SmartButtonsEnabled As Boolean = Self.IsRewriting = False And Self.CurrentMode.IsEmpty = False
		  Self.ExportToolbar.Item("SmartCopy").Enabled = SmartButtonsEnabled
		  Self.ExportToolbar.Item("SmartSave").Enabled = SmartButtonsEnabled
		  
		  Self.ExportToolbar.Item("LazyCopy").Enabled = Self.CurrentContent.IsEmpty = False
		  Self.ExportToolbar.Item("LazySave").Enabled = Self.ExportToolbar.Item("LazyCopy").Enabled And Self.CurrentMode <> ""
		  
		  Var Rewriting As Boolean = Self.IsRewriting
		  If Self.RewritingSpinner.Visible <> Rewriting Then
		    Self.RewritingSpinner.Visible = Rewriting
		    Self.RewritingStatusLabel.Visible = Rewriting
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DoCopy()
		  Var Content As String = Self.CurrentContent
		  If Not Self.CanCopy(Content, Self.CurrentFilename) Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  Board.Text = Content
		  Self.mLastRewrittenHash = EncodeHex(MD5(Board.Text))
		  
		  Self.ShowAlert(Self.CurrentFilename + " has been copied!", "You are ready to paste it wherever you need it.")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DoSave()
		  If Not Self.CanCopy(Self.CurrentContent, Self.CurrentFilename, "Save") Then
		    Return
		  End If
		  
		  Var Dialog As New SaveFileDialog
		  Dialog.Filter = BeaconFileTypes.IniFile
		  Dialog.SuggestedFileName = Self.CurrentFilename
		  If Dialog.SuggestedFileName = "" Then
		    Return
		  End If
		  
		  Var File As FolderItem = Dialog.ShowModal()
		  If File Is Nil Then
		    Return
		  End If
		  
		  Try
		    File.Write(Self.CurrentContent)
		  Catch Err As RuntimeException
		    Self.ShowAlert("Unable to write to " + File.DisplayName, "Check file permissions and disk space.")
		  End Try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DoSmartCopy()
		  If Self.IsRewriting Then
		    // Busy
		    Self.ShowAlert(Self.RewriterBusyMessage, Self.RewriterBusyExplanation)
		    Return
		  End If
		  
		  Var Mode As String = Self.CurrentMode
		  If Mode.IsEmpty Then
		    Self.ShowAlert(SmartCopyUnavailableMessage, SmartCopyUnavailableExplanation)
		    Return
		  End If
		  
		  Var Filename As String = Self.CurrentFilename
		  Var Board As New Clipboard
		  If Board.TextAvailable = False Then
		    Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyInstructionsMessage, Filename), Language.ReplacePlaceholders(SmartCopyInstructionsExplanation, Filename))
		    Return
		  End If
		  
		  Var RequiredHeader() As String
		  Select Case Self.CurrentMode
		  Case Palworld.Rewriter.ModeSettingsIni
		    RequiredHeader = Array(Palworld.HeaderPalworldSettings)
		  Else
		    Return
		  End Select
		  
		  Var ClipboardContents As String = Board.Text
		  Var HeaderFound As Boolean
		  For Each Header As String In RequiredHeader
		    If ClipboardContents.IndexOf("[" + Header + "]") > -1 Then
		      HeaderFound = True
		      Exit
		    End If
		  Next Header
		  If HeaderFound = False Then
		    Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyInstructionsMessage, Filename), Language.ReplacePlaceholders(SmartCopyInstructionsExplanation, Filename))
		    Return
		  End If
		  
		  If EncodeHex(Crypto.SHA2_256(ClipboardContents)) = Self.mLastRewrittenHash Then
		    Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyReadyMessage, Filename), Language.ReplacePlaceholders(SmartCopyReadyExplanation, Filename))
		    Return
		  End If
		  
		  Self.mLastRewrittenHash = ""
		  Self.mCopyWhenFinished = True
		  
		  Select Case Self.CurrentMode
		  Case Palworld.Rewriter.ModeSettingsIni
		    Self.SharedRewriter.InitialSettingsIniContent = ClipboardContents
		    Self.SharedRewriter.Source = Palworld.Rewriter.Sources.SmartCopy
		    Self.SharedRewriter.Rewrite(Palworld.Rewriter.FlagCreateSettingsIni Or If(Self.mForceTrollMode, Palworld.Rewriter.FlagForceTrollMode, 0))
		  End Select
		  
		  Self.CheckButtons()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DoSmartSave()
		  If Self.IsRewriting Then
		    // Busy
		    Self.ShowAlert(Self.RewriterBusyMessage, Self.RewriterBusyExplanation)
		    Return
		  End If
		  
		  Var RequiredHeader() As String
		  Select Case Self.CurrentMode
		  Case Palworld.Rewriter.ModeSettingsIni
		    RequiredHeader = Array(Palworld.HeaderPalworldSettings)
		  Else
		    Return
		  End Select
		  
		  Var Dialog As New OpenFileDialog
		  Dialog.Filter = BeaconFileTypes.IniFile
		  Dialog.SuggestedFileName = Self.CurrentFilename
		  Dialog.ActionButtonCaption = "Update"
		  
		  Var File As FolderItem = Dialog.ShowModal()
		  If File = Nil Or Not File.Exists Then
		    Return
		  End If
		  
		  Var Content As String
		  Try
		    Var InStream As TextInputStream = TextInputStream.Open(File)
		    Content = InStream.ReadAll()
		    InStream.Close
		  Catch Err As RuntimeException
		    Self.ShowAlert("Unable to open " + File.DisplayName, "Beacon was unable to read the current content of the file to rewriting. The file has not been changed.")
		    Return
		  End Try
		  Content = Content.GuessEncoding("/Script/")
		  
		  Var HeaderFound As Boolean
		  For Each Header As String In RequiredHeader
		    If Content.IndexOf("[" + Header + "]") > -1 Then
		      HeaderFound = True
		      Exit
		    End If
		  Next Header
		  If HeaderFound = False Then
		    Self.ShowAlert("Incorrect ini file detected.", "Beacon is expecting to find the " + Language.EnglishOxfordList(RequiredHeader, "or") + " header in this file before rewriting, but cannot find it. Make sure you select the correct file config file.")
		    Return
		  End If
		  
		  Self.mFileDestination = File
		  
		  Select Case Self.CurrentMode
		  Case Palworld.Rewriter.ModeSettingsIni
		    Self.SharedRewriter.InitialSettingsIniContent = Content
		    Self.SharedRewriter.Source = Palworld.Rewriter.Sources.SmartSave
		    Self.SharedRewriter.Rewrite(Palworld.Rewriter.FlagCreateSettingsIni Or If(Self.mForceTrollMode, Palworld.Rewriter.FlagForceTrollMode, 0))
		  End Select
		  
		  Self.CheckButtons()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Finish(Content As String)
		  If Self.mCopyWhenFinished Then
		    Var Board As New Clipboard
		    Board.Text = Content
		    Self.mLastRewrittenHash = EncodeHex(Crypto.SHA2_256(Content)).Lowercase
		    Self.ShowAlert(Language.ReplacePlaceholders(SmartCopyReadyMessage, "ini"), Language.ReplacePlaceholders(SmartCopyReadyExplanation, "ini"))
		    Return
		  End If
		  
		  If (Self.mFileDestination Is Nil) = False Then
		    Try
		      Self.mFileDestination.Write(Content)
		    Catch Err As RuntimeException
		      Self.ShowAlert("Unable to update file", "There was an error trying to rewrite the ini content in the selected file.")
		    End Try
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsRewriting() As Boolean
		  Return Self.SharedRewriter.ThreadState <> Thread.ThreadStates.NotRunning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(Parent As DesktopWindow, Project As Palworld.Project, ForceTrollMode As Boolean = False)
		  If (Parent Is Nil) = False Then
		    Parent = Parent.TrueWindow
		  End If
		  
		  Var Win As New PalworldExportWindow
		  Win.mProject = Project
		  Win.mForceTrollMode = ForceTrollMode
		  
		  If ForceTrollMode Then
		    TrollActivated.Play
		  End If
		  
		  Var ProfileBound As Integer = Project.ServerProfileCount - 1
		  If ProfileBound > -1 Then
		    For I As Integer = 0 To ProfileBound
		      Var Profile As Beacon.ServerProfile = Project.ServerProfile(I)
		      Win.ProfileMenu.AddRow(Profile.Name, Profile)
		    Next
		    
		    Var ConfigLabelTop As Integer = Win.ConfigSetsLabel.Top
		    Win.ConfigSetsLabel.Top = Win.ConfigSetsOverrideCheck.Top
		    Win.ConfigSetsOverrideCheck.Top = ConfigLabelTop
		    Win.ConfigSetsField.Enabled = Win.ConfigSetsOverrideCheck.Value
		    Win.ConfigSetsButton.Enabled = Win.ConfigSetsOverrideCheck.Value
		    
		    Win.ProfileMenu.SelectedRowIndex = 0
		  Else
		    Win.ProfileMenu.SelectedRowIndex = -1
		    Win.ProfileMenu.Enabled = False
		    Win.ProfileLabel.Enabled = False
		  End If
		  
		  Win.UpdateConfigSetControls()
		  
		  Win.Setup()
		  Win.ShowModal(Parent)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RefreshContentArea()
		  Var IntendedContent As String
		  Select Case Self.Switcher.SelectedIndex
		  Case 1
		    IntendedContent = Self.mSettingsIniContent
		  End Select
		  If Self.CurrentContent <> IntendedContent Then
		    Self.CurrentContent = IntendedContent
		    Self.ContentArea.HorizontalScrollPosition = 0
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetClipboardButtonCaption(Enabled As Boolean, Caption As String)
		  If Self.ExportToolbar = Nil Then
		    Return
		  End If
		  
		  If Self.ExportToolbar.Item("SmartCopy").Enabled <> Enabled Then
		    Self.ExportToolbar.Item("SmartCopy").Enabled = Enabled
		  End If
		  If Self.ExportToolbar.Item("SmartCopy").Caption <> Caption Then
		    Self.ExportToolbar.Item("SmartCopy").Caption = Caption
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Setup()
		  If Self.mProject = Nil Or Self.IsRewriting Then
		    Return
		  End If
		  
		  Var Profile As Palworld.ServerProfile
		  If Self.ProfileMenu.SelectedRowIndex > -1 Then
		    Profile = Palworld.ServerProfile(Self.ProfileMenu.RowTagAt(Self.ProfileMenu.SelectedRowIndex)).Clone // We need to work on a copy
		  Else
		    Profile = New Palworld.ServerProfile(Local.Identifier, Self.mProject.Title)
		  End If
		  If Self.ConfigSetsOverrideCheck.Value Then
		    Profile.ConfigSetStates = Self.mProject.ConfigSetPriorities
		  End If
		  Self.mCurrentProfile = Profile
		  
		  Self.mSettingsIniContent = ""
		  Self.mLastRewrittenHash = ""
		  Self.mFileDestination = Nil
		  Self.mCopyWhenFinished = False
		  
		  Self.SharedRewriter.Cancel
		  Self.SharedRewriter.InitialSettingsIniContent = ""
		  Self.SharedRewriter.Source = Palworld.Rewriter.Sources.Original
		  Self.SharedRewriter.Project = Self.mProject
		  Self.SharedRewriter.Identity = App.IdentityManager.CurrentIdentity
		  Self.SharedRewriter.Profile = Self.mCurrentProfile
		  
		  Try
		    If Profile.ProviderId = Local.Identifier Then
		      Var SettingsIniPath As String = Profile.SettingsIniPath
		      
		      If SettingsIniPath.IsEmpty = False Then
		        Var SettingsIniFile As BookmarkedFolderItem = BookmarkedFolderItem.FromSaveInfo(SettingsIniPath)
		        If (SettingsIniFile Is Nil) = False And SettingsIniFile.Exists Then
		          Self.SharedRewriter.InitialSettingsIniContent = SettingsIniFile.Read
		        End If
		      End If
		    End If
		  Catch Err As RuntimeException
		    // It's not important
		  End Try
		  
		  Self.SharedRewriter.Rewrite(Palworld.Rewriter.FlagCreateSettingsIni Or If(Self.mForceTrollMode, Palworld.Rewriter.FlagForceTrollMode, 0))
		  
		  Self.RefreshContentArea()
		  Self.CheckButtons()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateConfigSetControls()
		  If Self.mProject.ConfigSetCount > 1 Then
		    Var Sets() As Beacon.ConfigSet = Beacon.ConfigSetState.FilterSets(Self.mProject.ConfigSetPriorities, Self.mProject.ConfigSets)
		    Var EnabledSets() As String
		    For Each Set As Beacon.ConfigSet In Sets
		      EnabledSets.Add(Set.Name)
		    Next
		    
		    Self.ConfigSetsField.Text = EnabledSets.EnglishOxfordList()
		  Else
		    Self.ConfigSetsField.Text = Beacon.ConfigSet.BaseConfigSet.Name
		    Self.ConfigSetsField.Enabled = False
		    Self.ConfigSetsButton.Enabled = False
		    Self.ConfigSetsLabel.Enabled = False
		  End If
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentContent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Value.ReplaceLineEndings(EndOfLine)
			  If Self.mCurrentContent <> Value Then
			    Self.mCurrentContent = Value
			    Self.ContentArea.Text = Value
			  End If
			End Set
		#tag EndSetter
		CurrentContent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If Self.Switcher = Nil Then
			    Return ""
			  End If
			  
			  Select Case Self.Switcher.SelectedIndex
			  Case 1
			    Return Palworld.HeaderPalworldSettings
			  End Select
			End Get
		#tag EndGetter
		Private CurrentDefaultHeader As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  Select Case Self.Switcher.SelectedIndex
			  Case 1
			    Return Palworld.ConfigFileSettings
			  Else
			    Return ""
			  End Select
			End Get
		#tag EndGetter
		Private CurrentFilename As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  If Self.Switcher = Nil Then
			    Return ""
			  End If
			  
			  Select Case Self.Switcher.SelectedIndex
			  Case 1
			    Return Palworld.Rewriter.ModeSettingsIni
			  End Select
			End Get
		#tag EndGetter
		Private CurrentMode As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCopyWhenFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCurrentProfile As Palworld.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFileDestination As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mForceTrollMode As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastRewrittenHash As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Palworld.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSettingsIniContent As String
	#tag EndProperty


	#tag Constant, Name = RewriterBusyExplanation, Type = String, Dynamic = False, Default = \"Beacon\'s ini generator is busy creating your content. Wait a moment\x2C and try again.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = RewriterBusyMessage, Type = String, Dynamic = False, Default = \"Please try again in a moment", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyErrorExplanation, Type = String, Dynamic = False, Default = \"Smart Copy was unable to prepare your \?1 file. No changes have been made.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyErrorMessage, Type = String, Dynamic = False, Default = \"Smart Copy encountered an error.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyInstructionsExplanation, Type = String, Dynamic = False, Default = \"Once you have copied your \?1 contents\x2C return here and press the Smart Copy button again.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyInstructionsMessage, Type = String, Dynamic = False, Default = \"To use Smart Copy\x2C first copy your entire \?1 file.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyReadyExplanation, Type = String, Dynamic = False, Default = \"You are now ready to paste your \?1 content wherever you need it.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyReadyMessage, Type = String, Dynamic = False, Default = \"Your \?1 content has been copied.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyUnavailableExplanation, Type = String, Dynamic = False, Default = \"Smart Copy can only be used with PalWorldSettings.ini content.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SmartCopyUnavailableMessage, Type = String, Dynamic = False, Default = \"Smart Copy is not available for this content.", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UpdatingClipboard, Type = String, Dynamic = False, Default = \"Working\xE2\x80\xA6", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events ActionButton
	#tag Event
		Sub Pressed()
		  Self.Close()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ContentArea
	#tag Event
		Function ShouldCopy() As Boolean
		  If Me.SelectionLength <> Me.Text.Length Then
		    Return True
		  End If
		  
		  Var Content As String = Me.Text
		  Return Self.CanCopy(Content, Self.CurrentFilename)
		End Function
	#tag EndEvent
	#tag Event
		Sub SetupNeeded()
		  Palworld.SetupCodeEditor(Me)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.ReadOnly = True
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ProfileMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  #Pragma Unused Item
		  
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Switcher
	#tag Event
		Sub Opening()
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.Add(IconFileIni, Palworld.ConfigFileSettings, Palworld.ConfigFileSettings)
		  Me.Add(ShelfItem.NewFlexibleSpacer)
		  Me.SelectedIndex = 1
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed()
		  Self.RefreshContentArea()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ExportToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("SmartCopy", "Smart Copy", IconToolbarSmartCopy, "Uses your copied ini file to correctly copy the updated version."))
		  Me.Append(OmniBarItem.CreateButton("SmartSave", "Smart Save", IconToolbarSmartSaveToDisk, "Allows you to select a file on your computer which Beacon will update with the latest changes."))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("LazyCopy", "Copy", IconToolbarCopy, "Copies the current ini content to your clipboard."))
		  Me.Append(OmniBarItem.CreateButton("LazySave", "Save", IconToolbarSaveToDisk, "Saves the current ini content to your computer."))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "SmartCopy"
		    Self.DoSmartCopy()
		  Case "SmartSave"
		    Self.DoSmartSave()
		  Case "LazyCopy"
		    Self.DoCopy()
		  Case "LazySave"
		    Self.DoSave()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigSetsButton
	#tag Event
		Sub Pressed()
		  Var Sets() As Beacon.ConfigSet = Self.mProject.ConfigSets
		  Var States() As Beacon.ConfigSetState = Self.mProject.ConfigSetPriorities
		  If ConfigSetSelectorDialog.Present(Self, Sets, States) Then
		    Self.mProject.ConfigSetPriorities = States
		  End If
		  
		  Self.UpdateConfigSetControls()
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigSetsOverrideCheck
	#tag Event
		Sub ValueChanged()
		  Self.ConfigSetsField.Enabled = Me.Value
		  Self.ConfigSetsButton.Enabled = Me.Value
		  Self.Setup()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SharedRewriter
	#tag Event
		Sub Finished()
		  If Me.Errored Then
		    Break
		  Else
		    Var SpecialFinish As Boolean = (Self.mFileDestination Is Nil) = False Or Self.mCopyWhenFinished
		    If (Me.OutputFlags And Palworld.Rewriter.FlagCreateSettingsIni) = Palworld.Rewriter.FlagCreateSettingsIni Then
		      If SpecialFinish Then
		        Self.Finish(Me.FinishedSettingsIniContent)
		      Else
		        Self.mSettingsIniContent = Me.FinishedSettingsIniContent
		      End If
		    End If
		  End If
		  
		  Self.mFileDestination = Nil
		  Self.mCopyWhenFinished = False
		  
		  Self.RefreshContentArea()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
	#tag Event
		Sub Started()
		  Self.CheckButtons()
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
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
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Interfaces"
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
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="CurrentContent"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
