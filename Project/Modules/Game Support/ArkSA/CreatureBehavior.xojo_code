#tag Class
Protected Class CreatureBehavior
Implements Beacon.BlueprintConsumer
	#tag Method, Flags = &h0
		Function Clone(NewTarget As ArkSA.Creature) As ArkSA.CreatureBehavior
		  Var Result As New ArkSA.CreatureBehavior(Self)
		  Result.mTargetCreature = New ArkSA.BlueprintReference(NewTarget)
		  Result.mModified = True
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Reference As ArkSA.BlueprintReference)
		  Self.mTargetCreature = Reference
		  Self.mDamageMultiplier = 1.0
		  Self.mResistanceMultiplier = 1.0
		  Self.mTamedDamageMultiplier = 1.0
		  Self.mTamedResistanceMultiplier = 1.0
		  Self.mProhibitSpawning = False
		  Self.mReplacementCreature = Nil
		  Self.mProhibitTaming = False
		  Self.mProhibitTransfer = False
		  Self.mWildSpeedMultiplier = 1.0
		  Self.mTamedSpeedMultiplier = 1.0
		  Self.mTamedStaminaMultiplier = 1.0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Creature As ArkSA.Creature)
		  Self.Constructor(New ArkSA.BlueprintReference(Creature))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As ArkSA.CreatureBehavior)
		  Self.mTargetCreature = Source.mTargetCreature
		  Self.mReplacementCreature = Source.mReplacementCreature
		  Self.mProhibitSpawning = Source.mProhibitSpawning
		  Self.mModified = Source.mModified
		  Self.mDamageMultiplier = Source.mDamageMultiplier
		  Self.mResistanceMultiplier = Source.mResistanceMultiplier
		  Self.mTamedDamageMultiplier = Source.mTamedDamageMultiplier
		  Self.mTamedResistanceMultiplier = Source.mTamedResistanceMultiplier
		  Self.mProhibitTaming = Source.mProhibitTaming
		  Self.mProhibitTransfer = Source.mProhibitTransfer
		  Self.mWildSpeedMultiplier = Source.mWildSpeedMultiplier
		  Self.mTamedSpeedMultiplier = Source.mTamedSpeedMultiplier
		  Self.mTamedStaminaMultiplier = Source.mTamedStaminaMultiplier
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CreatureId() As String
		  Return Self.mTargetCreature.BlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DamageMultiplier() As Double
		  Return Self.mDamageMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromDictionary(Dict As Dictionary) As ArkSA.CreatureBehavior
		  
		  Var Behavior As ArkSA.CreatureBehavior
		  If Dict.HasKey("Target") Then
		    Var Reference As ArkSA.BlueprintReference = ArkSA.BlueprintReference.FromSaveData(Dict.Value("Target"))
		    If Reference Is Nil Or Reference.IsCreature = False Then
		      Return Nil
		    End If
		    Behavior = New ArkSA.CreatureBehavior(Reference)
		  ElseIf Dict.HasAnyKey("UUID", "Path", "Class") Then
		    Var Creature As ArkSA.Creature = ArkSA.ResolveCreature(Dict, "UUID", "Path", "Class", Nil, True)
		    If Creature Is Nil Then
		      Return Nil
		    End If
		    Behavior = New ArkSA.CreatureBehavior(Creature)
		  Else
		    Return Nil
		  End If
		  
		  If Dict.HasKey("Prohibit Spawning") Then
		    Behavior.mProhibitSpawning = Dict.Value("Prohibit Spawning")
		  ElseIf Dict.HasKey("Replacement") Then
		    Var Reference As ArkSA.BlueprintReference = ArkSA.BlueprintReference.FromSaveData(Dict.Value("Replacement"))
		    If (Reference Is Nil) = False And Reference.IsCreature Then
		      Behavior.mReplacementCreature = Reference
		    End If
		  ElseIf Dict.HasAnyKey("Replacement UUID", "Replacement Path", "Replacement Class") Then
		    Var Creature As ArkSA.Creature = ArkSA.ResolveCreature(Dict, "Replacement UUID", "Replacement Path", "Replacement Class", Nil, True)
		    If (Creature Is Nil) = False Then
		      Behavior.mReplacementCreature = New ArkSA.BlueprintReference(Creature)
		    End If
		  Else
		    Behavior.mDamageMultiplier = Dict.Lookup("Damage Multiplier", 1.0)
		    Behavior.mResistanceMultiplier = Dict.Lookup("Resistance Multiplier", 1.0)
		    Behavior.mTamedDamageMultiplier = Dict.Lookup("Tamed Damage Multiplier", 1.0)
		    Behavior.mTamedResistanceMultiplier = Dict.Lookup("Tamed Resistance Multiplier", 1.0)
		    Behavior.mTamedSpeedMultiplier = Dict.Lookup("Tamed Speed Multiplier", 1.0)
		    Behavior.mTamedStaminaMultiplier = Dict.Lookup("Tamed Stamina Multiplier", 1.0)
		    Behavior.mWildSpeedMultiplier = Dict.Lookup("Wild Speed Multiplier", 1.0)
		  End If
		  Behavior.mProhibitTaming = Dict.Lookup("Prevent Taming", False)
		  Behavior.mProhibitTransfer = Dict.Lookup("Prohibit Transfer", False)
		  
		  Return Behavior
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MigrateBlueprints(Migrator As Beacon.BlueprintMigrator) As Boolean
		  // Part of the Beacon.BlueprintConsumer interface.
		  
		  Var Changed As Boolean
		  Var NewTargetRef As ArkSA.BlueprintReference = ArkSA.FindMigratedBlueprint(Migrator, Self.mTargetCreature)
		  If (NewTargetRef Is Nil) = False And NewTargetRef.IsCreature Then
		    Self.mTargetCreature = NewTargetRef
		    Self.Modified = True
		    Changed = True
		  End If
		  
		  Var NewReplacementRef As ArkSA.BlueprintReference = ArkSA.FindMigratedBlueprint(Migrator, Self.mReplacementCreature)
		  If (NewReplacementRef Is Nil) = False And NewReplacementRef.IsCreature Then
		    Self.mReplacementCreature = NewReplacementRef
		    Self.Modified = True
		    Changed = True
		  End If
		  Return Changed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  Return Self.mModified
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  Self.mModified = Value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Deprecated = "CreatureId" )  Function ObjectID() As String
		  Return Self.mTargetCreature.BlueprintId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProhibitSpawning() As Boolean
		  Return Self.mProhibitSpawning
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProhibitTaming() As Boolean
		  Return Self.mProhibitTaming
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProhibitTransfer() As Boolean
		  Return Self.mProhibitTransfer
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreature() As ArkSA.Creature
		  If (Self.mReplacementCreature Is Nil) = False Then
		    Return ArkSA.Creature(Self.mReplacementCreature.Resolve)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreatureId() As String
		  If (Self.mReplacementCreature Is Nil) = False Then
		    Return Self.mReplacementCreature.BlueprintId
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ReplacementCreatureReference() As ArkSA.BlueprintReference
		  Return Self.mReplacementCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ResistanceMultiplier() As Double
		  Return Self.mResistanceMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedDamageMultiplier() As Double
		  Return Self.mTamedDamageMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedResistanceMultiplier() As Double
		  Return Self.mTamedResistanceMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedSpeedMultiplier() As Double
		  Return Self.mTamedSpeedMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TamedStaminaMultiplier() As Double
		  Return Self.mTamedStaminaMultiplier
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TargetCreature() As ArkSA.Creature
		  Return ArkSA.Creature(Self.mTargetCreature.Resolve)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TargetCreatureReference() As ArkSA.BlueprintReference
		  Return Self.mTargetCreature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDictionary() As Dictionary
		  Var Dict As New Dictionary
		  Dict.Value("Target") = Self.mTargetCreature.SaveData
		  If Self.mProhibitSpawning Then
		    Dict.Value("Prohibit Spawning") = True
		  ElseIf IsNull(Self.mReplacementCreature) = False Then
		    Dict.Value("Replacement") = Self.mReplacementCreature.SaveData
		  Else
		    If Self.mDamageMultiplier <> 1.0 Then
		      Dict.Value("Damage Multiplier") = Self.mDamageMultiplier
		    End If
		    If Self.mResistanceMultiplier <> 1.0 Then
		      Dict.Value("Resistance Multiplier") = Self.mResistanceMultiplier
		    End If
		    If Self.mTamedDamageMultiplier <> 1.0 Then
		      Dict.Value("Tamed Damage Multiplier") = Self.mTamedDamageMultiplier
		    End If
		    If Self.mTamedResistanceMultiplier <> 1.0 Then
		      Dict.Value("Tamed Resistance Multiplier") = Self.mTamedResistanceMultiplier
		    End If
		    If Self.mWildSpeedMultiplier <> 1.0 Then
		      Dict.Value("Wild Speed Multiplier") = Self.mWildSpeedMultiplier
		    End If
		    If Self.mTamedSpeedMultiplier <> 1.0 Then
		      Dict.Value("Tamed Speed Multiplier") = Self.mTamedSpeedMultiplier
		    End If
		    If Self.mTamedStaminaMultiplier <> 1.0 Then
		      Dict.Value("Tamed Stamina Multiplier") = Self.mTamedStaminaMultiplier
		    End If
		  End If
		  If Self.mProhibitTaming Then
		    Dict.Value("Prevent Taming") = True
		  End If
		  If Self.mProhibitTransfer Then
		    Dict.Value("Prohibit Transfer") = True
		  End If
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function WildSpeedMultiplier() As Double
		  Return Self.mWildSpeedMultiplier
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mProhibitSpawning As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mProhibitTaming As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mProhibitTransfer As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mReplacementCreature As ArkSA.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mResistanceMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTamedDamageMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTamedResistanceMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTamedSpeedMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTamedStaminaMultiplier As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mTargetCreature As ArkSA.BlueprintReference
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mWildSpeedMultiplier As Double = 1.0
	#tag EndProperty


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
	#tag EndViewBehavior
End Class
#tag EndClass
