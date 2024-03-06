#tag DesktopWindow
Begin DesktopWindow WhatsNewWindow
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   True
   Height          =   413
   ImplicitInstance=   False
   MacProcID       =   0
   MaximumHeight   =   413
   MaximumWidth    =   660
   MenuBar         =   0
   MenuBarVisible  =   True
   MinimumHeight   =   413
   MinimumWidth    =   660
   Resizeable      =   False
   Title           =   "What's New in Beacon"
   Type            =   0
   Visible         =   False
   Width           =   660
   Begin URLConnection PreflightSocket
      AllowCertificateValidation=   False
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin WebContentViewer Viewer
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   413
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   False
      Width           =   660
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.mTopMargin = 20
		  Self.mLeftMargin = 20
		  Self.mBottomMargin = 20
		  Self.mRightMargin = 20
		  
		  #if false and TargetMacOS
		    Var Win As NSWindowMBS = Self.NSWindowMBS
		    Var FrameRect As NSRectMBS = Win.Frame
		    Var ContentRect As NSRectMBS = Win.ContentView.Frame
		    
		    Var TopBorder As Integer = FrameRect.Height - (ContentRect.Y + ContentRect.Height)
		    Var LeftBorder As Integer = ContentRect.X
		    Var BottomBorder As Integer = ContentRect.Y
		    Var RightBorder As Integer = FrameRect.Width - (ContentRect.X + ContentRect.Width)
		    
		    Self.mTopMargin = Max(Self.mTopMargin, TopBorder)
		    Self.mLeftMargin = Max(Self.mLeftMargin, LeftBorder)
		    Self.mBottomMargin = Max(Self.mBottomMargin, BottomBorder)
		    Self.mRightMargin = Max(Self.mRightMargin, RightBorder)
		    
		    Win.StyleMask = Win.StyleMask Or NSWindowMBS.NSFullSizeContentViewWindowMask
		    Win.TitlebarAppearsTransparent = True
		    Win.TitleVisibility = NSWindowMBS.NSWindowTitleHidden
		  #endif
		  
		  Var Platform As String
		  #if TargetMacOS
		    Platform = "macos"
		  #elseif TargetWindows
		    Platform = "windows"
		  #elseif TargetLinux
		    Platform = "linux"
		  #else
		    Platform = "any"
		  #endif
		  PreflightSocket.RequestHeader("User-Agent") = App.UserAgent
		  PreflightSocket.Send("HEAD", Beacon.WebURL("/welcome/?from=" + Self.mPreviousVersion.ToString("0") + "&to=" + App.BuildNumber.ToString + "&platform=" + Platform))
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub CloseLater()
		  Self.Close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(PreviousBuildNumber As Integer)
		  Self.mPreviousVersion = PreviousBuildNumber
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub Present(PreviousBuildNumber As Integer)
		  If PreviousBuildNumber < 99999999 And PreviousBuildNumber >= App.BuildNumber Then
		    // No reason to check
		    Return
		  End If
		  
		  // Immediately set the new build number just in case there is some sort of error loading the
		  // web content. If there is, it means one launch will crash but the next should have no issue continuing.
		  Preferences.NewestUsedBuild = Max(App.BuildNumber, Preferences.NewestUsedBuild)
		  
		  // Don't show the window, it'll do that if there is content to display
		  Var Win As New WhatsNewWindow(PreviousBuildNumber)
		  #Pragma Unused Win
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetTitle(NewTitle As String)
		  If Self.mPreviousVersion = 0 Then
		    Self.Title = NewTitle
		  Else
		    Self.Title = "What's new in Beacon: " + NewTitle
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ShouldCancel(URL As String) As Boolean
		  If URL.BeginsWith("beacon://finished") Then
		    Call CallLater.Schedule(1, AddressOf CloseLater)
		    Return True
		  ElseIf URL.BeginsWith("res://") Then
		    Return True
		  ElseIf URL.BeginsWith("https://") = False Then
		    Return True
		  End If
		  
		  If URL.BeginsWith(Beacon.WebURL("/welcome")) = False Then
		    System.GotoURL(URL)
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowConfirmedURL()
		  Try
		    Self.Viewer.LoadURL(Self.mConfirmedURL)
		  Catch Err As RuntimeException
		  End Try
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mBottomMargin As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConfirmedURL As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLeftMargin As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPreviousVersion As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRightMargin As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTopMargin As Integer
	#tag EndProperty


#tag EndWindowCode

#tag Events PreflightSocket
	#tag Event
		Sub Error(e As RuntimeException)
		  #Pragma Unused e
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub HeadersReceived(URL As String, HTTPStatus As Integer)
		  If HTTPStatus = 200 Then
		    Self.mConfirmedURL = URL.MakeUTF8
		    Self.Visible = True
		    Call CallLater.Schedule(250, AddressOf ShowConfirmedURL)
		  Else
		    Self.Close
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Viewer
	#tag Event
		Function CancelLoad(URL As String) As Boolean
		  If Self.ShouldCancel(URL) Then
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub DocumentComplete(URL As String)
		  #Pragma Unused URL
		  
		  Self.Visible = True
		  Me.Visible = True
		  Self.Show
		End Sub
	#tag EndEvent
	#tag Event
		Sub Error(Error As RuntimeException)
		  App.Log("Unable to load welcome content: " + Error.ErrorNumber.ToString("0") + ", " + Error.Message)
		  
		  Self.Close
		End Sub
	#tag EndEvent
	#tag Event
		Sub TitleChanged(NewTitle As String)
		  Self.SetTitle(NewTitle)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
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
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
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
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
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
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
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
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
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
#tag EndViewBehavior
