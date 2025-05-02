#tag Class
Protected Class OmniBarItem
Implements ObservationKit.Observable
	#tag Method, Flags = &h21
		Private Shared Function ActiveColorToColor(Value As OmniBarItem.ActiveColors, Profile As OmniBarColorProfile, ForBackground As Boolean = False) As Color
		  Select Case Value
		  Case OmniBarItem.ActiveColors.Blue
		    Return If(ForBackground, Profile.Blue, Profile.BlueText)
		  Case OmniBarItem.ActiveColors.Brown
		    Return If(ForBackground, Profile.Brown, Profile.BrownText)
		  Case OmniBarItem.ActiveColors.Gray
		    Return If(ForBackground, Profile.Gray, Profile.GrayText)
		  Case OmniBarItem.ActiveColors.Green
		    Return If(ForBackground, Profile.Green, Profile.GreenText)
		  Case OmniBarItem.ActiveColors.Orange
		    Return If(ForBackground, Profile.Orange, Profile.OrangeText)
		  Case OmniBarItem.ActiveColors.Pink
		    Return If(ForBackground, Profile.Pink, Profile.PinkText)
		  Case OmniBarItem.ActiveColors.Purple
		    Return If(ForBackground, Profile.Purple, Profile.PurpleText)
		  Case OmniBarItem.ActiveColors.Red
		    Return If(ForBackground, Profile.Red, Profile.RedText)
		  Case OmniBarItem.ActiveColors.Yellow
		    Return If(ForBackground, Profile.Yellow, Profile.YellowText)
		  Else
		    Return If(ForBackground, Profile.AccentColor, Profile.AccentedText)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		    
		    If Refs(I).Value = Observer Then
		      // Already being watched
		      Return
		    End If
		  Next
		  
		  Refs.Add(New WeakRef(Observer))
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckProgressTimer()
		  If Self.mHasProgressIndicator = True And Self.mProgress = Self.ProgressIndeterminate And Self.mIndeterminateTimer Is Nil Then
		    Self.mIndeterminateTimer = New Timer
		    Self.mIndeterminateTimer.RunMode = Timer.RunModes.Multiple
		    Self.mIndeterminateTimer.Period = 1000/30
		    AddHandler mIndeterminateTimer.Action, WeakAddressOf mIndeterminateTimer_Action
		  ElseIf (Self.mHasProgressIndicator = False Or Self.mProgress <> Self.ProgressIndeterminate) And (Self.mIndeterminateTimer Is Nil) = False Then
		    RemoveHandler mIndeterminateTimer.Action, WeakAddressOf mIndeterminateTimer_Action
		    Self.mIndeterminateTimer.RunMode = Timer.RunModes.Off
		    Self.mIndeterminateTimer = Nil
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clickable() As Boolean
		  Select Case Self.Type
		  Case OmniBarItem.Types.Tab, OmniBarItem.Types.Button, OmniBarItem.Types.HorizontalResizer, OmniBarItem.Types.VerticalResizer
		    Return True
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Compact(G As Graphics) As Boolean
		  If Self.mType = OmniBarItem.Types.Button And Self.mButtonStyle = Self.ButtonStyleBottomCaption Then
		    Return G.Height < 50
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor(Type As OmniBarItem.Types, Name As String, Caption As String, Icon As Picture = Nil)
		  Self.mType = Type
		  Self.mActiveColor = OmniBarItem.ActiveColors.Accent
		  Self.mAlwaysUseActiveColor = False
		  Self.mCanBeClosed = False
		  Self.mCaption = Caption
		  Self.mEnabled = True
		  Self.mHasProgressIndicator = False
		  Self.mHasUnsavedChanges = False
		  Self.mHelpTag = ""
		  Self.mIcon = Icon
		  Self.mName = Name
		  Self.mProgress = 0
		  Self.mPriority = 10
		  Self.mVisible = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateButton(Name As String, Caption As String, Icon As Picture, HelpTag As String, Enabled As Boolean = True) As OmniBarItem
		  Var Item As New OmniBarItem(OmniBarItem.Types.Button, Name, Caption, Icon)
		  Item.HelpTag = HelpTag
		  Item.Enabled = Enabled
		  Return Item
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateFlexibleSpace(Name As String = "") As OmniBarItem
		  If Name.IsEmpty Then
		    Name = EncodeHex(Crypto.GenerateRandomBytes(3)).Lowercase
		  End If
		  Return New OmniBarItem(OmniBarItem.Types.FlexSpace, Name, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateHorizontalResizer(Name As String = "") As OmniBarItem
		  Return CreateResizer(Name, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateResizer(Name As String, Vertical As Boolean) As OmniBarItem
		  If Name.IsEmpty Then
		    Name = EncodeHex(Crypto.GenerateRandomBytes(3)).Lowercase
		  End If
		  If Vertical Then
		    Return New OmniBarItem(OmniBarItem.Types.VerticalResizer, Name, "", IconToolbarVResize)
		  Else
		    Return New OmniBarItem(OmniBarItem.Types.HorizontalResizer, Name, "", IconToolbarHResize)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateSeparator(Name As String = "") As OmniBarItem
		  If Name.IsEmpty Then
		    Name = EncodeHex(Crypto.GenerateRandomBytes(3)).Lowercase
		  End If
		  Return New OmniBarItem(OmniBarItem.Types.Separator, Name, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CreateShadowBrush(ShadowColor As Color) As ShadowBrush
		  Var Brush As New ShadowBrush
		  Brush.ShadowColor = ShadowColor
		  Brush.BlurAmount = 0
		  Brush.Offset = New Point(0, 1)
		  Return Brush
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateSpace(Name As String = "") As OmniBarItem
		  If Name.IsEmpty Then
		    Name = EncodeHex(Crypto.GenerateRandomBytes(3)).Lowercase
		  End If
		  Return New OmniBarItem(OmniBarItem.Types.Space, Name, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateTab(Name As String, Caption As String, Icon As Picture = Nil) As OmniBarItem
		  Return New OmniBarItem(OmniBarItem.Types.Tab, Name, Caption, Icon)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateTitle(Name As String, Caption As String) As OmniBarItem
		  Return New OmniBarItem(OmniBarItem.Types.Title, Name, Caption, Nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function CreateVerticalResizer(Name As String = "") As OmniBarItem
		  Return CreateResizer(Name, True)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawButton(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  #Pragma Unused LocalMousePoint
		  
		  Var Compact As Boolean = Self.Compact(G)
		  
		  Const CornerRadius = 6
		  Var Margins As Integer = Self.ButtonPadding
		  If Compact Then
		    Margins = Margins / 2
		  End If
		  
		  Var CellHeight As Double = Self.ButtonIconSize
		  Var WithCaption As Boolean = Self.Caption.IsEmpty = False
		  If WithCaption And Self.mButtonStyle = Self.ButtonStyleBottomCaption Then
		    CellHeight = CellHeight + (Margins / 2) + G.TextHeight
		  End If
		  Var CellTop As Double = NearestMultiple((G.Height - CellHeight) / 2, G.ScaleY)
		  
		  Var ForeColor, BackColor, ShadowColor As Color = &c000000FF
		  If Self.Toggled Then
		    If Highlighted Then
		      ForeColor = Colors.ToggledButtonIconColor
		      BackColor = Self.ActiveColorToColor(Self.ActiveColor, Colors, True)
		      ShadowColor = Colors.ToggledButtonShadowColor
		    Else
		      ForeColor = Colors.TextColor
		      BackColor = Colors.ToggledButtonInactiveColor
		      ShadowColor = Colors.TextShadowColor
		    End If
		  ElseIf Highlighted And (Self.AlwaysUseActiveColor Or MouseHover) Then
		    ForeColor = Self.ActiveColorToColor(Self.ActiveColor, Colors, False)
		    ShadowColor = Colors.TextShadowColor
		  Else
		    ForeColor = Colors.TextColor
		    ShadowColor = Colors.TextShadowColor
		  End If
		  
		  If Not Self.Enabled Then
		    ForeColor = ForeColor.AtOpacity(0.5)
		    ShadowColor = ShadowColor.AtOpacity(0.5)
		  End If
		  
		  Var IconRect As New Rect(NearestMultiple((G.Width - Self.ButtonIconSize) / 2, G.ScaleX), CellTop, Self.ButtonIconSize, Self.ButtonIconSize)
		  Var HighlightRect As New Rect(0, CellTop - Margins, G.Width, CellHeight + (Margins * 2))
		  Var Factor As Double = Max(G.ScaleX, G.ScaleY)
		  Var Icon As Picture = BeaconUI.IconWithColor(Self.Icon, ForeColor, Factor, Factor)
		  
		  If WithCaption Then
		    Select Case Self.mButtonStyle
		    Case Self.ButtonStyleLeftCaption
		      IconRect.Left = NearestMultiple(G.Width - ((Margins / 2) + IconRect.Width), G.ScaleX)
		    Case Self.ButtonStyleRightCaption
		      IconRect.Left = NearestMultiple(Margins / 2, G.ScaleX)
		    End Select
		  End If
		  
		  If BackColor.Alpha < 255 Then
		    G.DrawingColor = BackColor
		    G.FillRoundRectangle(HighlightRect.Left, HighlightRect.Top, HighlightRect.Width, HighlightRect.Height, CornerRadius, CornerRadius)
		  End If
		  
		  G.ShadowBrush = Self.CreateShadowBrush(ShadowColor)
		  G.DrawPicture(Icon, IconRect.Left, IconRect.Top, IconRect.Width, IconRect.Height, 0, 0, Icon.Width, Icon.Height)
		  
		  If WithCaption Then
		    Var CaptionWidth As Double = G.TextWidth(Self.Caption)
		    Var CaptionLeft, CaptionBaseline As Double
		    
		    Select Case Self.mButtonStyle
		    Case Self.ButtonStyleBottomCaption
		      CaptionLeft = NearestMultiple((G.Width - CaptionWidth) / 2, G.ScaleX)
		      CaptionBaseline = NearestMultiple(IconRect.Bottom + (Margins / 2) + G.FontAscent, G.ScaleY)
		    Case Self.ButtonStyleLeftCaption
		      CaptionLeft = NearestMultiple(Margins / 2, G.ScaleX)
		      CaptionBaseline = NearestMultiple((IconRect.VerticalCenter - 1) + (G.FontAscent / 2), G.ScaleY)
		    Case Self.ButtonStyleRightCaption
		      CaptionLeft = NearestMultiple(IconRect.Right + (Margins / 2), G.ScaleX)
		      CaptionBaseline = NearestMultiple((IconRect.VerticalCenter - 1) + (G.FontAscent / 2), G.ScaleY)
		    End Select
		    
		    G.DrawingColor = ForeColor
		    G.DrawText(Self.Caption, CaptionLeft, CaptionBaseline, G.Width, True)
		  End If
		  G.ShadowBrush = Nil
		  
		  If MouseDown And Self.Enabled Then
		    G.DrawingColor = &c00000080
		    G.FillRoundRectangle(HighlightRect.Left, HighlightRect.Top, HighlightRect.Width, HighlightRect.Height, CornerRadius, CornerRadius)
		  End If
		  
		  Self.mLastInsetRect = HighlightRect
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawInto(G As Graphics, ItemRect As Rect, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  // Tabs need to draw in the full space, so they will clip themselves
		  If Self.Type = OmniBarItem.Types.Tab Then
		    Self.DrawTab(G, ItemRect, Colors, MouseDown, MouseHover, LocalMousePoint, Highlighted)
		    Return
		  End If
		  
		  G = G.Clip(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height)
		  Self.SetFont(G)
		  
		  Select Case Self.Type
		  Case OmniBarItem.Types.Button
		    Self.DrawButton(G, Colors, MouseDown, MouseHover, LocalMousePoint, Highlighted)
		  Case OmniBarItem.Types.Separator
		    Self.DrawSeparator(G, Colors, MouseDown, MouseHover, LocalMousePoint, Highlighted)
		  Case OmniBarItem.Types.Title
		    Self.DrawTitle(G, Colors, MouseDown, MouseHover, LocalMousePoint, Highlighted)
		  Case OmniBarItem.Types.HorizontalResizer, OmniBarItem.Types.VerticalResizer
		    Self.DrawResizer(G, Colors, MouseDown, MouseHover, LocalMousePoint, Highlighted)
		  End Select
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub DrawOverflow(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  #Pragma Unused LocalMousePoint
		  
		  Var ForeColor, ShadowColor As Color
		  If MouseHover And Highlighted Then
		    ForeColor = Colors.AccentColor
		  Else
		    ForeColor = Colors.TextColor
		  End If
		  ShadowColor = Colors.TextShadowColor
		  
		  G.DrawingColor = ForeColor
		  G.ShadowBrush = CreateShadowBrush(ShadowColor)
		  
		  Var Path As New GraphicsPath
		  Path.MoveToPoint(3, 5)
		  Path.AddLineToPoint(6, 5)
		  Path.AddLineToPoint(11, 10)
		  Path.AddLineToPoint(6, 15)
		  Path.AddLineToPoint(3, 15)
		  Path.AddLineToPoint(8, 10)
		  Path.AddLineToPoint(3, 5)
		  G.FillPath(Path)
		  
		  Path = New GraphicsPath
		  Path.MoveToPoint(9, 5)
		  Path.AddLineToPoint(12, 5)
		  Path.AddLineToPoint(17, 10)
		  Path.AddLineToPoint(12, 15)
		  Path.AddLineToPoint(9, 15)
		  Path.AddLineToPoint(14, 10)
		  Path.AddLineToPoint(9, 5)
		  G.FillPath(Path)
		  
		  G.ShadowBrush = Nil
		  
		  If MouseDown Then
		    G.DrawingColor = &c00000080
		    G.FillRoundRectangle(0, 0, G.Width, G.Height, 6, 6)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawResizer(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  #Pragma Unused LocalMousePoint
		  
		  Var ForeColor, ShadowColor As Color = &c000000FF
		  If Highlighted And (Self.AlwaysUseActiveColor Or MouseHover) Then
		    ForeColor = Self.ActiveColorToColor(Self.ActiveColor, Colors, False)
		    ShadowColor = Colors.TextShadowColor
		  Else
		    ForeColor = Colors.TextColor
		    ShadowColor = Colors.TextShadowColor
		  End If
		  
		  If Self.Enabled = False Then
		    ForeColor = ForeColor.AtOpacity(0.5)
		    ShadowColor = ShadowColor.AtOpacity(0.5)
		  ElseIf MouseDown Then
		    ForeColor = ForeColor.Darker(0.5)
		  End If
		  
		  Var IconRect As New Rect(NearestMultiple((G.Width - Self.Icon.Width) / 2, G.ScaleX), NearestMultiple((G.Height - Self.Icon.Height) / 2, G.ScaleY), Self.Icon.Width, Self.Icon.Height)
		  Var Factor As Double = Max(G.ScaleX, G.ScaleY)
		  Var Icon As Picture = BeaconUI.IconWithColor(Self.Icon, ForeColor, Factor, Factor)
		  
		  G.ShadowBrush = Self.CreateShadowBrush(ShadowColor)
		  G.DrawPicture(Icon, IconRect.Left, IconRect.Top, IconRect.Width, IconRect.Height, 0, 0, Icon.Width, Icon.Height)
		  G.ShadowBrush = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawSeparator(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  #Pragma Unused MouseDown
		  #Pragma Unused MouseHover
		  #Pragma Unused LocalMousePoint
		  #Pragma Unused Highlighted
		  
		  Const Spacing = 10
		  Var X As Integer = NearestMultiple((G.Width - 2) / 2, G.ScaleX)
		  
		  G.DrawingColor = Colors.TextColor.AtOpacity(0.2)
		  G.DrawLine(X, Spacing, X, G.Height - Spacing)
		  G.DrawingColor = Colors.TextShadowColor.AtOpacity(0.5)
		  G.DrawLine(X + 1, Spacing + 1, X + 1, (G.Height - Spacing) + 1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTab(G As Graphics, ItemRect As Rect, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  Var HasIcon As Boolean = (Self.Icon Is Nil) = False
		  Var HasCaption As Boolean = Self.Caption.IsEmpty = False
		  If HasIcon = False And HasCaption = False Then
		    // There's nothing here to draw
		    Return
		  End If
		  
		  Var BarSpace As Graphics
		  If ItemRect.Top > 0 And ItemRect.Height = G.Height - 1 Then
		    BarSpace = G.Clip(ItemRect.Left, 0, ItemRect.Width, 2)
		  Else
		    BarSpace = G.Clip(ItemRect.Left, G.Height - 2, ItemRect.Width, 2)
		  End If
		  G = G.Clip(ItemRect.Left, ItemRect.Top, ItemRect.Width, ItemRect.Height)
		  Self.SetFont(G)
		  
		  If Self.HasProgressIndicator Then
		    If Self.Progress = Self.ProgressIndeterminate Then
		      Const BarMaxPercent = 0.75
		      
		      Var Phase As Double = Self.IndeterminatePhase
		      Var RangeMin As Double = (BarSpace.Width * BarMaxPercent) * -1
		      Var RangeMax As Double = BarSpace.Width
		      Var BarLeft As Double = NearestMultiple(RangeMin + ((RangeMax - RangeMin) * Phase), BarSpace.ScaleX)
		      Var BarWidth As Double = NearestMultiple(BarSpace.Width * BarMaxpercent, BarSpace.ScaleX)
		      
		      BarSpace.DrawingColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		      BarSpace.FillRectangle(BarLeft, 0, BarWidth, 2)
		    Else
		      Var BarWidth As Double = NearestMultiple(BarSpace.Width * Self.Progress, BarSpace.ScaleX)
		      BarSpace.DrawingColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		      BarSpace.FillRectangle(0, 0, BarWidth, 2)
		    End If
		  ElseIf Self.Toggled Then
		    BarSpace.ClearRectangle(0, 0, BarSpace.Width, 2)
		    If Highlighted Then
		      BarSpace.DrawingColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		    Else
		      BarSpace.DrawingColor = Colors.SeparatorColor
		    End If
		    BarSpace.DrawRectangle(0, 0, BarSpace.Width, 2)
		  End If
		  
		  // Find the color we'll be using
		  Var ForeColor, ShadowColor As Color
		  If Self.Enabled = False Then
		    ForeColor = Colors.DisabledTextColor
		  ElseIf Highlighted = True Then
		    If Self.Toggled Or Self.AlwaysUseActiveColor Or MouseDown Or MouseHover Then
		      ForeColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		    Else
		      ForeColor = Colors.TextColor
		    End If
		  Else
		    ForeColor = Colors.TextColor
		  End If
		  ShadowColor = Colors.TextShadowColor
		  
		  Var OriginalForeColor As Color = ForeColor
		  If MouseDown And Self.Enabled Then
		    ForeColor = ForeColor.Darker(0.5)
		  End If
		  
		  // Draw as text, with an icon to the left if available.
		  // Accessory comes first, as it may change the hover and pressed appearances
		  
		  G.ShadowBrush = Self.CreateShadowBrush(ShadowColor)
		  
		  Var AccessoryImage As Picture
		  Var AccessoryRect As New Rect(G.Width - Self.AccessoryIconSize, NearestMultiple((G.Height - Self.AccessoryIconSize) / 2, G.ScaleY), Self.AccessoryIconSize, Self.AccessoryIconSize)
		  Var AccessoryColor As Color
		  Var WithAccessory As Boolean = True
		  If Self.CanBeClosed And (MouseHover Or MouseDown) Then
		    Var AccessoryPressed As Boolean = MouseDown
		    If (LocalMousePoint Is Nil) = False And AccessoryRect.Contains(LocalMousePoint) Then
		      G.DrawingColor = Colors.ToggledButtonInactiveColor
		      G.FillRoundRectangle(AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 6, 6)
		      MouseDown = False
		      ForeColor = OriginalForeColor
		    End If
		    
		    G.DrawPicture(BeaconUI.IconWithColor(IconClose, Colors.AccessoryColor), AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, IconClose.Width, IconClose.Height)
		    
		    If AccessoryPressed Then
		      If (LocalMousePoint Is Nil) = False And AccessoryRect.Contains(LocalMousePoint) Then
		        G.DrawingColor = &C00000090
		        G.FillRoundRectangle(AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 6, 6)
		      ElseIf Self.Enabled Then
		        G.DrawPicture(BeaconUI.IconWithColor(IconClose, &C00000090), AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, IconClose.Width, IconClose.Height)
		      End If
		    End If
		  ElseIf Self.HasUnsavedChanges Then
		    AccessoryColor = ForeColor
		    AccessoryImage = IconModified
		  ElseIf Self.CanBeClosed Then
		    AccessoryColor = Colors.AccessoryColor
		    AccessoryImage = IconClose
		  Else
		    WithAccessory = False
		  End If
		  If (AccessoryImage Is Nil) = False Then
		    AccessoryImage = BeaconUI.IconWithColor(AccessoryImage, AccessoryColor)
		    G.DrawPicture(AccessoryImage, AccessoryRect.Left, AccessoryRect.Top, AccessoryRect.Width, AccessoryRect.Height, 0, 0, AccessoryImage.Width, AccessoryImage.Height)
		  End If
		  
		  Var CaptionOffset As Double = 0
		  If HasIcon = True Then
		    CaptionOffset = Self.Icon.Width + Self.ElementSpacing
		    
		    Var IconTop As Double = NearestMultiple((G.Height - Self.Icon.Height) / 2, G.ScaleY)
		    Var Icon As Picture = BeaconUI.IconWithColor(Self.Icon, Forecolor)
		    G.DrawPicture(Icon, 0, IconTop, Icon.Width, Icon.Height, 0, 0, Icon.Width, Icon.Height)
		  End If
		  
		  If Self.Toggled Then
		    G.Bold = True
		  End If
		  
		  Var CaptionRect As New Rect(CaptionOffset, 0, If(WithAccessory, AccessoryRect.Left - Self.ElementSpacing, G.Width) - CaptionOffset, G.Height)
		  Var CaptionWidth As Double = Min(G.TextWidth(Self.Caption), CaptionRect.Width)
		  Var CaptionLeft As Double = NearestMultiple(CaptionRect.HorizontalCenter - (CaptionWidth / 2), G.ScaleX)
		  Var CaptionBaseline As Double = NearestMultiple((G.Height / 2) + (G.CapHeight / 2), G.ScaleY)
		  
		  G.DrawingColor = ForeColor
		  G.DrawText(Self.Caption, CaptionLeft, CaptionBaseline, CaptionRect.Width, True)
		  G.Bold = False
		  
		  G.ShadowBrush = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawTitle(G As Graphics, Colors As OmniBarColorProfile, MouseDown As Boolean, MouseHover As Boolean, LocalMousePoint As Point, Highlighted As Boolean)
		  #Pragma Unused MouseDown
		  #Pragma Unused MouseHover
		  #Pragma Unused LocalMousePoint
		  #Pragma Unused Highlighted
		  
		  G.Bold = True
		  
		  Var CaptionBaseline As Double = NearestMultiple((G.Height / 2) + (G.CapHeight / 2), G.ScaleY)
		  Var ForeColor, ShadowColor As Color
		  If Self.Enabled = False Then
		    ForeColor = Colors.DisabledTextColor
		  ElseIf Highlighted = True Then
		    If Self.Toggled Or Self.AlwaysUseActiveColor Or MouseDown Or MouseHover Then
		      ForeColor = Self.ActiveColorToColor(Self.ActiveColor, Colors)
		    Else
		      ForeColor = Colors.TextColor
		    End If
		  Else
		    ForeColor = Colors.TextColor
		  End If
		  ShadowColor = Colors.TextShadowColor
		  
		  G.ShadowBrush = Self.CreateShadowBrush(ShadowColor)
		  G.DrawingColor = ForeColor
		  G.DrawText(Self.Caption, 0, CaptionBaseline, Self.MaxCaptionWidth, True)
		  G.ShadowBrush = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FlexRange() As Beacon.Range
		  Select Case Self.mType
		  Case OmniBarItem.Types.Tab
		    Var MinWidth, MaxWidth As Integer
		    If Self.Caption.IsEmpty = False Then
		      MinWidth = Self.MinCaptionWidth
		      MaxWidth = Self.MaxCaptionWidth
		    End If
		    If (Self.Icon Is Nil) = False Then
		      If Self.Caption.IsEmpty Then
		        MinWidth = Self.Icon.Width + (Self.ButtonPadding * 2)
		        MaxWidth = MinWidth
		      Else
		        MinWidth = MinWidth + Self.Icon.Width
		        MaxWidth = MaxWidth + Self.Icon.Width
		      End If
		    End If
		    If Self.CanBeClosed Or Self.HasUnsavedChanges Then
		      MinWidth = MinWidth + Self.AccessoryIconSize
		      MaxWidth = MaxWidth + Self.AccessoryIconSize
		    End If
		    Return New Beacon.Range(MinWidth, MaxWidth)
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InsetRect() As Rect
		  Return Self.mLastInsetRect
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InsideAccessoryRegion(ItemRect As Rect, MousePoint As Point) As Boolean
		  If ItemRect Is Nil Or MousePoint Is Nil Or Self.mType <> OmniBarItem.Types.Tab Or Self.mCanBeClosed = False Or ItemRect.Contains(MousePoint) = False Then
		    Return False
		  End If
		  
		  Var AccessoryRect As New Rect(ItemRect.Right - Self.AccessoryIconSize, NearestMultiple(ItemRect.Top + ((ItemRect.Height - Self.AccessoryIconSize) / 2), 1.0), Self.AccessoryIconSize, Self.AccessoryIconSize)
		  Return AccessoryRect.Contains(MousePoint)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Margin(Against As OmniBarItem) As Integer
		  If (Against Is Nil) = False And Against.Type = OmniBarItem.Types.FlexSpace Then
		    Return 0
		  End If
		  
		  Select Case Self.Type
		  Case OmniBarItem.Types.Button, OmniBarItem.Types.Separator, OmniBarItem.Types.HorizontalResizer, OmniBarItem.Types.VerticalResizer
		    Return 10
		  Case OmniBarItem.Types.Tab, OmniBarItem.Types.Title
		    Return 20
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub mIndeterminateTimer_Action(Sender As Timer)
		  If Self.mIndeterminatePhase >= 1.0 Then
		    Self.mIndeterminateStep = (Sender.Period / 1000) * -1
		  ElseIf Self.mIndeterminatePhase <= 0.0 Then
		    Self.mIndeterminateStep = Sender.Period / 1000
		  End If
		  
		  Var OldPhase As Double = Self.mIndeterminatePhase
		  Self.mIndeterminatePhase = Self.mIndeterminatePhase + Self.mIndeterminateStep
		  Self.NotifyObservers("MinorChange", OldPhase, Self.mIndeterminatePhase)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NotifyObservers(Key As String, OldValue As Variant, NewValue As Variant)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		    
		    Var Observer As ObservationKit.Observer = ObservationKit.Observer(Refs(I).Value)
		    Observer.ObservedValueChanged(Self, Key, OldValue, NewValue)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As OmniBarItem) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  Return Self.mName.Compare(Other.mName, ComparisonOptions.CaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveObserver(Observer As ObservationKit.Observer, Key As String)
		  // Part of the ObservationKit.Observable interface.
		  
		  If Self.mObservers = Nil Then
		    Self.mObservers = New Dictionary
		  End If
		  
		  Var Refs() As WeakRef
		  If Self.mObservers.HasKey(Key) Then
		    Refs = Self.mObservers.Value(Key)
		  End If
		  
		  For I As Integer = Refs.LastIndex DownTo 0
		    If Refs(I).Value = Nil Or Refs(I).Value = Observer Then
		      Refs.RemoveAt(I)
		      Continue
		    End If
		  Next
		  
		  Self.mObservers.Value(Key) = Refs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetFont(G As Graphics)
		  G.FontUnit = FontUnits.Point
		  If Self.Compact(G) And Self.mType = OmniBarItem.Types.Button Then
		    G.FontSize = 10
		  Else
		    G.FontSize = 12
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Width(G As Graphics) As Integer
		  Self.SetFont(G)
		  
		  Var Segments() As Double
		  Select Case Self.mType
		  Case OmniBarItem.Types.FlexSpace
		    Segments.Add(0)
		  Case OmniBarItem.Types.Separator, OmniBarItem.Types.Space
		    Segments.Add(2)
		  Case OmniBarItem.Types.Button
		    If Self.mCaption.IsEmpty Then
		      Segments.Add(Self.ButtonIconSize + (Self.ButtonPadding * 2))
		    Else
		      Select Case Self.mButtonStyle
		      Case Self.ButtonStyleBottomCaption
		        Segments.Add(Max(Min(G.TextWidth(Self.Caption), Self.MaxCaptionWidth), Self.ButtonIconSize) + (Self.ButtonPadding * 2))
		      Case Self.ButtonStyleLeftCaption, Self.ButtonStyleRightCaption
		        Segments.Add(Min(G.TextWidth(Self.Caption), Self.MaxCaptionWidth) + Self.ButtonIconSize + (Self.ButtonPadding * 2))
		      End Select
		    End If
		  Case OmniBarItem.Types.Tab
		    If Self.Caption.IsEmpty = False Then
		      Var Bold As Boolean = G.Bold
		      G.Bold = True
		      Segments.Add(Min(Ceiling(G.TextWidth(Self.Caption) + 6), Self.MaxCaptionWidth))
		      G.Bold = Bold
		    End If
		    If (Self.Icon Is Nil) = False Then
		      If Self.Caption.IsEmpty Then
		        Segments.Add(Self.Icon.Width + (Self.ButtonPadding * 2))
		      Else
		        Segments.Add(Self.Icon.Width)
		      End If
		    End If
		    If Self.CanBeClosed Or Self.HasUnsavedChanges Then
		      Segments.Add(Self.AccessoryIconSize)
		    End If
		  Case OmniBarItem.Types.Title
		    Segments.Add(Min(Ceiling(G.TextWidth(Self.Caption) + 2), Self.MaxCaptionWidth))
		  Case OmniBarItem.Types.HorizontalResizer, OmniBarItem.Types.VerticalResizer
		    Segments.Add(Self.Icon.Width)
		  End Select
		  Return NearestMultiple(Segments.Sum(Self.ElementSpacing), 1.0) // Yes, round to nearest whole
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mActiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mActiveColor <> Value Then
			    Var OldValue As OmniBarItem.ActiveColors = Self.mActiveColor
			    Self.mActiveColor = Value
			    Self.NotifyObservers("MinorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		ActiveColor As OmniBarItem.ActiveColors
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mAlwaysUseActiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mAlwaysUseActiveColor <> Value Then
			    Self.mAlwaysUseActiveColor = Value
			    Self.NotifyObservers("MinorChange", Not Value, Value)
			  End If
			End Set
		#tag EndSetter
		AlwaysUseActiveColor As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mButtonStyle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mButtonStyle <> Value Then
			    Var OldValue As Integer = Self.mButtonStyle
			    Self.mButtonStyle = Value
			    Self.NotifyObservers("MajorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		ButtonStyle As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCanBeClosed
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCanBeClosed <> Value Then
			    Var WasWide As Boolean = Self.mCanBeClosed Or Self.mHasUnsavedChanges
			    Self.mCanBeClosed = Value
			    Var IsWide As Boolean = Self.mCanBeClosed Or Self.mHasUnsavedChanges
			    
			    If WasWide <> IsWide Then
			      Self.NotifyObservers("MajorChange", Not Value, Value)
			    Else
			      Self.NotifyObservers("MinorChange", Not Value, Value)
			    End If
			  End If
			End Set
		#tag EndSetter
		CanBeClosed As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mCaption
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mCaption.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Var OldValue As String = Self.mCaption
			    Self.mCaption = Value
			    Self.NotifyObservers("MajorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEnabled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEnabled <> Value Then
			    Self.mEnabled = Value
			    Self.NotifyObservers("MinorChange", Not Value, Value)
			  End If
			End Set
		#tag EndSetter
		Enabled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasMenu
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasMenu <> Value Then
			    Self.mHasMenu = Value
			    Self.NotifyObservers("MinorChange", Not Value, Value)
			  End If
			End Set
		#tag EndSetter
		HasMenu As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasProgressIndicator
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasProgressIndicator <> Value Then
			    Self.mHasProgressIndicator = Value
			    Self.CheckProgressTimer()
			    Self.NotifyObservers("MinorChange", Not Value, Value)
			  End If
			End Set
		#tag EndSetter
		HasProgressIndicator As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHasUnsavedChanges
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHasUnsavedChanges <> Value Then
			    Var WasWide As Boolean = Self.mCanBeClosed Or Self.mHasUnsavedChanges
			    Self.mHasUnsavedChanges = Value
			    Var IsWide As Boolean = Self.mCanBeClosed Or Self.mHasUnsavedChanges
			    
			    If WasWide <> IsWide Then
			      Self.NotifyObservers("MajorChange", Not Value, Value)
			    Else
			      Self.NotifyObservers("MinorChange", Not Value, Value)
			    End If
			  End If
			End Set
		#tag EndSetter
		HasUnsavedChanges As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHelpTag
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHelpTag.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Var OldValue As String = Self.mHelpTag
			    Self.mHelpTag = Value
			    Self.NotifyObservers("MinorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		HelpTag As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var Major As Boolean
			  Major = ((Self.mIcon Is Nil) And (Value Is Nil) = False) Or ((Self.mIcon Is Nil) = False And (Value Is Nil))
			  
			  Var OldValue As Picture = Self.mIcon
			  Self.mIcon = Value
			  
			  If Major Then
			    Self.NotifyObservers("MajorChange", OldValue, Value)
			  Else
			    Self.NotifyObservers("MinorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		Icon As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIndeterminatePhase
			End Get
		#tag EndGetter
		IndeterminatePhase As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Select Case Self.mType
			  Case Types.Button, Types.Tab, Types.Title, Types.HorizontalResizer, Types.VerticalResizer
			    Return True
			  End Select
			End Get
		#tag EndGetter
		IsContentItem As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mType = OmniBarItem.Types.Tab And Self.mIsFlexible = True
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Var OldValue As Boolean = Self.IsFlexible
			  If OldValue <> Value Then
			    Self.mIsFlexible = Value
			    Self.NotifyObservers("MajorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		IsFlexible As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mType = Types.HorizontalResizer Or Self.mType = Types.VerticalResizer
			End Get
		#tag EndGetter
		IsResizer As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mActiveColor As OmniBarItem.ActiveColors
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAlwaysUseActiveColor As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mButtonStyle As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCanBeClosed As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mEnabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasMenu As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasProgressIndicator As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHasUnsavedChanges As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHelpTag As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndeterminatePhase As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndeterminateStep As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIndeterminateTimer As Timer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIsFlexible As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastInsetRect As Rect
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObservers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPriority As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProgress As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mToggled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mType As OmniBarItem.Types
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mVisible As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mName.Compare(Value, ComparisonOptions.CaseSensitive) <> 0 Then
			    Var OldValue As String = Self.mName
			    Self.mName = Value
			    Self.NotifyObservers("MinorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		Name As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPriority
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPriority <> Value Then
			    Var OldValue As Integer = Self.mPriority
			    Self.mPriority = Value
			    Self.NotifyObservers("MinorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		Priority As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProgress
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProgress <> Value Then
			    Var OldValue As Double = Self.mProgress
			    Self.mProgress = Value
			    Self.CheckProgressTimer()
			    Self.NotifyObservers("MinorChange", OldValue, Value)
			  End If
			End Set
		#tag EndSetter
		Progress As Double
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mToggled
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mToggled <> Value Then
			    Self.mToggled = Value
			    Self.NotifyObservers("MinorChange", Not Value, Value)
			  End If
			End Set
		#tag EndSetter
		Toggled As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mType
			End Get
		#tag EndGetter
		Type As OmniBarItem.Types
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mVisible
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mVisible <> Value Then
			    Self.mVisible = Value
			    Self.NotifyObservers("MajorChange", Not Value, Value)
			  End If
			End Set
		#tag EndSetter
		Visible As Boolean
	#tag EndComputedProperty


	#tag Constant, Name = AccessoryIconSize, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ButtonIconSize, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ButtonPadding, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ButtonStyleBottomCaption, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ButtonStyleLeftCaption, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ButtonStyleRightCaption, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ElementSpacing, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MaxCaptionWidth, Type = Double, Dynamic = False, Default = \"250", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MinCaptionWidth, Type = Double, Dynamic = False, Default = \"40", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ProgressIndeterminate, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant


	#tag Enum, Name = ActiveColors, Type = Integer, Flags = &h0
		Accent
		  Blue
		  Brown
		  Gray
		  Green
		  Orange
		  Pink
		  Purple
		  Red
		Yellow
	#tag EndEnum

	#tag Enum, Name = Types, Type = Integer, Flags = &h0
		Tab
		  Button
		  Space
		  FlexSpace
		  Separator
		  Title
		  HorizontalResizer
		VerticalResizer
	#tag EndEnum


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="ActiveColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="OmniBarItem.ActiveColors"
			EditorType="Enum"
			#tag EnumValues
				"0 - Accent"
				"1 - Blue"
				"2 - Brown"
				"3 - Gray"
				"4 - Green"
				"5 - Orange"
				"6 - Pink"
				"7 - Purple"
				"8 - Red"
				"9 - Yellow"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AlwaysUseActiveColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CanBeClosed"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Caption"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasProgressIndicator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasUnsavedChanges"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
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
			Name="HasMenu"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Toggled"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IndeterminatePhase"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Type"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="OmniBarItem.Types"
			EditorType="Enum"
			#tag EnumValues
				"0 - Tab"
				"1 - Button"
				"2 - Space"
				"3 - FlexSpace"
				"4 - Separator"
				"5 - Title"
				"6 - HorizontalResizer"
				"7 - VerticalResizer"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsContentItem"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsResizer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Priority"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsFlexible"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ButtonStyle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
