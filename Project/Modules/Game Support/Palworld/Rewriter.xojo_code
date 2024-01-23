#tag Class
Protected Class Rewriter
Inherits Global.Thread
	#tag CompatibilityFlags = ( TargetConsole and ( Target32Bit or Target64Bit ) ) or ( TargetWeb and ( Target32Bit or Target64Bit ) ) or ( TargetDesktop and ( Target32Bit or Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) or ( TargetAndroid and ( Target64Bit ) )
	#tag Event
		Sub Run()
		  Self.mFinished = False
		  Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerStarted))
		  
		  Self.mFinishedSettingsIniContent = ""
		  
		  // Load everything we need into local variables in case something changes while the process is running.
		  Var LegacyTrustKey As String = Self.mProject.LegacyTrustKey
		  
		  Var Format As EncodingFormat = EncodingFormat.ASCII
		  Var Project As Palworld.Project = Self.mProject
		  Var Identity As Beacon.Identity = Self.mIdentity
		  Var Profile As Palworld.ServerProfile = Self.mProfile
		  Var InitialSettingsIni As String = Self.mInitialSettingsIniContent
		  
		  If Self.mOrganizer Is Nil Or Self.mRebuildOrganizer Then
		    If (Self.mOutputFlags And Self.FlagForceTrollMode) = Self.FlagForceTrollMode Then
		      Self.mOrganizer = Project.CreateTrollConfigOrganizer(Profile)
		    Else
		      Self.mOrganizer = Project.CreateConfigOrganizer(Identity, Profile)
		    End If
		    Self.mRebuildOrganizer = False
		  End If
		  
		  Var Error As RuntimeException
		  
		  If (Self.mOutputFlags And Self.FlagCreateSettingsIni) = Self.FlagCreateSettingsIni Then
		    Var SettingsIni As String = Self.Rewrite(Self.mSource, InitialSettingsIni, Palworld.HeaderPalworldSettings, Palworld.ConfigFileSettings, Self.mOrganizer, Project.ProjectId, LegacyTrustKey, Format, False, Error)
		    If (Error Is Nil) = False Then
		      Self.mFinished = True
		      Self.mError = Error
		      Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		      Return
		    End If
		    Self.mFinishedSettingsIniContent = SettingsIni
		  End If
		  
		  Self.mFinished = True
		  Self.mError = Error
		  Self.mTriggers.Add(CallLater.Schedule(1, WeakAddressOf TriggerFinished))
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Cancel()
		  If Self.ThreadState <> Thread.ThreadStates.NotRunning Then
		    Self.Stop
		  End If
		  
		  For I As Integer = Self.mTriggers.LastIndex DownTo 0
		    CallLater.Cancel(Self.mTriggers(I))
		    Self.mTriggers.RemoveAt(I)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ConvertEncoding(Content As String, Format As Palworld.Rewriter.EncodingFormat) As String
		  If Format = Palworld.Rewriter.EncodingFormat.Unicode Then
		    If Content.Encoding <> Encodings.UTF8 Then
		      Content = Content.ConvertEncoding(Encodings.UTF8)
		    End If
		    Return Content
		  End If
		  
		  If Content.Encoding <> Encodings.ASCII Then
		    Content = Content.ConvertEncoding(Encodings.ASCII)
		  End If
		  
		  Return Content
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  For I As Integer = Self.mTriggers.LastIndex DownTo 0
		    CallLater.Cancel(Self.mTriggers(I))
		    Self.mTriggers.RemoveAt(I)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Error() As RuntimeException
		  Return Self.mError
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Errored() As Boolean
		  Return (Self.mError Is Nil) = False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Finished() As Boolean
		  Return Self.mFinished
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OutputFlags() As Integer
		  Return Self.mOutputFlags
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rewrite(Flags As Integer)
		  Self.mOutputFlags = Flags And (Self.FlagCreateSettingsIni Or Self.FlagForceTrollMode)
		  Super.Start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As Palworld.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Organizer As Palworld.ConfigOrganizer, Format As Palworld.Rewriter.EncodingFormat, Nuke As Boolean, ByRef Error As RuntimeException) As String
		  // This version will not contain the [Beacon] sections in the output
		  Try
		    Return Rewrite(Source, InitialContent, DefaultHeader, File, Organizer, "", "", Format, Nuke, Error)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As Palworld.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Organizer As Palworld.ConfigOrganizer, ProjectUUID As String, LegacyTrustKey As String, Format As Palworld.Rewriter.EncodingFormat, Nuke As Boolean, ByRef Error As RuntimeException) As String
		  // This is the new master method
		  
		  Try
		    // Even if we're about to nuke the file, determine the mode so the file can be rebuilt in the same format
		    InitialContent = InitialContent.GuessEncoding("/Script/").SanitizeIni
		    Var DesiredLineEnding As String = InitialContent.DetectLineEnding
		    If Nuke Then
		      InitialContent = ""
		    End If
		    
		    // Get the initial values into an organizer
		    Var ParsedValues As New Palworld.ConfigOrganizer(File, DefaultHeader, InitialContent)
		    ParsedValues.Remove(Organizer.ManagedKeys) // Remove anything our groups already generate
		    
		    // Use the old Beacon section to determine which values to remove
		    Var Trusted As Boolean
		    Var TrustValues() As Palworld.ConfigValue
		    If ProjectUUID.IsEmpty = False Then
		      TrustValues = ParsedValues.FilteredValues(File, "Beacon", "ProjectUUID")
		      For Each TrustValue As Palworld.ConfigValue In TrustValues
		        If TrustValue.Value = ProjectUUID Then
		          Trusted = True
		          Continue
		        End If
		      Next TrustValue
		    End If
		    If Trusted = False And LegacyTrustKey.IsEmpty = False Then
		      TrustValues = ParsedValues.FilteredValues(File, "Beacon", "Trust")
		      For Each TrustValue As Palworld.ConfigValue In TrustValues
		        If TrustValue.Value = LegacyTrustKey Then
		          Trusted = True
		          Continue
		        End If
		      Next
		    End If
		    
		    If Trusted Then
		      // Thanks to a deploy bug in how Beacon blends configs from InitialContent, do not trust if the deploy version is between > 1.4.8.4 and < 1.5.0.5
		      Var TrustVersions() As Palworld.ConfigValue = ParsedValues.FilteredValues(File, "Beacon", "Build")
		      For Each TrustVersion As Palworld.ConfigValue In TrustVersions
		        Try
		          Var TrustBuild As Integer = TrustVersion.Value.ToInteger
		          If TrustBuild > 10408304 And TrustBuild < 10500305 Then
		            Trusted = False
		          End If
		        Catch Err As RuntimeException
		          // Let's err on the side of caution
		          Trusted = False
		        End Try
		      Next
		    End If
		    
		    If Trusted Then
		      Var ManagedKeys() As Palworld.ConfigValue = ParsedValues.FilteredValues(File, "Beacon", "ManagedKeys")
		      For Each ManagedKey As Palworld.ConfigValue In ManagedKeys
		        Var ManagedSectionStartPos As Integer = ManagedKey.Value.IndexOf("Section=""")
		        If ManagedSectionStartPos = -1 Then
		          Continue
		        End If
		        ManagedSectionStartPos = ManagedSectionStartPos + 9
		        Var ManagedSectionEndPos As Integer = ManagedKey.Value.IndexOf(ManagedSectionStartPos, """")
		        If ManagedSectionEndPos = -1 Then
		          Continue
		        End If
		        Var ManagedSection As String = ManagedKey.Value.Middle(ManagedSectionStartPos, ManagedSectionEndPos - ManagedSectionStartPos)
		        
		        Var KeysStartPos As Integer = ManagedKey.Value.IndexOf("Keys=(")
		        If KeysStartPos = -1 Then
		          Continue
		        End If
		        KeysStartPos = KeysStartPos + 6
		        Var KeysEndPos As Integer = ManagedKey.Value.IndexOf(KeysStartPos, ")")
		        If KeysEndPos = -1 Then
		          Continue
		        End If
		        Var KeysString As String = ManagedKey.Value.Middle(KeysStartPos, KeysEndPos - KeysStartPos)
		        
		        Var Keys() As String = KeysString.Split(",")
		        For Each Key As String In Keys
		          ParsedValues.Remove(File, ManagedSection, Key)
		        Next
		      Next
		    End If
		    
		    // Remove the old Beacon section
		    ParsedValues.Remove(File, "Beacon")
		    
		    // Create a new organizer with the values from the original and unique values from the parsed
		    Var FinalOrganizer As New Palworld.ConfigOrganizer
		    FinalOrganizer.Add(Organizer.FilteredValues(File)) // Automatically grabs command line options
		    
		    // Remove everything from Parsed that is in Final, but don't do it by hash
		    Var NewValues() As Palworld.ConfigValue = FinalOrganizer.FilteredValues(File)
		    For Each Value As Palworld.ConfigValue In NewValues
		      ParsedValues.Remove(Value.File, Value.Header, Value.SimplifiedKey)
		    Next
		    
		    If FinalOrganizer.Count = 0 And ParsedValues.Count = 0 Then
		      // Both the new stuff and the initial stuff are empty
		      Return ""
		    End If
		    
		    If ProjectUUID.IsEmpty = False Then
		      // Build the Beacon section
		      Var SourceString As String = CType(Source, Integer).ToString(Locale.Raw, "0")
		      Select Case Source
		      Case Sources.Deploy
		        SourceString = "Deploy"
		      Case Sources.Original
		        SourceString = "Original"
		      Case Sources.SmartCopy
		        SourceString = "Smart Copy"
		      Case Sources.SmartSave
		        SourceString = "Smart Save"
		      End Select
		      
		      FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "Build=" + App.BuildNumber.ToString(Locale.Raw, "0")))
		      FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "LastUpdated=" + DateTime.Now.SQLDateTimeWithOffset))
		      FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "ProjectUUID=" + ProjectUUID))
		      If LegacyTrustKey.IsEmpty = False Then
		        FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "Trust=" + LegacyTrustKey))
		      End If
		      FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "Source=" + SourceString))
		      FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "InitialSize=" + InitialContent.Bytes.ToString(Locale.Raw, "0")))
		      FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "InitialHash=" + EncodeHex(Crypto.SHA2_256(InitialContent)).Lowercase))
		      FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "WasTrusted=" + If(Trusted, "True", "False")))
		      Var ManagedHeaders() As String = Organizer.Headers(File)
		      For HeaderIdx As Integer = 0 To ManagedHeaders.LastIndex
		        Var Header As String = ManagedHeaders(HeaderIdx)
		        If Header = "Beacon" Then
		          Continue
		        End If
		        
		        Var Keys() As String = FinalOrganizer.Keys(File, Header)
		        FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", "ManagedKeys=(Section=""" + Header + """,Keys=(" + Keys.Join(",") + "))", "ManagedKeys:" + Header))
		      Next
		      
		      Var BeaconKeys() As String = Organizer.BeaconKeys
		      For Each BeaconKey As String In BeaconKeys
		        Var BeaconKeyValue As String = Organizer.BeaconKey(BeaconKey)
		        FinalOrganizer.Add(New Palworld.ConfigValue(File, "Beacon", BeaconKey + "=" + BeaconKeyValue))
		      Next BeaconKey
		    End If
		    
		    // Now add everything remaining in Parsed to Final
		    FinalOrganizer.Add(ParsedValues.FilteredValues(File))
		    
		    Return ConvertEncoding(FinalOrganizer.Build(File).ReplaceLineEndings(DesiredLineEnding), Format)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function Rewrite(Source As Palworld.Rewriter.Sources, InitialContent As String, DefaultHeader As String, File As String, Project As Palworld.Project, Identity As Beacon.Identity, Profile As Palworld.ServerProfile, Format As Palworld.Rewriter.EncodingFormat, Nuke As Boolean, ByRef Error As RuntimeException) As String
		  Try
		    Var Organizer As Palworld.ConfigOrganizer = Project.CreateConfigOrganizer(Identity, Profile)
		    Return Rewrite(Source, InitialContent, DefaultHeader, File, Organizer, Project.ProjectId, Project.LegacyTrustKey, Format, Nuke, Error)
		  Catch Err As RuntimeException
		    Error = Err
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Start()
		  Super.Start()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerFinished()
		  RaiseEvent Finished
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TriggerStarted()
		  RaiseEvent Started
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Finished()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Started()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFinishedSettingsIniContent
			End Get
		#tag EndGetter
		FinishedSettingsIniContent As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mIdentity
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mIdentity <> Value Then
			    Self.mIdentity = Value
			    Self.mRebuildOrganizer = True
			  End If
			End Set
		#tag EndSetter
		Identity As Beacon.Identity
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mInitialSettingsIniContent
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mInitialSettingsIniContent = Value.SanitizeIni
			End Set
		#tag EndSetter
		InitialSettingsIniContent As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mError As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinished As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFinishedSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIdentity As Beacon.Identity
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInitialSettingsIniContent As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOrganizer As Palworld.ConfigOrganizer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOutputFlags As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProfile As Palworld.ServerProfile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mProject As Palworld.Project
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRebuildOrganizer As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSource As Palworld.Rewriter.Sources
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTriggers() As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProfile
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  // Don't just use <> here, it does not compare correctly with Nitrado
			  
			  If Value Is Nil Then
			    If Self.mProfile Is Nil Then
			      Return
			    End If
			    
			    Self.mProfile = Nil
			    Self.mRebuildOrganizer = True
			    Return
			  End If
			  
			  If (Self.mProfile Is Nil) = False And Self.mProfile.Hash = Value.Hash Then
			    Return
			  End If
			  
			  Self.mProfile = Value
			  Self.mRebuildOrganizer = True
			End Set
		#tag EndSetter
		Profile As Palworld.ServerProfile
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mProject
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mProject <> Value Then
			    Self.mProject = Value
			    Self.mRebuildOrganizer = True
			  End If
			End Set
		#tag EndSetter
		Project As Palworld.Project
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mSource
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  Self.mSource = Value
			End Set
		#tag EndSetter
		Source As Palworld.Rewriter.Sources
	#tag EndComputedProperty


	#tag Constant, Name = FlagCreateSettingsIni, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FlagForceTrollMode, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = ModeSettingsIni, Type = String, Dynamic = False, Default = \"PalWorldSettings.ini", Scope = Public
	#tag EndConstant


	#tag Enum, Name = EncodingFormat, Type = Integer, Flags = &h0
		Unicode
		ASCII
	#tag EndEnum

	#tag Enum, Name = Sources, Type = Integer, Flags = &h0
		Original
		  Deploy
		  SmartCopy
		SmartSave
	#tag EndEnum


	#tag ViewBehavior
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
			Name="DebugIdentifier"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ThreadState"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="ThreadStates"
			EditorType="Enum"
			#tag EnumValues
				"0 - Running"
				"1 - Waiting"
				"2 - Paused"
				"3 - Sleeping"
				"4 - NotRunning"
			#tag EndEnumValues
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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
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
			Name="Priority"
			Visible=true
			Group="Behavior"
			InitialValue="5"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="StackSize"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialSettingsIniContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FinishedSettingsIniContent"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Source"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Palworld.Rewriter.Sources"
			EditorType="Enum"
			#tag EnumValues
				"0 - Original"
				"1 - Deploy"
				"2 - SmartCopy"
				"3 - SmartSave"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
