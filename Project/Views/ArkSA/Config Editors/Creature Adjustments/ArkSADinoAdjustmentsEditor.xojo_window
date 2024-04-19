#tag DesktopWindow
Begin ArkSAConfigEditor ArkSADinoAdjustmentsEditor
   AllowAutoDeactivate=   True
   AllowFocus      =   False
   AllowFocusRing  =   False
   AllowTabs       =   True
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composited      =   False
   Enabled         =   True
   HasBackgroundColor=   False
   Height          =   526
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
   Width           =   730
   Begin BeaconListbox List
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   5
      ColumnWidths    =   "*,120,120,120,120"
      DefaultRowHeight=   34
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
      HasHeader       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   0
      Height          =   454
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Creature	Wild Damage	Wild Resistance	Tamed Damage	Tamed Resistance"
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PageSize        =   100
      PreferencesKey  =   ""
      RequiresSelection=   False
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      TotalPages      =   -1
      Transparent     =   False
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   730
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
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
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   462
   End
   Begin DelayedSearchField FilterField
      Active          =   False
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowRecentItems=   False
      AllowTabStop    =   True
      ClearMenuItemValue=   "Clear"
      DelayPeriod     =   250
      Enabled         =   True
      Height          =   22
      Hint            =   "Filter Creatures"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   470
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      MaximumRecentItems=   -1
      PanelIndex      =   0
      RecentItemsValue=   "Recent Searches"
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      Text            =   ""
      Tooltip         =   ""
      Top             =   9
      Transparent     =   False
      Visible         =   True
      Width           =   250
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin OmniBarSeparator FilterSeparator
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
      Left            =   461
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      ScrollActive    =   False
      ScrollingEnabled=   False
      ScrollSpeed     =   20
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   40
      Transparent     =   True
      Visible         =   True
      Width           =   269
   End
   Begin StatusContainer Status
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      CenterCaption   =   ""
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   31
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LeftCaption     =   ""
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      RightCaption    =   ""
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   495
      Transparent     =   True
      Visible         =   True
      Width           =   730
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Function ParsingFinished(Project As ArkSA.Project) As Boolean
		  If Project Is Nil Or Project.HasConfigGroup(ArkSA.Configs.NameCreatureAdjustments) = False Then
		    Return True
		  End If
		  
		  Var OtherConfig As ArkSA.Configs.DinoAdjustments = ArkSA.Configs.DinoAdjustments(Project.ConfigGroup(ArkSA.Configs.NameCreatureAdjustments))
		  If OtherConfig = Nil Then
		    Return True
		  End If
		  
		  Var Config As ArkSA.Configs.DinoAdjustments = Self.Config(True)
		  Var Behaviors() As ArkSA.CreatureBehavior = OtherConfig.Behaviors
		  Var Selections() As String
		  For Each Behavior As ArkSA.CreatureBehavior In Behaviors
		    Config.Add(Behavior)
		    Selections.Add(Behavior.TargetCreature.CreatureId)
		  Next
		  Self.Modified = True
		  Self.UpdateList(Selections)
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub RunTool(Tool As ArkSA.ProjectTool)
		  Select Case Tool.UUID
		  Case "614cfc80-b7aa-437d-b17e-01534f2ab778"
		    Var Changes As Integer = Self.Project.ConvertDinoReplacementsToSpawnOverrides()
		    Self.SetupUI
		    If Changes = 0 Then
		      Self.ShowAlert("No changes made", "Beacon was unable to find any replaced creatures that it could convert into spawn point additions.")
		    ElseIf Changes = 1 Then
		      Self.ShowAlert("Converted 1 creature replacement", "Beacon found 1 creature that it was able to convert into spawn point additions. The replaced creature has been disabled.")
		    Else
		      Self.ShowAlert("Converted " + Changes.ToString + " creature replacements", "Beacon found " + Changes.ToString + " creatures that it was able to convert into spawn point additions. The replaced creatures have been disabled.")
		    End If
		  End Select
		End Sub
	#tag EndEvent

	#tag Event
		Sub SetupUI()
		  Self.UpdateList()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Function Config(ForWriting As Boolean) As ArkSA.Configs.DinoAdjustments
		  Return ArkSA.Configs.DinoAdjustments(Super.Config(ForWriting))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EditSelected()
		  If Self.List.SelectedRowIndex = -1 Then
		    Return
		  End If
		  
		  // See the comment in ShowAdd
		  Var Creature As ArkSA.Creature = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  If ArkSADinoAdjustmentDialog.Present(Self, Creature, Self.Config(False), Self.Project.ContentPacks) Then
		    Call Self.Config(True)
		    Self.UpdateList()
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InternalName() As String
		  Return ArkSA.Configs.NameCreatureAdjustments
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowAdd()
		  // If this returns true, the config will have changed so we should make sure it gets
		  // added to the document if it wasn't already. Calling Self.Config(True) has the
		  // side effect of doing that
		  Var Config As ArkSA.Configs.DinoAdjustments = Self.Config(False)
		  If ArkSADinoAdjustmentDialog.Present(Self, Nil, Config, Self.Project.ContentPacks) Then
		    Call Self.Config(True)
		    Self.UpdateList()
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowDuplicate()
		  If Self.List.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Config As ArkSA.Configs.DinoAdjustments = Self.Config(False)
		  Var SelectedCreature As ArkSA.Creature = Self.List.RowTagAt(Self.List.SelectedRowIndex)
		  Var SelectedBehavior As ArkSA.CreatureBehavior = Config.Behavior(SelectedCreature)
		  If SelectedBehavior = Nil Then
		    Return
		  End If
		  
		  Var Behaviors() As ArkSA.CreatureBehavior = Config.Behaviors
		  Var CurrentCreatures() As ArkSA.Creature
		  For Each Behavior As ArkSA.CreatureBehavior In Behaviors
		    Var Creature As ArkSA.Creature = Behavior.TargetCreature
		    If Creature <> Nil Then
		      CurrentCreatures.Add(Creature)
		    End If
		  Next
		  
		  Var Creatures() As ArkSA.Creature = ArkSABlueprintSelectorDialog.Present(Self, "", CurrentCreatures, Self.Project.ContentPacks, ArkSABlueprintSelectorDialog.SelectModes.ExplicitMultiple)
		  If Creatures.LastIndex = -1 Then
		    Return
		  End If
		  Config = Self.Config(True)
		  Var Selections() As String
		  For Each Creature As ArkSA.Creature In Creatures
		    Var Behavior As ArkSA.CreatureBehavior = SelectedBehavior.Clone(Creature)
		    Config.Add(Behavior)
		    Selections.Add(Behavior.TargetCreature.CreatureId)
		  Next
		  Self.UpdateList(Selections)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList()
		  Var Selections() As String
		  For I As Integer = 0 To Self.List.RowCount - 1
		    If Self.List.RowSelectedAt(I) Then
		      Selections.Add(ArkSA.Creature(Self.List.RowTagAt(I)).CreatureId)
		    End If
		  Next
		  Self.UpdateList(Selections)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(SelectCreatures() As ArkSA.Creature)
		  Var Selections() As String
		  For Each Creature As ArkSA.Creature In SelectCreatures
		    Selections.Add(Creature.CreatureId)
		  Next
		  Self.UpdateList(Selections)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateList(Selections() As String)
		  Self.List.RemoveAllRows
		  
		  Var Behaviors() As ArkSA.CreatureBehavior = Self.Config(False).Behaviors(Self.FilterField.Text)
		  For Each Behavior As ArkSA.CreatureBehavior In Behaviors
		    Var Creature As ArkSA.Creature = Behavior.TargetCreature
		    Var Label As String = Creature.Label
		    
		    Var TameTransferSuffix As String
		    If Behavior.ProhibitTaming And Behavior.ProhibitTransfer Then
		      TameTransferSuffix = "cannot be tamed or transferred"
		    ElseIf Behavior.ProhibitTaming Then
		      TameTransferSuffix = "cannot be tamed"
		    ElseIf Behavior.ProhibitTransfer Then
		      TameTransferSuffix = "cannot be transferred"
		    End If
		    
		    If Behavior.ProhibitSpawning Then
		      Label = Label + EndOfLine + "Disabled"
		      If TameTransferSuffix.IsEmpty = False Then
		        Label = Label + ", " + TameTransferSuffix
		      End If
		      Self.List.AddRow(Label)
		    ElseIf IsNull(Behavior.ReplacementCreature) = False Then
		      Label = Label + EndOfLine + "Replaced with " + Behavior.ReplacementCreature.Label
		      If TameTransferSuffix.IsEmpty = False Then
		        Label = Label + ", " + TameTransferSuffix
		      End If
		      Self.List.AddRow(Label)
		    Else
		      If TameTransferSuffix.IsEmpty = False Then
		        Label = Label + EndOfLine + TameTransferSuffix.Left(1).Uppercase + TameTransferSuffix.Middle(1)
		      End If
		      Self.List.AddRow(Label, Behavior.DamageMultiplier.ToString(Locale.Current, "0.0#####"), Behavior.ResistanceMultiplier.ToString(Locale.Current, "0.0#####"), Behavior.TamedDamageMultiplier.ToString(Locale.Current, "0.0#####"), Behavior.TamedResistanceMultiplier.ToString(Locale.Current, "0.0#####"))
		    End If
		    
		    Self.List.RowSelectedAt(Self.List.LastAddedRowIndex) = Selections.IndexOf(Behavior.TargetCreature.CreatureId) > -1
		    Self.List.RowTagAt(Self.List.LastAddedRowIndex) = Behavior.TargetCreature
		  Next
		  
		  Self.List.Sort()
		  Self.List.EnsureSelectionIsVisible
		  Self.UpdateStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  Self.Status.CenterCaption = Self.List.StatusMessage("Adjustment", "Adjustments")
		End Sub
	#tag EndMethod


	#tag Constant, Name = ColumnName, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnTamedDamage, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnTamedResistance, Type = Double, Dynamic = False, Default = \"4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWildDamage, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ColumnWildResistance, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.arksa.dinoadjustment", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events List
	#tag Event
		Sub Opening()
		  Me.ColumnAlignmentAt(Self.ColumnWildDamage) = DesktopListbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnWildResistance) = DesktopListbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnTamedDamage) = DesktopListbox.Alignments.Center
		  Me.ColumnAlignmentAt(Self.ColumnTamedResistance) = DesktopListbox.Alignments.Center
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0 And Self.Project.ReadOnly = False
		End Function
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Creatures() As ArkSA.Creature
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Me.RowSelectedAt(I) = False Then
		      Continue
		    End If
		    
		    Var Creature As ArkSA.Creature = Me.RowTagAt(I)
		    Creatures.Add(Creature)
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Creatures, "creature adjustment", "creature adjustments") = False Then
		    Return
		  End If
		  
		  Var Changed As Boolean = Self.Modified
		  Var Config As ArkSA.Configs.DinoAdjustments = Self.Config(True)
		  For Each Creature As ArkSA.Creature In Creatures
		    Config.RemoveBehavior(Creature)
		    Changed = True
		  Next
		  
		  Self.Modified = Changed
		  Self.UpdateList()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dicts() As Dictionary
		  Var Config As ArkSA.Configs.DinoAdjustments = Self.Config(False)
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Creature As ArkSA.Creature = Me.RowTagAt(I)
		    Var Behavior As ArkSA.CreatureBehavior = Config.Behavior(Creature)
		    If Behavior = Nil Then
		      Continue
		    End If
		    
		    Dicts.Add(Behavior.ToDictionary)
		  Next
		  
		  If Dicts.Count = 0 Then
		    System.Beep
		    Return
		  End If
		  
		  Board.AddClipboardData(Self.kClipboardType, Dicts)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  Var Contents As Variant = Board.GetClipboardData(Self.kClipboardType)
		  If Contents.IsNull = False Then
		    Try
		      Var Dicts() As Variant = Contents
		      Var Config As ArkSA.Configs.DinoAdjustments = Self.Config(True)
		      Var Selections() As String
		      For Each Dict As Dictionary In Dicts
		        Var Behavior As ArkSA.CreatureBehavior = ArkSA.CreatureBehavior.FromDictionary(Dict)
		        If Behavior Is Nil Then
		          Continue
		        End If
		        
		        Selections.Add(Behavior.TargetCreature.BlueprintId)
		        Config.Add(Behavior)
		      Next
		      
		      If Selections.Count > 0 Then
		        Self.Modified = True
		        Self.UpdateList(Selections)
		      End If
		    Catch Err As RuntimeException
		      Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		    End Try
		    Return
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  Var DuplicateButton As OmniBarItem = Self.ConfigToolbar.Item("Duplicate")
		  If (DuplicateButton Is Nil) = False Then
		    DuplicateButton.Enabled = Me.SelectedRowCount = 1
		  End If
		  Self.UpdateStatus
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformEdit()
		  Self.EditSelected()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanEdit() As Boolean
		  Return Me.SelectedRowCount = 1
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("ConfigTitle", Self.ConfigLabel))
		  Me.Append(OmniBarItem.CreateSeparator)
		  Me.Append(OmniBarItem.CreateButton("AddCreature", "New Adjustment", IconToolbarAdd, "Define new creature adjustments."))
		  Me.Append(OmniBarItem.CreateButton("Duplicate", "Duplicate", IconToolbarClone, "Duplicate the selected creature adjustment.", False))
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddCreature"
		    Self.ShowAdd()
		  Case "Duplicate"
		    Self.ShowDuplicate()
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FilterField
	#tag Event
		Sub TextChanged()
		  Self.UpdateList
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
