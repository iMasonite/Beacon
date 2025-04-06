#tag Class
Protected Class IconCanvas
Inherits ControlCanvas
	#tag Event
		Sub Activated()
		  RaiseEvent Activated
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Sub Deactivated()
		  RaiseEvent Deactivated
		  Self.Refresh
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma Unused X
		  #Pragma Unused Y
		  
		  If Self.Clickable = False Then
		    Return False
		  End If
		  
		  If Self.Enabled Then
		    Self.mPressed = True
		    Self.Refresh
		  End If
		  
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(X As Integer, Y As Integer)
		  Var IsInside As Boolean = X >= 0 And Y >= 0 And X <= Self.Width And Y <= Self.Height
		  If IsInside Then
		    If Self.mPressed = False Then
		      Self.mPressed = True
		      Self.Refresh
		    End If
		  Else
		    If Self.mPressed Then
		      Self.mPressed = False
		      Self.Refresh
		    End If
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  Var IsInside As Boolean = X >= 0 And Y >= 0 And X <= Self.Width And Y <= Self.Height
		  If Self.mPressed Then
		    Self.mPressed = False
		    Self.Refresh
		  End If
		  If IsInside Then
		    RaiseEvent Pressed
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(G As Graphics, Areas() As Rect, Highlighted As Boolean, SafeArea As Rect)
		  #Pragma Unused Areas
		  #Pragma Unused SafeArea
		  
		  Var IconColor As Color
		  Select Case Self.IconColor
		  Case IconCanvas.ColorChoice.Accent
		    IconColor = SystemColors.SelectedContentBackgroundColor
		  Case IconCanvas.ColorChoice.Blue
		    IconColor = SystemColors.SystemBrownColor
		  Case IconCanvas.ColorChoice.Brown
		    IconColor = SystemColors.SystemBrownColor
		  Case IconCanvas.ColorChoice.Gray
		    IconColor = SystemColors.SystemGrayColor
		  Case IconCanvas.ColorChoice.Green
		    IconColor = SystemColors.SystemGreenColor
		  Case IconCanvas.ColorChoice.Orange
		    IconColor = SystemColors.SystemOrangeColor
		  Case IconCanvas.ColorChoice.Pink
		    IconColor = SystemColors.SystemPinkColor
		  Case IconCanvas.ColorChoice.Purple
		    IconColor = SystemColors.SystemPurpleColor
		  Case IconCanvas.ColorChoice.Red
		    IconColor = SystemColors.SystemRedColor
		  Case IconCanvas.ColorChoice.Yellow
		    IconColor = SystemColors.SystemYellowColor
		  End Select
		  
		  If Not Highlighted Then
		    Var Lum As Double = IconColor.Luminance
		    IconColor = Color.RGB(255 * Lum, 255 * Lum, 255 * Lum)
		  End If
		  
		  IconColor = BeaconUI.FindContrastingColors(SystemColors.WindowBackgroundColor, IconColor, BeaconUI.ContrastModeForeground, BeaconUI.ContrastRequiredIcons).Foreground
		  
		  Var Icon As Picture = BeaconUI.IconWithColor(Self.Icon, IconColor, G.ScaleX, G.ScaleX)
		  G.DrawPicture(Icon, 0, 0)
		  
		  If Self.mPressed Then
		    Var PressOverlay As Picture = BeaconUI.IconWithColor(Self.Icon, &c000000AA, G.ScaleX, G.ScaleX)
		    G.DrawPicture(PressOverlay, 0, 0)
		  End If
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Activated()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Deactivated()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Pressed()
	#tag EndHook


	#tag Property, Flags = &h0
		Clickable As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIcon <> Value Then
			    Self.mIcon = Value
			    Self.Refresh
			  End If
			End Set
		#tag EndSetter
		Icon As Picture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIconColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIconColor <> Value Then
			    Self.mIconColor = Value
			    Self.Refresh
			  End If
			End Set
		#tag EndSetter
		IconColor As IconCanvas.ColorChoice
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mIcon As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIconColor As IconCanvas.ColorChoice
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPressed As Boolean
	#tag EndProperty


	#tag Enum, Name = ColorChoice, Type = Integer, Flags = &h0
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
			InitialValue=""
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
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Backdrop"
			Visible=true
			Group="Appearance"
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
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocus"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue=""
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
		#tag ViewProperty
			Name="ScrollSpeed"
			Visible=false
			Group="Behavior"
			InitialValue="20"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollActive"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollingEnabled"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentHeight"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IconColor"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="IconCanvas.ColorChoice"
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
			Name="Clickable"
			Visible=true
			Group="Behavior"
			InitialValue="False"
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
	#tag EndViewBehavior
End Class
#tag EndClass
