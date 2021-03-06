#tag Class
Protected Class FTPServerProfile
Inherits Beacon.ServerProfile
	#tag Event
		Sub ReadFromDictionary(Dict As Xojo.Core.Dictionary)
		  If Not Dict.HasAllKeys("Host", "Port", "User", "Pass", "Game.ini Path", "GameUserSettings.ini Path") Then
		    Dim Err As KeyNotFoundException
		    Err.Message = "Missing FTPServerProfile keys"
		    Raise Err
		  End If
		  
		  Self.mHost = Dict.Value("Host")
		  Self.mPort = Dict.Value("Port")
		  Self.mUsername = Dict.Value("User")
		  Self.mPassword = Dict.Value("Pass")
		  Self.mGameIniPath = Dict.Value("Game.ini Path")
		  Self.mGameUserSettingsIniPath = Dict.Value("GameUserSettings.ini Path")
		End Sub
	#tag EndEvent

	#tag Event
		Sub WriteToDictionary(Dict As Xojo.Core.Dictionary)
		  Dict.Value("Provider") = "FTP"
		  Dict.Value("Host") = Self.mHost
		  Dict.Value("Port") = Self.mPort
		  Dict.Value("User") = Self.mUsername
		  Dict.Value("Pass") = Self.mPassword
		  Dict.Value("Game.ini Path") = Self.mGameIniPath
		  Dict.Value("GameUserSettings.ini Path") = Self.mGameUserSettingsIniPath
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Constructor()
		  // Do not call Super.Constructor()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.ServerProfile) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Not (Other IsA Beacon.FTPServerProfile) Then
		    Return Super.Operator_Compare(Other)
		  End If
		  
		  Return Self.ServerID.Compare(Beacon.FTPServerProfile(Other).ServerID, Text.CompareCaseSensitive)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SecondaryName() As Text
		  Return Self.Username + "@" + Self.Host + ":" + Self.Port.ToText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ServerID() As Text
		  Return Self.mUsername.Lowercase + "@" + Self.mHost.Lowercase + If(Self.mGameIniPath.BeginsWith("/"), "", "/") + Self.mGameIniPath
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGameIniPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGameIniPath.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mGameIniPath = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GameIniPath As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mGameUserSettingsIniPath
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mGameUserSettingsIniPath.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mGameUserSettingsIniPath = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		GameUserSettingsIniPath As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mHost
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mHost.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mHost = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Host As Text
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGameIniPath As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGameUserSettingsIniPath As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHost As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPassword As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mPort As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUsername As Text
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mPassword
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mPassword.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mPassword = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Password As Text
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If Self.mPort = 0 Then
			    Self.mPort = 21
			  End If
			  Return Self.mPort
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Value = 0 Then
			    Value = 21
			  End If
			  If Self.mPort <> Value Then
			    Self.mPort = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Port As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mUsername
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mUsername.Compare(Value, Text.CompareCaseSensitive) <> 0 Then
			    Self.mUsername = Value
			    Self.Modified = True
			  End If
			End Set
		#tag EndSetter
		Username As Text
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Enabled"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Modified"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GameIniPath"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GameUserSettingsIniPath"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Host"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Password"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="Text"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
