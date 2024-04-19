#tag DesktopWindow
Begin BeaconContainer ArkLootDropEditor Implements AnimationKit.ValueAnimator
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
   Height          =   464
   HelpTag         =   ""
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
   UseFocusRing    =   "False"
   Visible         =   True
   Width           =   598
   Begin BeaconListbox SetList
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   False
      AllowInfiniteScroll=   False
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
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
      HeadingIndex    =   0
      Height          =   113
      Index           =   -2147483648
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
      RowSelectionType=   1
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   137
      TotalPages      =   -1
      Transparent     =   True
      TypeaheadColumn =   0
      Underline       =   False
      Visible         =   True
      VisibleRowCount =   0
      Width           =   250
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopPagePanel Panel
      AllowAutoDeactivate=   True
      Enabled         =   True
      Height          =   464
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   251
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelCount      =   2
      Panels          =   ""
      Scope           =   2
      SelectedPanelIndex=   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   347
      Begin ArkLootItemSetEditor Editor
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   False
         AllowTabs       =   True
         Backdrop        =   0
         BackgroundColor =   &cFFFFFF
         Composited      =   False
         Enabled         =   False
         HasBackgroundColor=   False
         Height          =   464
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   251
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Modified        =   False
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   2
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   347
      End
      Begin LogoFillCanvas LogoFillCanvas1
         AllowAutoDeactivate=   True
         AllowFocus      =   False
         AllowFocusRing  =   True
         AllowTabs       =   False
         Backdrop        =   0
         Caption         =   "No Selection"
         ContentHeight   =   0
         Enabled         =   True
         Height          =   433
         Index           =   -2147483648
         InitialParent   =   "Panel"
         Left            =   251
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   2
         ScrollActive    =   False
         ScrollingEnabled=   False
         ScrollSpeed     =   20
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   0
         Transparent     =   True
         Visible         =   True
         Width           =   347
      End
      Begin StatusContainer NoSelectionStatusBar
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
         InitialParent   =   "Panel"
         Left            =   251
         LeftCaption     =   ""
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         RightCaption    =   ""
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         Tooltip         =   ""
         Top             =   433
         Transparent     =   True
         Visible         =   True
         Width           =   347
      End
   End
   Begin FadedSeparator FadedSeparator1
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      ContentHeight   =   0
      Enabled         =   True
      Height          =   464
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
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   0
      Transparent     =   True
      Visible         =   True
      Width           =   1
   End
   Begin ArkLootSimulatorView Simulator
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   183
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Modified        =   False
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   281
      Transparent     =   True
      Visible         =   True
      Width           =   250
   End
   Begin ArkLootDropSettingsContainer SettingsContainer
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   False
      AllowTabs       =   True
      Backdrop        =   0
      BackgroundColor =   &cFFFFFF
      Composited      =   False
      Enabled         =   True
      HasBackgroundColor=   False
      Height          =   96
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   41
      Transparent     =   True
      Visible         =   True
      Width           =   250
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
      LockRight       =   False
      LockTop         =   True
      RightPadding    =   -1
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
      Width           =   250
   End
   Begin StatusContainer StatusBar1
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
      LockRight       =   False
      LockTop         =   False
      RightCaption    =   ""
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   250
      Transparent     =   True
      Visible         =   True
      Width           =   250
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  RaiseEvent Opening()
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(Initial As Boolean)
		  #Pragma Unused Initial
		  
		  If Self.SimulatorVisible Then
		    Self.SimulatorHeight = Preferences.SimulatorSize
		  Else
		    Self.SimulatorPosition = Self.Height
		  End If
		  Self.SetListWidth(Preferences.ItemSetsSplitterPosition)
		  
		  Var Resizer As OmniBarItem = Self.ConfigToolbar.Item("Resizer")
		  If (Resizer Is Nil) = False Then
		    Resizer.Enabled = Self.Width > Self.MinEditorWidth
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub AddSet(ParamArray Sets() As Ark.LootItemSet)
		  Self.AddSets(Sets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub AddSets(Sets() As Ark.LootItemSet)
		  For Each Override As Ark.MutableLootDropOverride In Self.mOverrides
		    For Each NewSet As Ark.LootItemSet In Sets
		      Override.Add(New Ark.LootItemSet(NewSet))
		    Next
		  Next
		  
		  Self.UpdateUI(Sets)
		  RaiseEvent Updated
		  
		  Self.Editor.ShowSettings(True)
		  Self.Editor.SetFocus()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AnimationStep(Identifier As String, Value As Double)
		  // Part of the AnimationKit.ValueAnimator interface.
		  
		  Select Case Identifier
		  Case "simulator position"
		    Self.SimulatorPosition = Round(Value)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub BuildPresetMenu(Parent As DesktopMenuItem)
		  Var Presets() As Ark.LootTemplate = Ark.DataSource.Pool.Get(False).GetLootTemplates
		  Var Groups As New Dictionary
		  Var GroupNames() As String
		  For Each Preset As Ark.LootTemplate In Presets
		    Var Arr() As Ark.LootTemplate
		    If Groups.HasKey(Preset.Grouping) Then
		      Arr = Groups.Value(Preset.Grouping)
		    End If
		    Arr.Add(Preset)
		    Groups.Value(Preset.Grouping) = Arr
		    
		    If GroupNames.IndexOf(Preset.Grouping) = -1 Then
		      GroupNames.Add(Preset.Grouping)
		    End If
		  Next
		  GroupNames.Sort
		  
		  For I As Integer = Parent.Count - 1 DownTo 0
		    Parent.RemoveMenuAt(I)
		  Next
		  
		  Var EmptySetItem As New DesktopMenuItem("New Empty Set", Nil)
		  AddHandler EmptySetItem.MenuItemSelected, WeakAddressOf Self.HandlePresetMenu
		  Parent.AddMenu(EmptySetItem)
		  
		  Var HasTarget As Boolean = Self.mOverrides.Count > 0
		  
		  For Each Group As String In GroupNames
		    Var Arr() As Ark.LootTemplate = Groups.Value(Group)
		    Var Names() As String
		    Var Items() As Ark.LootTemplate
		    For Each Preset As Ark.LootTemplate In Arr
		      If Preset.ValidForMask(Self.Project.MapMask) Then
		        Names.Add(Preset.Label)
		        Items.Add(Preset)
		      End If
		    Next
		    If Names.LastIndex = -1 Then
		      Continue For Group
		    End If
		    
		    Names.SortWith(Items)
		    
		    Parent.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		    
		    Var Header As New DesktopMenuItem(Group)
		    Header.Enabled = False
		    Parent.AddMenu(Header)
		    
		    For Each Preset As Ark.LootTemplate In Items
		      Var PresetItem As New DesktopMenuItem(Preset.Label, Preset)
		      PresetItem.Enabled = HasTarget
		      AddHandler PresetItem.MenuItemSelected, WeakAddressOf Self.HandlePresetMenu
		      Parent.AddMenu(PresetItem)
		    Next
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CancelImport()
		  If Self.mImporter <> Nil Then
		    Self.mImporter.Stop
		  End If
		  
		  If Self.mImportProgress <> Nil Then
		    Self.mImportProgress.Close
		    Self.mImportProgress = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GoToChild(ItemSetUUID As String, EntryUUID As String = "", EngramClass As String = "") As Boolean
		  For Idx As Integer = 0 To Self.SetList.LastRowIndex
		    Var Organizer As Ark.LootItemSetOrganizer = Self.SetList.RowTagAt(Idx)
		    If Organizer Is Nil Then
		      Continue
		    End If
		    
		    Var ItemSet As Ark.LootItemSet = Organizer.Template
		    If ItemSet Is Nil Or ItemSet.UUID <> ItemSetUUID Then
		      Continue
		    End If
		    
		    Self.SetList.SelectedRowIndex = Idx
		    Self.SetList.EnsureSelectionIsVisible()
		    
		    If EntryUUID.IsEmpty = False Then
		      Return Self.Editor.GoToChild(EntryUUID, EngramClass)
		    Else
		      Return True
		    End If
		  Next Idx
		  
		  Self.SetList.SelectedRowIndex = -1
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HandlePresetMenu(Sender As DesktopMenuItem) As Boolean
		  Var SelectedPreset As Ark.LootTemplate = Sender.Tag
		  
		  Var Mask As UInt64 = Self.Project.MapMask
		  Var ContentPacks As Beacon.StringList = Self.Project.ContentPacks
		  Var NewItemSets() As Ark.LootItemSet
		  
		  For Each Override As Ark.MutableLootDropOverride In Self.mOverrides
		    Var Set As Ark.LootItemSet
		    If (SelectedPreset Is Nil) = False Then
		      Set = Ark.LootItemSet.FromTemplate(SelectedPreset, Override, Mask, ContentPacks)
		    End If
		    If Set Is Nil Then
		      Set = New Ark.MutableLootItemSet()
		      Ark.MutableLootItemSet(Set).RawWeight = Override.DefaultWeight
		    End If
		    
		    Override.Add(Set)
		    NewItemSets.Add(Set)
		  Next
		  
		  Self.UpdateUI(NewItemSets)
		  RaiseEvent Updated
		  
		  Self.Editor.ShowSettings(True)
		  Self.Editor.SetFocus()
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(Content As String, Container As String)
		  #Pragma Unused Container
		  
		  Self.mImportProgress = New ProgressWindow
		  Self.mImportProgress.ShowDelayed(Self.TrueWindow)
		  
		  Var Data As New Ark.DiscoveredData
		  Data.GameIniContent = Content
		  
		  Self.mImporter = New Ark.ImportThread(Data, Self.Project)
		  Self.mImporter.DebugIdentifier = CurrentMethodName
		  Self.mImporter.Priority = Thread.NormalPriority
		  Self.mImporter.Progress = Self.mImportProgress
		  AddHandler mImporter.Finished, WeakAddressOf mImporter_Finished
		  Self.mImporter.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MaxSimulatorHeight() As Integer
		  Return Self.Height - (Self.ConfigToolbar.Height + Self.SettingsContainer.Height + 200)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mImporter_Finished(Sender As Ark.ImportThread, Project As Ark.Project)
		  #Pragma Unused Sender
		  
		  If Self.mImportProgress <> Nil Then
		    Self.mImportProgress.Close
		    Self.mImportProgress = Nil
		  End If
		  
		  If Not Project.HasConfigGroup(Ark.Configs.NameLootDrops) Then
		    Return
		  End If
		  
		  Var SourceContainers As Ark.Configs.LootDrops = Ark.Configs.LootDrops(Project.ConfigGroup(Ark.Configs.NameLootDrops))
		  Var NewItemSets() As Ark.LootItemSet
		  For Each SourceContainer As Ark.LootContainer In SourceContainers
		    For Each ItemSet As Ark.LootItemSet In SourceContainer
		      NewItemSets.Add(ItemSet)
		    Next
		  Next
		  Self.AddSets(NewItemSets)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MinEditorWidth() As Integer
		  Return ListMinWidth + ArkLootItemSetEditor.MinEditorWidth + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mSimulatorTask_Completed(Sender As AnimationKit.Task)
		  If Sender = Self.mSimulatorTask Then
		    Self.mSimulatorTask = Nil
		  End If
		  
		  Self.Refresh()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Overrides() As Ark.LootDropOverride()
		  Var Overrides() As Ark.LootDropOverride
		  Overrides.ResizeTo(Self.mOverrides.LastIndex)
		  For Idx As Integer = 0 To Self.mOverrides.LastIndex
		    Overrides(Idx) = New Ark.LootDropOverride(Self.mOverrides(Idx))
		  Next
		  Return Overrides
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Overrides(Assigns Overrides() As Ark.LootDropOverride)
		  If Overrides Is Nil Then
		    Self.mOverrides.ResizeTo(-1)
		  Else
		    Self.mOverrides.ResizeTo(Overrides.LastIndex)
		    For Idx As Integer = 0 To Overrides.LastIndex
		      Self.mOverrides(Idx) = New Ark.MutableLootDropOverride(Overrides(Idx))
		    Next
		  End If
		  
		  Self.SettingsContainer.Overrides = Self.mOverrides
		  
		  Self.UpdateUI
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Project() As Ark.Project
		  Return RaiseEvent GetProject
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetListWidth(NewSize As Integer)
		  Var ListWidth, EditorWidth As Integer
		  If Self.Width <= Self.MinEditorWidth Then
		    ListWidth = Self.ListMinWidth
		    EditorWidth = ArkLootItemSetEditor.MinEditorWidth
		  Else
		    Var AvailableSpace As Integer = Self.Width - Self.FadedSeparator1.Width
		    ListWidth = Min(Max(NewSize, Self.ListMinWidth), AvailableSpace - ArkLootItemSetEditor.MinEditorWidth)
		    EditorWidth = AvailableSpace - ListWidth
		  End If
		  
		  Self.ConfigToolbar.Width = ListWidth
		  Self.FadedSeparator1.Left = ListWidth
		  Self.SetList.Width = ListWidth
		  Self.Simulator.Width = ListWidth
		  Self.SettingsContainer.Width = ListWidth
		  Self.StatusBar1.Width = ListWidth
		  Self.Panel.Left = Self.FadedSeparator1.Left + Self.FadedSeparator1.Width
		  Self.Panel.Width = EditorWidth
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SimulatorHeight() As Integer
		  Return Self.Simulator.Height
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SimulatorHeight(Assigns Value As Integer)
		  Self.Simulator.Height = Max(Min(Value, Self.MaxSimulatorHeight), Self.MinSimulatorHeight)
		  Self.SimulatorPosition = Self.Height - Self.Simulator.Height
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SimulatorPosition() As Integer
		  Return Self.Simulator.Top
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SimulatorPosition(Assigns Value As Integer)
		  Self.Simulator.Top = Value
		  Self.StatusBar1.Top = Value - Self.StatusBar1.Height
		  Self.SetList.Height = Self.StatusBar1.Top - Self.SetList.Top
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SimulatorVisible() As Boolean
		  Return Preferences.SimulatorVisible
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SimulatorVisible(Animated As Boolean = True, Assigns Value As Boolean)
		  If Value = Self.SimulatorVisible Then
		    Return
		  End If
		  
		  Preferences.SimulatorVisible = Value
		  
		  Var SimulatorButton As OmniBarItem = Self.ConfigToolbar.Item("SimulatorButton")
		  If (SimulatorButton Is Nil) = False Then
		    SimulatorButton.Toggled = Value
		  End If
		  
		  Var NewPosition As Integer
		  If Value Then
		    Self.Simulator.Height = Min(Preferences.SimulatorSize, Self.MaxSimulatorHeight)
		    NewPosition = Self.Height - Self.Simulator.Height
		  Else
		    NewPosition = Self.Height
		  End If
		  
		  If Not Animated Then
		    Self.SimulatorPosition = NewPosition
		    Return
		  End If
		  
		  Var Curve As AnimationKit.Curve = AnimationKit.Curve.CreateEaseOut
		  Var Duration As Double = 0.15
		  
		  If Self.mSimulatorTask <> Nil Then
		    Self.mSimulatorTask.Cancel
		    Self.mSimulatorTask = Nil
		  End If
		  
		  Self.mSimulatorTask = New AnimationKit.ValueTask(Self, "simulator position", Self.SimulatorPosition, NewPosition)
		  AddHandler mSimulatorTask.Completed, AddressOf mSimulatorTask_Completed
		  Self.mSimulatorTask.DurationInSeconds = Duration
		  Self.mSimulatorTask.Curve = Curve
		  Self.mSimulatorTask.Run
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateStatus()
		  If Self.mUpdating Then
		    Return
		  End If
		  
		  Self.StatusBar1.CenterCaption = Self.SetList.StatusMessage("Item Set", "Item Sets")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI()
		  Self.UpdateUI(Nil)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateUI(SelectSets() As Ark.LootItemSet)
		  Self.SetList.SelectionChangeBlocked = True
		  
		  Var CombinedSets As New Dictionary
		  For Each Override As Ark.MutableLootDropOverride In Self.mOverrides
		    For Each Set As Ark.LootItemSet In Override
		      Var Hash As String = Set.Hash
		      Var Organizer As Ark.LootItemSetOrganizer
		      If CombinedSets.HasKey(Hash) Then
		        Organizer = CombinedSets.Value(Hash)
		      Else
		        Organizer = New Ark.LootItemSetOrganizer(Set)
		        CombinedSets.Value(Hash) = Organizer
		      End If
		      Organizer.Attach(Override, Set)
		    Next
		  Next
		  
		  If (CombinedSets Is Nil) = false And CombinedSets.KeyCount > 0 Then
		    Var SelectedSets() As String
		    If SelectSets Is Nil Then
		      For I As Integer = 0 To Self.SetList.RowCount - 1
		        If Self.SetList.RowSelectedAt(I) Then
		          SelectedSets.Add(Ark.LootItemSetOrganizer(Self.SetList.RowTagAt(I)).Template.UUID)
		        End If
		      Next
		    Else
		      For Each Set As Ark.LootItemSet In SelectSets
		        SelectedSets.Add(Set.Hash)
		      Next
		    End If
		    
		    Var ExtendedLabels As Boolean = Self.mOverrides.Count > 1
		    
		    Self.SetList.RowCount = CombinedSets.KeyCount
		    Self.SetList.DefaultRowHeight = If(ExtendedLabels, 34, 26)
		    For RowIndex As Integer = 0 To CombinedSets.KeyCount - 1
		      Var Hash As String = CombinedSets.Key(RowIndex)
		      Var Organizer As Ark.LootItemSetOrganizer = CombinedSets.Value(Hash)
		      
		      Self.SetList.CellTextAt(RowIndex, 0) = Organizer.Label(ExtendedLabels)
		      Self.SetList.RowTagAt(RowIndex) = Organizer
		      Self.SetList.RowSelectedAt(RowIndex) = Organizer.Matches(SelectedSets)
		    Next
		  Else
		    Self.SetList.RowCount = 0
		  End If
		  
		  Self.UpdateStatus
		  
		  Self.SetList.SortingColumn = 0
		  Self.SetList.Sort
		  Self.SetList.SelectionChangeBlocked = False
		  
		  Var SimulatorButton As OmniBarItem = Self.ConfigToolbar.Item("SimulatorButton")
		  If Self.mOverrides.Count = 1 Then
		    If (SimulatorButton Is Nil) = False Then
		      SimulatorButton.Enabled = True
		    End If
		    Self.Simulator.Simulate(Self.mOverrides(0))
		  Else
		    If (SimulatorButton Is Nil) = False Then
		      SimulatorButton.Enabled = False
		    End If
		    Self.Simulator.Clear()
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event GetProject() As Ark.Project
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PresentDropEditor(Override As Ark.LootDropOverride)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Updated()
	#tag EndHook


	#tag Property, Flags = &h21
		Private mImporter As Ark.ImportThread
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mImportProgress As ProgressWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOverrides() As Ark.MutableLootDropOverride
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSimulatorTask As AnimationKit.ValueTask
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSorting As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTotalSetCount As UInteger
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUpdating As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVisibleSetCount As UInteger
	#tag EndProperty


	#tag Constant, Name = kClipboardType, Type = String, Dynamic = False, Default = \"com.thezaz.beacon.ark.loot.itemset", Scope = Private
	#tag EndConstant

	#tag Constant, Name = ListDefaultWidth, Type = Double, Dynamic = False, Default = \"300", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ListMinWidth, Type = Double, Dynamic = False, Default = \"225", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MinSimulatorHeight, Type = Double, Dynamic = False, Default = \"100", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events SetList
	#tag Event
		Sub SelectionChanged()
		  If Self.mSorting = True Then
		    Return
		  End If
		  
		  If Me.SelectedRowCount = 1 Then
		    Editor.LootItemSet = Ark.LootItemSetOrganizer(Me.RowTagAt(Me.SelectedRowIndex)).Template
		    Editor.Enabled = True
		    Panel.SelectedPanelIndex = 1
		  Else
		    Editor.Enabled = False
		    Editor.LootItemSet = Nil
		    Panel.SelectedPanelIndex = 0
		  End If
		  
		  Self.UpdateStatus()
		End Sub
	#tag EndEvent
	#tag Event
		Function CanCopy() As Boolean
		  Return Me.SelectedRowCount > 0 And Self.Project.ReadOnly = False
		End Function
	#tag EndEvent
	#tag Event
		Function CanPaste(Board As Clipboard) As Boolean
		  Return Board.HasClipboardData(Self.kClipboardType)
		End Function
	#tag EndEvent
	#tag Event
		Sub PerformClear(Warn As Boolean)
		  Var Organizers() As Ark.LootItemSetOrganizer
		  Var Bound As Integer = Me.RowCount - 1
		  For I As Integer = 0 To Bound
		    If Me.RowSelectedAt(I) = False Then
		      Continue
		    End If
		    
		    Organizers.Add(Me.RowTagAt(I))
		  Next
		  
		  If Warn And Self.ShowDeleteConfirmation(Organizers, "item set", "item sets") = False Then
		    Return
		  End If
		  
		  For Each Organizer As Ark.LootItemSetOrganizer In Organizers
		    Var Overrides() As Ark.MutableLootDropOverride = Organizer.Overrides
		    For Each Override As Ark.MutableLootDropOverride In Overrides
		      Var Set As Ark.LootItemSet = Organizer.SetForOverride(Override)
		      Override.Remove(Set)
		    Next
		  Next
		  
		  RaiseEvent Updated
		  Self.UpdateUI()
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformCopy(Board As Clipboard)
		  Var Dicts() As Dictionary
		  For I As Integer = 0 To Me.RowCount - 1
		    If Not Me.RowSelectedAt(I) Then
		      Continue
		    End If
		    
		    Var Organizer As Ark.LootItemSetOrganizer = Me.RowTagAt(I)
		    Var Dict As Dictionary = Organizer.Template.SaveData
		    If Dict <> Nil Then
		      Dicts.Add(Dict)
		    End If
		  Next
		  If Dicts.LastIndex = -1 Then
		    Return
		  End If
		  
		  Board.AddClipboardData(Self.kClipboardType, Dicts)
		End Sub
	#tag EndEvent
	#tag Event
		Sub PerformPaste(Board As Clipboard)
		  If Self.mOverrides.Count = 0 Then
		    Return
		  End If
		  
		  Var Contents As Variant = Board.GetClipboardData(Self.kClipboardType)
		  If Contents.IsNull = False Then
		    Try
		      Var Dicts() As Variant = Contents
		      Var NewItemSets() As Ark.LootItemSet
		      For Each Dict As Dictionary In Dicts
		        Var Set As Ark.LootItemSet = Ark.LootItemSet.FromSaveData(Dict, True)
		        If Set Is Nil Then
		          Continue
		        End If
		        NewItemSets.Add(Set)
		      Next
		      Self.AddSets(NewItemSets)
		    Catch Err As RuntimeException
		      Self.ShowAlert("There was an error with the pasted content.", "The content is not formatted correctly.")
		    End Try
		    Return
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function CanDelete() As Boolean
		  Return Me.SelectedRowCount > 0
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(Base As DesktopMenuItem, X As Integer, Y As Integer) As Boolean
		  Var Targets() As Ark.LootItemSetOrganizer
		  If Me.SelectedRowCount = 0 Then
		    Var Idx As Integer = Me.RowFromXY(X, Y)
		    If Idx = -1 Then
		      Return False
		    End If
		    Targets.Add(Me.RowTagAt(Idx))
		  Else
		    For I As Integer = 0 To Me.RowCount - 1
		      If Me.RowSelectedAt(I) Then
		        Targets.Add(Me.RowTagAt(I))
		      End If
		    Next
		  End If
		  
		  If Targets.LastIndex = -1 Then
		    Return False
		  End If
		  
		  Var Preset As Ark.LootTemplate
		  For Each Organizer As Ark.LootItemSetOrganizer In Targets
		    If Organizer.Template.TemplateUUID = "" Or Preset <> Nil Then
		      Continue
		    End If
		    
		    Preset = Ark.DataSource.Pool.Get(False).GetLootTemplateByUUID(Organizer.Template.TemplateUUID)
		  Next
		  
		  Var CreateItem As New DesktopMenuItem("Create Template…", Targets)
		  CreateItem.Name = "createpreset"
		  CreateItem.Enabled = Targets.LastIndex = 0
		  If Preset <> Nil And CreateItem.Enabled Then
		    CreateItem.Text = "Update """ + Preset.Label + """ Template…"
		  End If
		  Base.AddMenu(CreateItem)
		  
		  Var ReconfigureItem As New DesktopMenuItem("Rebuild From Template", Targets)
		  ReconfigureItem.Name = "reconfigure"
		  ReconfigureItem.Enabled = Preset <> Nil
		  If ReconfigureItem.Enabled Then
		    If Targets.LastIndex = 0 Then
		      ReconfigureItem.Text = "Rebuild From """ + Preset.Label + """ Template"
		    Else
		      ReconfigureItem.Text = "Rebuild From Templates"
		    End If
		  End If
		  Base.AddMenu(ReconfigureItem)
		  
		  If Keyboard.OptionKey Then
		    Base.AddMenu(New DesktopMenuItem(DesktopMenuItem.TextSeparator))
		    
		    Var CopyJSONItem As New DesktopMenuItem("Copy JSON", Targets)
		    CopyJSONItem.Name = "copyjson"
		    CopyJSONItem.Enabled = True
		    Base.AddMenu(CopyJSONItem)
		  End If
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuItemSelected(HitItem As DesktopMenuItem) As Boolean
		  If HitItem = Nil Then
		    Return False
		  End If
		  
		  Var Targets() As Ark.LootItemSetOrganizer = HitItem.Tag
		  
		  Select Case HitItem.Name
		  Case "createpreset"
		    If Targets.Count = 1 Then
		      Var Organizer As Ark.LootItemSetOrganizer = Targets(0)
		      
		      Var NewTemplate As Ark.LootTemplate = App.MainWindow.Templates.CreateTemplate(Organizer.Template)
		      If NewTemplate Is Nil Then
		        Return True
		      End If
		      
		      Var Mask As UInt64 = Self.Project.MapMask
		      Var AffectedItemSets() As Ark.LootItemSet
		      Var Overrides() As Ark.MutableLootDropOverride = Organizer.Overrides
		      For Each Override As Ark.MutableLootDropOverride In Overrides
		        Var Set As Ark.LootItemSet = Organizer.SetForOverride(Override)
		        If Set Is Nil Then
		          Continue
		        End If
		        
		        Var MutableSet As Ark.MutableLootItemSet = Set.MutableVersion
		        If NewTemplate.RebuildLootItemSet(MutableSet, Mask, Override, Self.Project.ContentPacks) Then
		          Var Idx As Integer = Override.IndexOf(Set)
		          Override.SetAt(Idx) = MutableSet
		          AffectedItemSets.Add(MutableSet)
		        End If
		      Next
		      
		      If AffectedItemSets.LastIndex > -1 Then
		        Self.UpdateUI(AffectedItemSets)
		        RaiseEvent Updated
		      End If
		    End If
		  Case "reconfigure"
		    Var AffectedItemSets() As Ark.LootItemSet
		    Var Templates As New Dictionary
		    For Each Organizer As Ark.LootItemSetOrganizer In Targets
		      Var Overrides() As Ark.MutableLootDropOverride = Organizer.Overrides
		      Var Mask As UInt64 = Self.Project.MapMask
		      
		      For Each Override As Ark.MutableLootDropOverride In Overrides
		        Var Set As Ark.LootItemSet = Organizer.SetForOverride(Override)
		        If Set Is Nil Or Set.TemplateUUID.IsEmpty Then
		          Continue
		        End If
		        
		        If Not Templates.HasKey(Set.TemplateUUID) Then
		          Var LoadedTemplate As Ark.LootTemplate = Ark.DataSource.Pool.Get(False).GetLootTemplateByUUID(Set.TemplateUUID)
		          If LoadedTemplate Is Nil Then
		            Continue
		          End If
		          Templates.Value(Set.TemplateUUID) = LoadedTemplate
		        End If
		        
		        Var MutableSet As Ark.MutableLootItemSet = Set.MutableVersion
		        Var Template As Ark.LootTemplate = Templates.Value(Set.TemplateUUID)
		        If Template.RebuildLootItemSet(MutableSet, Mask, Override, Self.Project.ContentPacks) Then
		          Var Idx As Integer = Override.IndexOf(Set)
		          Override.SetAt(Idx) = MutableSet
		          AffectedItemSets.Add(MutableSet)
		        End If
		      Next
		    Next
		    
		    If AffectedItemSets.Count = 0 Then
		      If Targets.LastIndex = 0 Then
		        Self.ShowAlert("No changes made", "This item set is already identical to the template.")
		      Else
		        Self.ShowAlert("No changes made", "All item sets already match their template.")
		      End If
		      Return True
		    End If
		    
		    Self.UpdateUI(AffectedItemSets)
		    RaiseEvent Updated
		    
		    If Targets.LastIndex > 0 Then
		      // Editor will be disabled, so it won't be obvious something happened.
		      Self.ShowAlert("Rebuild complete", "All selected item sets have been rebuilt according to their template.")
		    End If
		  Case "copyjson"
		    Me.DoCopy()
		  End Select
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Editor
	#tag Event
		Sub Updated()
		  // The set needs to be cloned into each loot drop
		  
		  If SetList.SelectedRowCount <> 1 Then
		    Return
		  End If
		  
		  Var Organizer As Ark.LootItemSetOrganizer = Self.SetList.RowTagAt(Self.SetList.SelectedRowIndex)
		  Organizer.Replicate()
		  Self.SetList.CellTextAt(Self.SetList.SelectedRowIndex, 0) = Organizer.Template.Label
		  
		  Self.mSorting = True
		  SetList.Sort
		  Self.mSorting = False
		  
		  RaiseEvent Updated
		  
		  If Self.SimulatorVisible And Self.mOverrides.Count = 1 Then
		    Self.Simulator.Simulate(Self.mOverrides(0))
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function GetProject() As Ark.Project
		  Return Self.Project
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events Simulator
	#tag Event
		Sub ShouldResize(ByRef NewSize As Integer)
		  Self.SimulatorHeight = NewSize
		End Sub
	#tag EndEvent
	#tag Event
		Sub ResizeFinished()
		  Preferences.SimulatorSize = Me.Height
		End Sub
	#tag EndEvent
	#tag Event
		Sub ShouldClose()
		  Self.SimulatorVisible = False
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SettingsContainer
	#tag Event
		Sub Resized()
		  Var ListTop As Integer = Me.Top + Me.Height
		  
		  If Self.SetList.Top = ListTop Then
		    Return
		  End If
		  
		  Self.SetList.Top = ListTop
		  Self.SetList.Height = Self.StatusBar1.Top - Self.SetList.Top
		End Sub
	#tag EndEvent
	#tag Event
		Sub SettingsChanged()
		  RaiseEvent Updated
		  
		  If Self.SimulatorVisible Then
		    Self.Simulator.Simulate(Self.mOverrides(0))
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ConfigToolbar
	#tag Event
		Sub Opening()
		  Me.Append(OmniBarItem.CreateTitle("Title", "Item Sets"))
		  Me.Append(OmniBarItem.CreateSeparator("TitleSeparator"))
		  Me.Append(OmniBarItem.CreateButton("AddSetButton", "New Item Set", IconToolbarAddMenu, "Add a new empty item set. Hold to add a template from a menu."))
		  Me.Append(OmniBarItem.CreateButton("SimulatorButton", "Simulator", IconToolbarSimulate, "Simulate loot selection for this loot drop.", False))
		  Me.Append(OmniBarItem.CreateFlexibleSpace)
		  Me.Append(OmniBarItem.CreateHorizontalResizer("Resizer"))
		  
		  Me.Item("Title").Priority = 5
		  Me.Item("TitleSeparator").Priority = 5
		  
		  If Self.SimulatorVisible Then
		    Me.Item("SimulatorButton").Toggled = True
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ItemPressed(Item As OmniBarItem, ItemRect As Rect)
		  #Pragma Unused ItemRect
		  
		  Select Case Item.Name
		  Case "AddSetButton"
		    Var Set As New Ark.MutableLootItemSet
		    Set.RawWeight = Self.mOverrides(0).DefaultWeight
		    Self.AddSet(Set)
		  Case "SimulatorButton"
		    If Self.SimulatorVisible Then
		      Self.SimulatorVisible = False
		    Else
		      Self.Simulator.Simulate(Self.mOverrides(0))
		      Self.SimulatorVisible = True
		    End If
		  End Select
		End Sub
	#tag EndEvent
	#tag Event
		Sub Resize(DraggedResizer As OmniBarItem, DeltaX As Integer, DeltaY As Integer)
		  #Pragma Unused DraggedResizer
		  #Pragma Unused DeltaY
		  
		  Var NewWidth As Integer = Me.Width + DeltaX
		  Self.SetListWidth(NewWidth)
		End Sub
	#tag EndEvent
	#tag Event
		Function ItemHeld(Item As OmniBarItem, ItemRect As Rect) As Boolean
		  Select Case Item.Name
		  Case "AddSetButton"
		    Var Base As New DesktopMenuItem
		    Self.BuildPresetMenu(Base)
		    
		    Var Position As Point = Me.GlobalPosition
		    Var Choice As DesktopMenuItem = Base.PopUp(Position.X + ItemRect.Left, Position.Y + ItemRect.Bottom)
		    If (Choice Is Nil) = False Then
		      Call Self.HandlePresetMenu(Choice)
		    End If
		    Return True
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Sub ResizeFinished(DraggedResizer As OmniBarItem)
		  #Pragma Unused DraggedResizer
		  
		  Preferences.ItemSetsSplitterPosition = Self.SetList.Width
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
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
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
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue=""
		Type="Integer"
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
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
#tag EndViewBehavior
