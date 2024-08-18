#tag DesktopWindow
Begin BeaconContainer ColumnBrowser
   AcceptFocus     =   "False"
   AcceptTabs      =   "True"
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   AutoDeactivate  =   "True"
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Composited      =   False
   DoubleBuffer    =   "False"
   Enabled         =   True
   EraseBackground =   "True"
   HasBackColor    =   False
   Height          =   300
   HelpTag         =   ""
   Index           =   -2147483648
   InitialParent   =   ""
   Left            =   0
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Tooltip         =   ""
   Top             =   0
   Transparent     =   True
   UseFocusRing    =   "False"
   Visible         =   True
   Width           =   300
   Begin DesktopScrollbar Scroller
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocus      =   True
      AllowLiveScrolling=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   15
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LineStep        =   200
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      MaximumValue    =   100
      MinimumValue    =   0
      PageStep        =   300
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   285
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   300
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin BeaconListbox Lists
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   2
      ColumnWidths    =   "30,*"
      DefaultRowHeight=   22
      DefaultSortColumn=   0
      DefaultSortDirection=   0
      DropIndicatorVisible=   False
      EditCaption     =   "Edit"
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   False
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   285
      Index           =   0
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   200
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin FadedSeparator Separators
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   285
      Index           =   0
      InitialParent   =   ""
      Left            =   200
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Self.MouseWheel(DeltaX, DeltaY)
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  RaiseEvent Open
		  Self.Reset()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma Unused Areas
		  
		  G.DrawingColor = &c000000EE
		  G.FillRectangle(0, 0, G.Width, G.Height)
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  Self.Scroller.PageStep = Self.Width
		  Self.UpdateScrollbarMaximum()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AppendChildren(Children() As String)
		  // Create new list if there is a selection
		  Var NewList As Boolean = Self.Lists(Self.mListBound).SelectedRowIndex > -1
		  Var TargetList As BeaconListbox
		  
		  If NewList Then
		    Var List As BeaconListbox = New Lists
		    Var Sep As FadedSeparator = New Separators
		    List.Left = Self.Separators(Self.mListBound).Left + Self.Separators(Self.mListBound).Width
		    List.Top = Self.Lists(0).Top
		    List.Height = Self.Lists(0).Height
		    List.Width = Self.Lists(0).Width
		    Sep.Left = List.Left + List.Width
		    Sep.Top = Self.Separators(0).Top
		    Sep.Height = Self.Separators(0).Height
		    Sep.Width = Self.Separators(0).Width
		    Self.mListBound = List.Index
		    TargetList = List
		    Self.UpdateScrollbarMaximum()
		    
		    // Animate the scroll
		    If Self.mScrollTask <> Nil Then
		      Self.mScrollTask.Cancel
		      Self.mScrollTask = Nil
		    End If
		    
		    If Self.Scroller.Value <> Self.Scroller.MaximumValue Then
		      Self.mScrollTask = New AnimationKit.ScrollTask(Self.Scroller)
		      Self.mScrollTask.DurationInSeconds = 0.15
		      Self.mScrollTask.Curve = AnimationKit.Curve.CreateEaseOut
		      Self.mScrollTask.Position = Self.Scroller.MaximumValue
		      Self.mScrollTask.Run
		    End If
		  Else
		    TargetList = Self.Lists(Self.mListBound)
		  End If
		  
		  // Fill new list
		  Self.FillList(TargetList, Self.mCurrentPath, Children)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FillList(List As BeaconListbox, Parent As String, Children() As String)
		  Var RestoreUpdating As Boolean = Self.mUpdating
		  Self.mUpdating = True
		  
		  List.RemoveAllRows
		  For I As Integer = 0 To Children.LastIndex  
		    Var Child As String = Children(I)
		    If Child.EndsWith("/") Then
		      Child = Child.Left(Child.Length - 1)
		    End If
		    
		    List.AddRow("", Child)
		    List.RowTagAt(List.LastAddedRowIndex) = Parent + Children(I)
		  Next
		  List.Sort
		  
		  Self.mUpdating = RestoreUpdating
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MouseWheel(DeltaX As Integer, DeltaY As Integer)
		  Var WheelData As New BeaconUI.ScrollEvent(Self.Scroller.LineStep, DeltaX, DeltaY)
		  Self.Scroller.Value = Self.Scroller.Value + WheelData.ScrollX
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  Self.Lists(0).SelectedRowIndex = -1
		  
		  Var DefaultChildren() As String
		  Self.AppendChildren(DefaultChildren)
		  
		  // Beacuse there is no selection, NeedsChildrenForPath will never fire, so fire it now
		  RaiseEvent NeedsChildrenForPath("/")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateScrollbarMaximum()
		  Var ContentWidth As Integer = ((Self.Lists(0).Width + Self.Separators(0).Width) * (Self.mListBound + 1)) - Self.Separators(0).Width
		  Var Overflow As Integer = Max(ContentWidth - Self.Width, 0)
		  
		  Var Position As Integer = Min(Self.Scroller.Value, Overflow)
		  If Self.Scroller.Value <> Position Then
		    Self.Scroller.Value = Position
		  End If
		  If Self.Scroller.MaximumValue <> Overflow Then
		    Self.Scroller.MaximumValue = Overflow
		  End If
		  
		  Var ListHeight As Integer
		  If Overflow = 0 And Self.Scroller.Visible Then
		    Self.Scroller.Visible = False
		    ListHeight = Self.Height
		  ElseIf Overflow > 0 And Self.Scroller.Visible = False Then
		    Self.Scroller.Visible = True
		    ListHeight = Self.Scroller.Top
		  Else
		    Return
		  End If
		  
		  For I As Integer = 0 To Self.mListBound
		    If Self.Lists(I).Height <> ListHeight Then
		      Self.Lists(I).Height = ListHeight
		    End If
		    If Self.Separators(I).Height <> ListHeight Then
		      Self.Separators(I).Height = ListHeight
		    End If
		  Next
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event NeedsChildrenForPath(Path As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PathSelected(Path As String)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCurrentPath
			End Get
		#tag EndGetter
		CurrentPath As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mCurrentPath As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mListBound As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollTask As AnimationKit.ScrollTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events Scroller
	#tag Event
		Sub ValueChanged()
		  Var Pos As Integer = Me.Value * -1
		  For I As Integer = 0 To Self.mListBound
		    Self.Lists(I).Left = Pos
		    Self.Separators(I).Left = Self.Lists(I).Left + Self.Lists(I).Width
		    Pos = Self.Separators(I).Left + Self.Separators(I).Width
		  Next
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseWheel(x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Self.MouseWheel(DeltaX, DeltaY)
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Lists
	#tag Event
		Sub SelectionChanged(index as Integer)
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Var NewPath As String
		  Var TriggerEvent As Boolean
		  If Me.SelectedRowIndex > -1 Then
		    NewPath = Me.RowTagAt(Me.SelectedRowIndex)
		    TriggerEvent = True
		  Else
		    If Index > 0 Then
		      NewPath = Self.Lists(Index - 1).RowTagAt(Self.Lists(Index - 1).SelectedRowIndex)
		    Else
		      NewPath = "/"
		    End If
		  End If
		  
		  If Self.mCurrentPath = NewPath Then
		    // No change
		    Return
		  End If
		  
		  // Delete all forward lists
		  For I As Integer = Self.mListBound DownTo Index + 1
		    Self.Lists(I).Close
		    Self.Separators(I).Close
		  Next
		  Self.mListBound = Index
		  
		  // To determine if a list gets added in NeedsChildrenForPath
		  Var StoredBound As Integer = Index
		  
		  // Raise the event
		  Self.mCurrentPath = NewPath
		  RaiseEvent PathSelected(NewPath)
		  If TriggerEvent And NewPath.EndsWith("/") Then
		    RaiseEvent NeedsChildrenForPath(NewPath)
		  End If
		  
		  // Update the scrollbar if the list bound has not changed
		  If Self.mListBound = StoredBound Then
		    Self.UpdateScrollbarMaximum()
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseWheel(index as Integer, x As Integer, y As Integer, deltaX As Integer, deltaY As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Self.MouseWheel(DeltaX, DeltaY)
		End Function
	#tag EndEvent
	#tag Event
		Sub PaintCellBackground(index as Integer, G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
		  #Pragma Unused Index
		  #Pragma Unused BackgroundColor
		  #Pragma Unused IsHighlighted
		  
		  If Column <> 0 Or Row >= Me.RowCount Then
		    Return
		  End If
		  
		  Var Path As String = Me.RowTagAt(Row)
		  Var IsDir As Boolean = Path.EndsWith("/")
		  Var Mask As Picture
		  If IsDir Then
		    Mask = IconFTPFolder
		  Else
		    Mask = IconFTPFile
		  End If
		  
		  Var Icon As Picture = BeaconUI.IconWithColor(Mask, TextColor)
		  G.DrawPicture(Icon, (G.Width - Icon.Width) / 2, (G.Height - Icon.Height) / 2)
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
	#tag ViewProperty
		Name="CurrentPath"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
#tag EndViewBehavior
