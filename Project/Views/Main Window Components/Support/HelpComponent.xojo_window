#tag DesktopWindow
Begin BeaconSubview HelpComponent
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackgroundColor=   False
   Height          =   394
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
   Width           =   738
   Begin OmniBar BrowserButtonToolbar
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
      LockRight       =   False
      LockTop         =   True
      RightPadding    =   0
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   220
   End
   Begin OmniBarSeparator BrowserSeparator
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
      Left            =   220
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   518
   End
   Begin DesktopLabel BrowserTitleLabel
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
      Left            =   220
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   True
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Help"
      TextAlignment   =   2
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   10
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   298
   End
   Begin WebContentViewer HelpViewer
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   353
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   True
      Visible         =   True
      Width           =   738
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Shown(UserData As Variant = Nil)
		  #Pragma Unused UserData
		  
		  If Self.mHelpLoaded Then
		    Return
		  End If
		  
		  Self.LoadURL(Beacon.HelpURL)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub LoadURL(URL As String)
		  If BeaconUI.WebContentSupported = False Then
		    System.GotoURL(URL)
		    Return
		  End If
		  
		  Self.HelpViewer.LoadURL(URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShouldCancel(URL As String) As Boolean
		  If Beacon.IsBeaconURL(URL) Then
		    Call App.HandleURL(URL, True)
		    Return True
		  End If
		  
		  Static TicketURL As String
		  If TicketURL.IsEmpty Then
		    TicketURL = Beacon.WebURL("/help/contact")
		  End If
		  If URL = TicketURL Then
		    App.StartTicket()
		    Return True
		  End If
		  
		  Static DiscordDetector As Regex
		  If DiscordDetector Is Nil Then
		    DiscordDetector = New Regex
		    DiscordDetector.SearchPattern = "^https?://(.+\.)?((discord\.com)|(discord\.gg)|(discord\.media)|(discordapp\.com)|(discordapp\.net))/"
		  End If
		  Var Matches As RegexMatch = DiscordDetector.Search(URL)
		  If (Matches Is Nil) = False Then
		    System.GotoURL(URL)
		    Return True
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mHelpLoaded As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events BrowserButtonToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateButton("BackButton", "Back", IconToolbarBack, "", False))
		  Me.Append(OmniBarItem.CreateButton("ForwardButton", "Forward", IconToolbarForward, "", False))
		  Me.Append(OmniBarItem.CreateButton("HomeButton", "Home", IconToolbarHome, "", False))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "BackButton"
		    Self.HelpViewer.GoBack
		  Case "ForwardButton"
		    Self.HelpViewer.GoForward
		  Case "HomeButton"
		    Self.LoadURL(Beacon.HelpURL)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events HelpViewer
	#tag Event
		Function CancelLoad(URL As String) As Boolean
		  If Self.ShouldCancel(URL) Then
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub DocumentBegin(URL As String)
		  #Pragma Unused URL
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.HasProgressIndicator = True
		    Self.LinkedOmniBarItem.Progress = OmniBarItem.ProgressIndeterminate
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub DocumentComplete(URL As String)
		  #Pragma Unused URL
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.HasProgressIndicator = False
		  End If
		  Self.mHelpLoaded = True
		  
		  Var BackButton As OmniBarItem = Self.BrowserButtonToolbar.Item("BackButton")
		  If (BackButton Is Nil) = False Then
		    BackButton.Enabled = Me.CanGoBack
		  End If
		  
		  Var ForwardButton As OmniBarItem = Self.BrowserButtonToolbar.Item("ForwardButton")
		  If (ForwardButton Is Nil) = False Then
		    ForwardButton.Enabled = Me.CanGoForward
		  End If
		  
		  Var HomeButton As OmniBarItem = Self.BrowserButtonToolbar.Item("HomeButton")
		  If (HomeButton Is Nil) = False Then
		    HomeButton.Enabled = URL <> Beacon.HelpURL
		  End If
		  
		  Me.ExecuteJavaScript("beacon.pageLoaded('" + App.BuildNumber.ToString(Locale.Raw, "0") + "');")
		End Sub
	#tag EndEvent
	#tag Event
		Sub DocumentProgressChanged(URL As String, PercentageComplete As Integer)
		  #Pragma Unused URL
		  
		  If (Self.LinkedOmniBarItem Is Nil) = False Then
		    Self.LinkedOmniBarItem.Progress = PercentageComplete
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function JavaScriptRequest(Method As String, Parameters() As Variant) As String
		  Select Case Method
		  Case "openInBrowser"
		    Try
		      System.GotoURL(Parameters(0).StringValue)
		    Catch Err As RuntimeException
		      App.Log(Err, CurrentMethodName, "Trying to handle openInBrowser")
		    End Try
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Function NewWindow(URL As String) As WebContentViewer
		  System.GotoURL(URL)
		End Function
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.UserAgent = App.UserAgent
		End Sub
	#tag EndEvent
	#tag Event
		Sub TitleChanged(NewTitle As String)
		  Self.BrowserTitleLabel.Text = NewTitle
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
		Name="MinimumWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
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
		Name="IsFrontmost"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
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
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Position"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Position"
		InitialValue="False"
		Type="Boolean"
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
		Name="TabPanelIndex"
		Visible=false
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
		Name="AllowAutoDeactivate"
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
		Name="Tooltip"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
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
		Name="Transparent"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
