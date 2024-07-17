#tag Class
Protected Class BeaconListbox
Inherits DesktopListBox
	#tag CompatibilityFlags = ( TargetDesktop and ( Target32Bit or Target64Bit ) )
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If Self.mCellActionCascading Then
		    // Looks like CellCheckBoxValueAt does not trigger CellAction, but just in case
		    Return
		  End If
		  
		  Self.mCellActionCascading = True
		  RaiseEvent BulkColumnChangeStarted(Column)
		  RaiseEvent CellAction(Row, Column)
		  
		  If Self.CellTypeAt(Row, Column) = DesktopListbox.CellTypes.CheckBox And (TargetMacOS And Keyboard.AsyncCommandKey) Or (Not TargetMacOS And Keyboard.AsyncControlKey) Then
		    Var DesiredValue As Boolean = Self.CellCheckBoxValueAt(Row, Column)
		    For Idx As Integer = Self.LastRowIndex DownTo 0
		      If Idx <> Row And Self.CellCheckBoxValueAt(Idx, Column) <> DesiredValue Then
		        Self.CellCheckBoxValueAt(Idx, Column) = DesiredValue
		        RaiseEvent CellAction(Idx, Column)
		      End If
		    Next
		  End If
		  
		  Self.mCellActionCascading = False
		  RaiseEvent BulkColumnChangeFinished(Column)
		End Sub
	#tag EndEvent

	#tag Event
		Function ConstructContextualMenu(base As DesktopMenuItem, x As Integer, y As Integer) As Boolean
		  Var Board As New Clipboard
		  Var CanEdit As Boolean = RaiseEvent CanEdit()
		  Var CanCopy As Boolean = RaiseEvent CanCopy()
		  Var CanDelete As Boolean = RaiseEvent CanDelete()
		  Var CanPaste As Boolean = RaiseEvent CanPaste(Board)
		  
		  Var EditItem As New DesktopMenuItem(Self.mEditCaption, "edit")
		  EditItem.Enabled = CanEdit
		  Base.AddMenu(EditItem)
		  
		  Base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  
		  Var CutItem As New DesktopMenuItem("Cut", "cut")
		  CutItem.Shortcut = "X"
		  CutItem.Enabled = CanCopy And CanDelete
		  Base.AddMenu(CutItem)
		  
		  Var CopyItem As New DesktopMenuItem("Copy", "copy")
		  CopyItem.Shortcut = "C"
		  CopyItem.Enabled = CanCopy
		  Base.AddMenu(CopyItem)
		  
		  Var PasteItem As New DesktopMenuItem("Paste", "paste")
		  PasteItem.Shortcut = "V"
		  PasteItem.Enabled = CanPaste
		  Base.AddMenu(PasteItem)
		  
		  Var DeleteItem As New DesktopMenuItem("Delete", "clear")
		  DeleteItem.Enabled = CanDelete
		  Base.AddMenu(DeleteItem)
		  
		  Self.HandleToggleMenu(Base, X, Y)
		  
		  Var Children As New DesktopMenuItem
		  Call ConstructContextualMenu(Children, X, Y)
		  If Children.Count = 0 Then
		    Return True
		  End If
		  
		  Var Items() As DesktopMenuItem
		  For Idx As Integer = 0 To Children.LastRowIndex
		    Items.Add(Children.MenuAt(Idx))
		  Next
		  Children.RemoveAllRows
		  
		  Base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  
		  For Each Item As DesktopMenuItem In Items
		    Base.AddMenu(Item)
		  Next
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuItemSelected(selectedItem As DesktopMenuItem) As Boolean
		  If SelectedItem.Tag.IsNull = False Then
		    Select Case SelectedItem.Tag.Type
		    Case Variant.TypeString
		      Select Case SelectedItem.Tag.StringValue
		      Case "edit"
		        Self.DoEdit()
		        Return True
		      Case "cut"
		        Self.DoCut()
		        Return True
		      Case "copy"
		        Self.DoCopy()
		        Return True
		      Case "paste"
		        Self.DoPaste()
		        Return True
		      Case "clear"
		        Self.DoClear()
		        Return True
		      End Select
		    Case Variant.TypeObject
		      If SelectedItem.Tag.ObjectValue IsA Dictionary And Dictionary(SelectedItem.Tag.ObjectValue).HasKey("Action") Then
		        Var ActionInfo As Dictionary = SelectedItem.Tag
		        Select Case ActionInfo.Value("Action").StringValue
		        Case "ToggleColumn"
		          Var Column As Integer = ActionInfo.Value("Column")
		          Var DesiredValue As Boolean = ActionInfo.Value("DesiredValue")
		          For Idx As Integer = Self.LastRowIndex DownTo 0
		            If Self.CellCheckBoxValueAt(Idx, Column) <> DesiredValue Then
		              Self.CellCheckBoxValueAt(Idx, Column) = DesiredValue
		              RaiseEvent CellAction(Idx, Column)
		            End If
		          Next
		          Return True
		        End Select
		      End If
		    End Select
		  End If
		  
		  Return ContextualMenuItemSelected(SelectedItem)
		End Function
	#tag EndEvent

	#tag Event
		Sub DoublePressed()
		  If Self.SelectedRowCount <> Self.mLastChangeCount Or Self.SelectedRowIndex <> Self.mLastChangeIndex Then
		    // Rapidly changing rows, act as regular click
		    Self.HandleChange()
		    Return
		  End If
		  
		  If IsEventImplemented("DoublePressed") Then
		    RaiseEvent DoublePressed
		  Else
		    If Self.CanEdit Then
		      Self.DoEdit
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function HeaderPressed(column as Integer) As Boolean
		  If RaiseEvent HeaderPressed(Column) Then
		    Return True
		  End If
		  
		  If Self.mOpened = False Or Self.PreferencesKey.IsEmpty Then
		    Return False
		  End If
		  
		  Preferences.ListSortColumn(Self.PreferencesKey) = Column
		  Preferences.ListSortDirection(Self.PreferencesKey) = Self.ColumnSortDirectionAt(Column)
		End Function
	#tag EndEvent

	#tag Event
		Function KeyDown(key As String) As Boolean
		  Self.mForwardKeyUp = False
		  
		  If (Key = Encodings.UTF8.Chr(8) Or Key = Encodings.UTF8.Chr(127)) And Self.CanDelete() Then
		    Self.DoClear()
		    Return True
		  ElseIf (Key = Encodings.UTF8.Chr(10) Or Key = Encodings.UTF8.Chr(13)) And Self.CanEdit() Then
		    Self.DoEdit()
		    Return True
		  ElseIf Key = Encodings.UTF8.Chr(30) Then // Up Arrow
		    Var MinIndex As Integer = Self.MinSelectedRow()
		    If MinIndex > 0 Then
		      If Self.RowSelectionType = DesktopListbox.RowSelectionTypes.Multiple And Keyboard.ShiftKey Then
		        Self.RowSelectedAt(MinIndex - 1) = True
		      Else
		        Self.SelectedRowIndex = MinIndex - 1
		      End
		    Else
		      System.Beep
		    End If
		    Return True
		  ElseIf Key = Encodings.UTF8.Chr(31) Then // Down Arrow
		    Var MaxIndex As Integer = Self.MaxSelectedRow()
		    If MaxIndex < Self.LastRowIndex Then
		      If Self.RowSelectionType = DesktopListbox.RowSelectionTypes.Multiple And Keyboard.ShiftKey Then
		        Self.RowSelectedAt(MaxIndex + 1) = True
		      Else
		        Self.SelectedRowIndex = MaxIndex + 1
		      End
		    Else
		      System.Beep
		    End If
		    Return True
		  ElseIf Key = Encodings.UTF8.Chr(9) Then // Tab
		    Return False
		  ElseIf RaiseEvent KeyDown(Key) Then
		    Self.mForwardKeyUp = True
		  Else
		    Self.mTypeaheadBuffer = Self.mTypeaheadBuffer + Key
		    If Self.mTypeaheadTimer.RunMode = Timer.RunModes.Off Then
		      Self.mTypeaheadTimer.RunMode = Timer.RunModes.Single
		    End If
		    Self.mTypeaheadTimer.Reset
		    Self.mTypeaheadTimer.Period = 1000
		    
		    If Not RaiseEvent Typeahead(Self.mTypeaheadBuffer) Then
		      For Idx As Integer = 0 To Self.LastRowIndex
		        If Self.CellTextAt(Idx, Self.TypeaheadColumn).BeginsWith(Self.mTypeaheadBuffer) Then
		          Self.SelectedRowIndex = Idx
		          Self.EnsureSelectionIsVisible()
		          Exit
		        End If
		      Next
		    End If
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub KeyUp(key As String)
		  If Self.mForwardKeyUp Then
		    RaiseEvent KeyUp(Key)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MenuBarSelected()
		  If Self.Window = Nil Or Self.Window.Focus <> Self Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  Var CanCopy As Boolean = RaiseEvent CanCopy()
		  Var CanDelete As Boolean = RaiseEvent CanDelete()
		  Var CanPaste As Boolean = RaiseEvent CanPaste(Board)
		  
		  EditCopy.Enabled = CanCopy
		  EditCut.Enabled = CanCopy And CanDelete
		  EditClear.Enabled = CanDelete
		  EditPaste.Enabled = CanPaste
		  
		  RaiseEvent EnableMenuItems
		End Sub
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Self.FontName = "SmallSystem"
		  Self.DefaultRowHeight = Max(26, Self.DefaultRowHeight)
		  
		  If Not Self.PreferencesKey.IsEmpty Then
		    Var Column As Integer = Preferences.ListSortColumn(Self.PreferencesKey, Self.DefaultSortColumn)
		    Var Direction As DesktopListbox.SortDirections = Preferences.ListSortDirection(Self.PreferencesKey, CType(Self.DefaultSortDirection, DesktopListbox.SortDirections))
		    Self.SortingColumn = Column
		    Self.HeadingIndex = Column
		    Self.ColumnSortDirectionAt(Column) = Direction
		  End If
		  
		  If Self.HasBorder = False Then
		    Self.AllowFocusRing = False
		  End If
		  
		  RaiseEvent Opening
		  
		  Self.Transparent = False
		  
		  Self.mPostOpenInvalidateCallbackKey = CallLater.Schedule(0, WeakAddressOf PostOpenInvalidate)
		  Self.mOpened = True
		End Sub
	#tag EndEvent

	#tag Event
		Function PaintCellBackground(g As Graphics, row As Integer, column As Integer) As Boolean
		  #Pragma Unused Column
		  
		  Const InsetAmount = 10
		  Const CornerRadius = 8
		  
		  Var ColumnWidth As Integer = Self.ColumnAttributesAt(Column).WidthActual
		  Var RowHeight As Integer = Self.DefaultRowHeight
		  
		  Var RowInvalid, RowSelected, NextRowSelected, PreviousRowSelected As Boolean
		  If Row < Self.RowCount Then
		    RowInvalid = RowIsInvalid(Row)
		    RowSelected = Self.RowSelectedAt(Row)
		    If RowSelected Then
		      PreviousRowSelected = Row > 0 And Row <= Self.LastRowIndex And Self.RowSelectedAt(Row - 1)
		      NextRowSelected = Row >= 0 And Row < Self.LastRowIndex And Self.RowSelectedAt(Row + 1)
		    End If
		  End If
		  
		  // Make the listbox transparent
		  If Self.Transparent Then
		    G.ClearRectangle(0, 0, G.Width, G.Height)
		  End If
		  
		  Var InsetLeft, InsetRight As Integer 
		  #if UseRoundedRows
		    If Column = 0 And Self.ColumnTypeAt(0) <> Listbox.CellTypes.CheckBox Then
		      InsetLeft = InsetAmount
		    End If
		    If Column = Self.ColumnCount - 1 And Self.ColumnTypeAt(0) <> Listbox.CellTypes.CheckBox Then
		      InsetRight = InsetAmount
		    End If
		  #endif
		  
		  // To ensure a consistent drawing experience. Partially obscured rows traditionally have a truncated g.height value.
		  Var Clip As Graphics = G.Clip(InsetLeft, 0, ColumnWidth - (InsetLeft + InsetRight), RowHeight)
		  
		  Var BackgroundColor, TextColor, SecondaryTextColor As Color
		  Var IsHighlighted As Boolean = Self.Highlighted And Self.Window.Focus = Self
		  If RowSelected Then
		    If IsHighlighted Then
		      BackgroundColor = If(RowInvalid, SystemColors.SystemRedColor, SystemColors.SelectedContentBackgroundColor)
		      TextColor = SystemColors.AlternateSelectedControlTextColor
		    Else
		      BackgroundColor = SystemColors.UnemphasizedSelectedContentBackgroundColor
		      TextColor = SystemColors.UnemphasizedSelectedTextColor
		    End If
		    SecondaryTextColor = TextColor
		  Else
		    BackgroundColor = If(Row Mod 2 = 0, SystemColors.ListEvenRowColor, SystemColors.ListOddRowColor)
		    TextColor = If(RowInvalid, SystemColors.SystemRedColor, SystemColors.TextColor)
		    SecondaryTextColor = If(RowInvalid, TextColor, SystemColors.SecondaryLabelColor)
		  End If
		  
		  Clip.DrawingColor = BackgroundColor
		  
		  If InsetLeft > 0 Or InsetRight > 0 Then
		    Var LeftPad, RightPad As Integer = CornerRadius
		    Var TopPad, BottomPad As Integer = 0
		    If Column = 0 Then
		      LeftPad = 0
		    End If
		    If Column = Self.ColumnCount - 1 Then
		      RightPad = 0
		    End If
		    If RowSelected And PreviousRowSelected Then
		      TopPad = CornerRadius * -1
		    End If
		    If RowSelected And NextRowSelected Then
		      BottomPad = CornerRadius * -1
		    End If
		    Clip.FillRoundRectangle(0 - LeftPad, TopPad, Clip.Width + LeftPad + RightPad, Clip.Height - (TopPad + BottomPad), CornerRadius, CornerRadius)
		  Else
		    Clip.FillRectangle(0, 0, Clip.Width, Clip.Height)
		  End If
		  
		  Call PaintCellBackground(Clip, Row, Column, BackgroundColor, TextColor, IsHighlighted)
		  
		  If Row >= Self.RowCount Then
		    Return True
		  End If
		  
		  // Text paint
		  
		  Const CellPadding = 4
		  Const LineSpacing = 6
		  
		  Var Contents As String = Me.CellTextAt(Row, Column).ReplaceLineEndings(EndOfLine)
		  Var Lines() As String = Contents.Split(EndOfLine)
		  Var MaxDrawWidth As Integer = ColumnWidth - (CellPadding * 4)
		  
		  If Lines.LastIndex = -1 Then
		    Return True
		  End If
		  
		  Var IsChecked As Boolean = Self.ColumnTypeAt(Column) = DesktopListbox.CellTypes.CheckBox Or Self.CellTypeAt(Row, Column) = DesktopListbox.CellTypes.CheckBox
		  If IsChecked Then
		    MaxDrawWidth = MaxDrawWidth - 20
		  End If
		  Var RowDepth As Integer
		  If Column = 0 And Self.AllowExpandableRows Then
		    RowDepth = (12 * (Self.RowDepthAt(Row) + 1)) + 4
		    MaxDrawWidth = MaxDrawWidth - RowDepth
		  End If
		  
		  Clip.FontSize = 0
		  Clip.FontName = "System"
		  Clip.Bold = RowInvalid
		  
		  // Need to compute the combined height of the lines
		  Var TotalTextHeight As Double = Clip.CapHeight
		  Clip.FontName = "SmallSystem"
		  Clip.Bold = False
		  TotalTextHeight = TotalTextHeight + ((Clip.CapHeight + LineSpacing) * Lines.LastIndex)
		  Clip.FontName = "System"
		  Clip.Bold = RowInvalid
		  
		  Var DrawTop As Double = (Clip.Height - TotalTextHeight) / 2
		  For I As Integer = 0 To Lines.LastIndex
		    Var LineWidth As Integer = Min(Ceiling(Clip.TextWidth(Lines(I))), MaxDrawWidth)
		    
		    Var DrawLeft As Integer
		    Var Align As DesktopListbox.Alignments = Self.CellAlignmentAt(Row, Column)
		    If Align = DesktopListbox.Alignments.Default Then
		      Align = Self.ColumnAlignmentAt(Column)
		    End If
		    Select Case Align
		    Case DesktopListbox.Alignments.Left, DesktopListbox.Alignments.Default
		      DrawLeft = CellPadding + If(IsChecked, 20, 0)
		    Case DesktopListbox.Alignments.Center
		      DrawLeft = CellPadding + If(IsChecked, 20, 0) + ((MaxDrawWidth - LineWidth) / 2)
		    Case DesktopListbox.Alignments.Right, DesktopListbox.Alignments.Decimal
		      DrawLeft = Clip.Width - (LineWidth + CellPadding)
		    End Select
		    DrawLeft = DrawLeft + RowDepth
		    
		    Var LineHeight As Double = Clip.CapHeight
		    Var LinePosition As Integer = Round(DrawTop + LineHeight)
		    Var LineColor As Color = If(I = 0, TextColor, SecondaryTextColor)
		    
		    Clip.DrawingColor = LineColor
		    If Not PaintCellText(Clip, Row, Column, Lines(I), TextColor, DrawLeft, LinePosition, IsHighlighted) Then
		      Clip.DrawText(Lines(I), DrawLeft, LinePosition, MaxDrawWidth, True)
		    End If
		    
		    DrawTop = DrawTop + LineSpacing + LineHeight
		    If I = 0 Then
		      Clip.FontName = "SmallSystem"
		      Clip.FontSize = 0
		      Clip.Bold = False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function PaintCellText(g as Graphics, row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  #Pragma Unused G
		  #Pragma Unused Row
		  #Pragma Unused Column
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub SelectionChanged()
		  Self.HandleChange()
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditClear() As Boolean Handles EditClear.Action
		  Self.DoClear()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCopy() As Boolean Handles EditCopy.Action
		  Self.DoCopy()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCut() As Boolean Handles EditCut.Action
		  Self.DoCut()
		  Return True
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
		  Self.DoPaste()
		  Return True
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Function CanCopy() As Boolean
		  Return RaiseEvent CanCopy()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanDelete() As Boolean
		  Return RaiseEvent CanDelete()
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanEdit() As Boolean
		  If IsEventImplemented("CanEdit") Then
		    Return RaiseEvent CanEdit()
		  End If
		  
		  Return (Self.EditableCell Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanPaste() As Boolean
		  Var Board As New Clipboard
		  Return RaiseEvent CanPaste(Board)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CompleteRowLoadRequest(RequestToken As String)
		  Var Idx As Integer = Self.mOutstandingRequestTokens.IndexOf(RequestToken)
		  If Idx > -1 Then
		    Self.mOutstandingRequestTokens.RemoveAt(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mTypeaheadTimer = New Timer
		  Self.mTypeaheadTimer.RunMode = Timer.RunModes.Off
		  AddHandler mTypeaheadTimer.Action, WeakAddressOf mTypeaheadTimer_Action
		  
		  Self.mScrollWatchTimer = New Timer
		  Self.mScrollWatchTimer.RunMode = Timer.RunModes.Off
		  Self.mScrollWatchTimer.Period = 250
		  AddHandler mScrollWatchTimer.Action, WeakAddressOf mScrollWatchTimer_Action
		  
		  Self.mRequestedPages = New Dictionary
		  
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CurrentPage() As Integer
		  If Self.AllowInfiniteScroll = False Or Self.PageSize = 0 Then
		    Return -1
		  End If
		  
		  Return Self.PageOfRowIndex(Self.ScrollPosition)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  CallLater.Cancel(Self.mPostOpenInvalidateCallbackKey)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoClear()
		  If Not Self.CanDelete Then
		    Return
		  End If
		  
		  RaiseEvent PerformClear(True)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoCopy()
		  If Not Self.CanCopy Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  RaiseEvent PerformCopy(Board)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoCut()
		  If Not (Self.CanCopy And Self.CanDelete) Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  RaiseEvent PerformCopy(Board)
		  RaiseEvent PerformClear(False)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoEdit()
		  If Not Self.CanEdit Then
		    Return
		  End If
		  
		  If IsEventImplemented("PerformEdit") Then
		    RaiseEvent PerformEdit
		    Return
		  End If
		  
		  // Look through the columns for exactly one editable cell
		  Var Cell As Point = Self.EditableCell
		  If (Cell Is Nil) = False Then
		    Self.EditCellAt(Cell.Y, Cell.X)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DoPaste()
		  If Not Self.CanPaste Then
		    Return
		  End If
		  
		  Var Board As New Clipboard
		  RaiseEvent PerformPaste(Board)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EditableCell() As Point
		  If Self.SelectedRowCount <> 1 Then
		    Return Nil
		  End If
		  
		  Var Row As Integer = Self.SelectedRowIndex
		  Var Editable As Integer = -1
		  For Column As Integer = 0 To Self.LastColumnIndex
		    If Self.CellTypeAt(Row, Column) = DesktopListbox.CellTypes.TextField Then
		      If Editable = -1 Then
		        Editable = Column
		      Else
		        Editable = -2
		      End If
		    End If
		  Next
		  
		  If Editable >= 0 Then
		    Return New Point(Editable, Row)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EnsureSelectionIsVisible(Animated As Boolean = True)
		  If Self.SelectedRowCount = 0 Then
		    Return
		  End If
		  
		  Var VisibleStart As Integer = Self.ScrollPosition
		  Var VisibleEnd As Integer = VisibleStart + Self.VisibleRowCount
		  Var AtLeastOneVisible As Boolean
		  
		  For I As Integer = 0 To Self.RowCount - 1
		    If Self.RowSelectedAt(I) Then
		      AtLeastOneVisible = AtLeastOneVisible Or (I >= VisibleStart And I <= VisibleEnd)
		    End If
		  Next
		  If Not AtLeastOneVisible Then
		    If Animated Then
		      Var Task As New AnimationKit.ScrollTask(Self)
		      Task.DurationInSeconds = 0.4
		      Task.Position = Self.SelectedRowIndex
		      Task.Curve = AnimationKit.Curve.CreateEaseOut
		      
		      If Self.mScrollTask <> Nil Then
		        Self.mScrollTask.Cancel
		        Self.mScrollTask = Nil
		      End If
		      
		      Self.mScrollTask = Task
		      Task.Run
		    Else
		      Self.ScrollPosition = Self.SelectedRowIndex
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleChange()
		  If Self.mBlockSelectionChangeCount <= 0 Then
		    RaiseEvent SelectionChanged
		  Else
		    Self.mFireChangeWhenUnlocked = True
		  End If
		  
		  Self.mLastChangeIndex = Self.SelectedRowIndex
		  Self.mLastChangeCount = Self.SelectedRowCount
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandleToggleMenu(Base As DesktopMenuItem, X As Integer, Y As Integer)
		  If Self.RowCount < 2 Then
		    Return
		  End If
		  
		  Var Row As Integer = Self.RowFromXY(X, Y)
		  If Row < 0 Or Row > Self.LastRowIndex Then
		    Return
		  End If
		  
		  Var CheckBoxColumnCount As Integer
		  Var FirstCheckBoxColumn As Integer = -1
		  For ColumnIdx As Integer = 0 To Self.LastColumnIndex
		    If Self.CellTypeAt(Row, ColumnIdx) = DesktopListBox.CellTypes.CheckBox Then
		      CheckBoxColumnCount = CheckBoxColumnCount + 1
		      If FirstCheckBoxColumn = -1 Then
		        FirstCheckBoxColumn = ColumnIdx
		      End If
		    End If
		  Next
		  If CheckBoxColumnCount = 0 Then
		    Return
		  End If
		  
		  Var Column As Integer = -1
		  If CheckBoxColumnCount > 1 Then
		    Column = Self.ColumnFromXY(X, Y)
		    If Self.CellTypeAt(Row, Column) <> DesktopListbox.CellTypes.CheckBox Then
		      Return
		    End If
		  ElseIf CheckboxColumnCount > 0 Then
		    Column = FirstCheckBoxColumn
		  End If
		  
		  If Column < 0 Or Column > Self.LastColumnIndex Then
		    Return
		  End If
		  
		  Base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		  
		  Var IsChecked As Boolean = Self.CellCheckBoxValueAt(Row, Column)
		  Var ToggleItem As New DesktopMenuItem
		  If CheckBoxColumnCount > 1 Then
		    If Self.HasHeader And Self.HeaderAt(Column).Trim.IsEmpty = False Then
		      Var ColumnName As String = Self.HeaderAt(Column).Trim
		      ToggleItem.Text = Language.ReplacePlaceholders(If(IsChecked, Self.UncheckAllNamed, Self.CheckAllNamed), ColumnName)
		    Else
		      ToggleItem.Text = If(IsChecked, Self.UncheckAllUnnamed, Self.CheckAllUnnamed)
		    End If
		  Else
		    ToggleItem.Text = If(IsChecked, Self.UncheckAllSingle, Self.CheckAllSingle)
		  End If
		  ToggleItem.Tag = New Dictionary("Action": "ToggleColumn", "Column": Column, "DesiredValue": Not IsChecked)
		  Base.AddMenu(ToggleItem)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Highlighted() As Boolean
		  If Self.Enabled Then
		    #if TargetCocoa
		      Declare Function IsMainWindow Lib "Cocoa.framework" Selector "isMainWindow" (Target As Ptr) As Boolean
		      Declare Function IsKeyWindow Lib "Cocoa.framework" Selector "isKeyWindow" (Target As Ptr) As Boolean
		      Return IsKeyWindow(Self.Window.Handle) Or IsMainWindow(Self.Window.Handle)
		    #else
		      Return True
		    #endif
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InvalidateScrollPosition()
		  Self.mLastScrollPosition = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLoading() As Boolean
		  Return Self.mOutstandingRequestTokens.Count > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxSelectedRow() As Integer
		  If Self.SelectedRowCount = 0 Then
		    Return -1
		  End If
		  
		  If Self.RowSelectionType = DesktopListbox.RowSelectionTypes.Single Then
		    Return Self.SelectedRowIndex
		  End If
		  
		  For Idx As Integer = Self.LastRowIndex DownTo 0
		    If Self.RowSelectedAt(Idx) Then
		      Return Idx
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MinSelectedRow() As Integer
		  If Self.SelectedRowCount = 0 Then
		    Return -1
		  End If
		  
		  If Self.RowSelectionType = DesktopListbox.RowSelectionTypes.Single Then
		    Return Self.SelectedRowIndex
		  End If
		  
		  For Idx As Integer = 0 To Self.LastRowIndex
		    If Self.RowSelectedAt(Idx) Then
		      Return Idx
		    End If
		  Next
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mScrollWatchTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  Var ViewportHeight As Integer = Self.VisibleRowCount
		  
		  If Self.IsLoading Or (Self.ScrollPosition = Self.mLastScrollPosition And ViewportHeight = Self.mLastViewportHeight) Then
		    Return
		  End If
		  
		  Var MinPage As Integer = Self.CurrentPage - 1
		  Var MaxPage As Integer = Self.PageOfRowIndex(Self.ScrollPosition + ViewportHeight) + 1
		  If Self.TotalPages > -1 Then
		    MinPage = Min(MinPage, Self.TotalPages)
		    MaxPage = Min(MaxPage, Self.TotalPages)
		  End If
		  For Page As Integer = MinPage To MaxPage
		    If Page > 0 And Self.mRequestedPages.HasKey(Page) = False Then
		      Self.ReloadPage(Page)
		      Return
		    End If
		  Next
		  
		  Self.mLastScrollPosition = Self.ScrollPosition
		  Self.mLastViewportHeight = ViewportHeight
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mTypeaheadTimer_Action(Sender As Timer)
		  #Pragma Unused Sender
		  
		  Self.mTypeaheadBuffer = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PageOfRowIndex(RowIndex As Integer) As Integer
		  Return Ceiling((RowIndex + 1) / Self.PageSize)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PauseScrollWatching()
		  If Self.AllowInfiniteScroll = False Or Self.mScrollWatchTimer.RunMode = Timer.RunModes.Off Then
		    Return
		  End If
		  
		  Self.mScrollWatchTimer.RunMode = Timer.RunModes.Off
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub PostOpenInvalidate()
		  Self.ScrollPosition = Self.ScrollPosition
		  Self.Refresh()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReloadAllPages()
		  Self.mRequestedPages = New Dictionary
		  Self.ReloadCurrentPage()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReloadCurrentPage()
		  Self.ReloadPage(Self.CurrentPage)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReloadPage(Page As Integer)
		  If Self.AllowInfiniteScroll = False Then
		    Return
		  End If
		  
		  Var RequestToken As String = EncodeHex(Crypto.GenerateRandomBytes(8)).Lowercase
		  Self.mOutstandingRequestTokens.Add(RequestToken)
		  Var Cancelled As Boolean = RaiseEvent LoadMoreRows(Page, RequestToken)
		  If Cancelled Then
		    Self.mOutstandingRequestTokens.RemoveAt(Self.mOutstandingRequestTokens.LastIndex)
		    Return
		  End If
		  Self.mRequestedPages.Value(Page) = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAllRows()
		  Self.mLastScrollPosition = -1
		  Self.mUpperRequestedBound = 0
		  Super.RemoveAllRows()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveRowAt(index As Integer)
		  Self.mLastScrollPosition = -1
		  Self.mUpperRequestedBound = Xojo.Max(Self.mUpperRequestedBound - 1, 0)
		  Super.RemoveRowAt(index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResumeScrollWatching()
		  If Self.AllowInfiniteScroll = False Or Self.mScrollWatchTimer.RunMode = Timer.RunModes.Multiple Then
		    Return
		  End If
		  
		  Self.mScrollWatchTimer.RunMode = Timer.RunModes.Multiple
		  Self.mScrollWatchTimer_Action(Self.mScrollWatchTimer) // Trigger it now
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RowCount(Assigns Value As Integer)
		  If Self.RowCount = Value Then
		    Return
		  End If
		  
		  Self.SelectionChangeBlocked = True
		  
		  #if TargetWindows
		    Var ScrollPosition As Integer = Self.ScrollPosition
		    Self.ScrollPosition = 0
		    Var ScrollerVisible As Boolean = Self.HasVerticalScrollbar
		    If ScrollerVisible Then
		      Self.HasVerticalScrollbar = False
		    End If
		  #endif
		  
		  Var Count As Integer = Self.RowCount
		  While Count < Value
		    Self.AddRow("")
		    Count = Count + 1
		  Wend
		  While Count > Value
		    Self.RemoveRowAt(Count - 1)
		    Count = Count - 1
		  Wend
		  
		  #if TargetWindows
		    If ScrollerVisible Then
		      Self.HasVerticalScrollbar = True
		      Self.ScrollPosition = ScrollPosition
		    End If
		  #endif
		  
		  Self.SelectionChangeBlocked = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RowIndexOfPage(Page As Integer) As Integer
		  Return (Page - 1) * Self.PageSize
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectionChangeBlocked() As Boolean
		  Return Self.mBlockSelectionChangeCount > 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SelectionChangeBlocked(FireChangeEvent As Boolean = True, Assigns Value As Boolean)
		  If Value Then
		    Self.mBlockSelectionChangeCount = Self.mBlockSelectionChangeCount + 1
		  Else
		    Self.mBlockSelectionChangeCount = Self.mBlockSelectionChangeCount - 1
		  End If
		  If Self.mBlockSelectionChangeCount < 0 Then
		    Break
		  End If
		  
		  If Self.mBlockSelectionChangeCount = 0 And Self.mFireChangeWhenUnlocked Then
		    If FireChangeEvent Then
		      RaiseEvent SelectionChanged
		    End If
		    Self.mFireChangeWhenUnlocked = False
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StatusMessage(SingularNoun As String, PluralNoun As String) As String
		  Var TotalItems As Integer = Self.RowCount
		  Var SelectedItems As Integer = Self.SelectedRowCount
		  Var Noun As String = If(TotalItems = 1, SingularNoun, PluralNoun)
		  If SelectedItems > 0 Then
		    Return SelectedItems.ToString(Locale.Current, "#,##0") + " of " + TotalItems.ToString(Locale.Current, "#,##0") + " " + Noun + " Selected"
		  Else
		    Return TotalItems.ToString(Locale.Raw, "0") + " " + Noun
		  End If
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event BulkColumnChangeFinished(Column As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BulkColumnChangeStarted(Column As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanCopy() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanDelete() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanEdit() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CanPaste(Board As Clipboard) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CellAction(row As Integer, column As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContextualMenuItemSelected(HitItem As DesktopMenuItem) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DoublePressed()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HeaderPressed(column as Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyDown(Key As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyUp(Key As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadMoreRows(Page As Integer, RequestToken As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PaintCellBackground(G As Graphics, Row As Integer, Column As Integer, BackgroundColor As Color, TextColor As Color, IsHighlighted As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PaintCellText(G As Graphics, Row As Integer, Column As Integer, Line As String, ByRef TextColor As Color, HorizontalPosition As Integer, VerticalPosition As Integer, IsHighlighted As Boolean) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformClear(Warn As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformCopy(Board As Clipboard)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformEdit()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PerformPaste(Board As Clipboard)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event RowIsInvalid(Row As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SelectionChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Typeahead(Buffer As String) As Boolean
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAllowInfiniteScroll
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = Self.AllowInfiniteScroll Then
			    Return
			  End If
			  
			  Self.mAllowInfiniteScroll = Value
			  If Value Then
			    Self.ResumeScrollWatching()
			  Else
			    Self.PauseScrollWatching()
			  End If
			End Set
		#tag EndSetter
		AllowInfiniteScroll As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		DefaultSortColumn As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		DefaultSortDirection As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEditCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEditCaption.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Self.mEditCaption = Value
			  End If
			End Set
		#tag EndSetter
		EditCaption As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mAllowInfiniteScroll As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBlockSelectionChangeCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCellActionCascading As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEditCaption As String = "Edit"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFireChangeWhenUnlocked As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mForwardKeyUp As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastChangeCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastChangeIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastScrollPosition As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastViewportHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOpened As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutstandingRequestTokens() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPageSize As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPostOpenInvalidateCallbackKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequestedPages As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollTask As AnimationKit.ScrollTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mScrollWatchTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalPages As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTypeaheadBuffer As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTypeaheadTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpperRequestedBound As Integer
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPageSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Value = Max(Value, 1)
			  If Self.mPageSize <> Value Then
			    Self.mPageSize = Value
			    If Self.AllowInfiniteScroll Then
			      Self.ScrollPosition = 0
			      Self.RemoveAllRows()
			    End If
			  End If
			End Set
		#tag EndSetter
		PageSize As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		PreferencesKey As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return If(Self.mTotalPages <= 0, -1, Self.mTotalPages)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mTotalPages = If(Value <= 0, -1, Value)
			End Set
		#tag EndSetter
		TotalPages As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		TypeaheadColumn As Integer = 0
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Var ViewportHeight As Integer = Self.Height
			  If Self.HasHeader Then
			    ViewportHeight = ViewportHeight - Self.HeaderHeight
			  End If
			  If Self.HasBorder Then
			    ViewportHeight = ViewportHeight - 2
			  End If
			  Return Floor(ViewportHeight / Self.DefaultRowHeight)
			End Get
		#tag EndGetter
		VisibleRowCount As Integer
	#tag EndComputedProperty


	#tag Constant, Name = AlternateRowColor, Type = Color, Dynamic = False, Default = \"&cFAFAFA", Scope = Public
	#tag EndConstant

	#tag Constant, Name = CheckAllNamed, Type = String, Dynamic = True, Default = \"Check All In \'\?1\' Column", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CheckAllSingle, Type = String, Dynamic = True, Default = \"Check All", Scope = Private
	#tag EndConstant

	#tag Constant, Name = CheckAllUnnamed, Type = String, Dynamic = True, Default = \"Check All In This Column", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DoubleLineRowHeight, Type = Double, Dynamic = False, Default = \"38", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidSelectedRowColor, Type = Color, Dynamic = False, Default = \"&c800000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidSelectedRowColorInactive, Type = Color, Dynamic = False, Default = \"&cD4BEBE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidSelectedTextColor, Type = Color, Dynamic = False, Default = \"&cFFFFFF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidSelectedTextColorInactive, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = InvalidTextColor, Type = Color, Dynamic = False, Default = \"&c800000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PrimaryRowColor, Type = Color, Dynamic = False, Default = \"&cFFFFFF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedRowColor, Type = Color, Dynamic = False, Default = \"&c0850CE", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedRowColorInactive, Type = Color, Dynamic = False, Default = \"&cCACACA", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedTextColor, Type = Color, Dynamic = False, Default = \"&cFFFFFF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SelectedTextColorInactive, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = StandardRowHeight, Type = Double, Dynamic = False, Default = \"26", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TextColor, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = UncheckAllNamed, Type = String, Dynamic = True, Default = \"Uncheck All In \'\?1\' Column", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UncheckAllSingle, Type = String, Dynamic = True, Default = \"Uncheck All", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UncheckAllUnnamed, Type = String, Dynamic = True, Default = \"Uncheck All In This Column", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UseRoundedRows, Type = Boolean, Dynamic = False, Default = \"False", Scope = Private
	#tag EndConstant


	#tag Structure, Name = CGRect, Flags = &h21
		X As CGFloat
		  Y As CGFloat
		  W As CGFloat
		H As CGFloat
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
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
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
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
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
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
			Name="LockRight"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLineStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="GridLineStyles"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Horizontal"
				"2 - Vertical"
				"3 - Both"
			#tag EndEnumValues
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
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="26"
			Type="Integer"
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
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="VisibleRowCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TypeaheadColumn"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditCaption"
			Visible=true
			Group="Behavior"
			InitialValue="Edit"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PreferencesKey"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultSortDirection"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - A to Z"
				"-1 - Z to A"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultSortColumn"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowInfiniteScroll"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageSize"
			Visible=true
			Group="Behavior"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TotalPages"
			Visible=true
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=false
			Group="Behavior"
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
			Name="_ScrollOffset"
			Visible=false
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=false
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
