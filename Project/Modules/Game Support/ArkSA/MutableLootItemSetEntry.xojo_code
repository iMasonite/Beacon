#tag Class
Protected Class MutableLootItemSetEntry
Inherits ArkSA.LootItemSetEntry
Implements ArkSA.Prunable,Beacon.BlueprintConsumer
	#tag Method, Flags = &h0
		Sub Add(Option As ArkSA.LootItemSetEntryOption)
		  Self.mOptions.Add(Option)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AdjustQualities(Assigns Value As Boolean)
		  If Self.mAdjustQualities = Value Then
		    Return
		  End If
		  
		  Self.mAdjustQualities = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChanceToBeBlueprint(Assigns Value As Double)
		  If Self.mChanceToBeBlueprint = Value Then
		    Return
		  End If
		  
		  Self.mChanceToBeBlueprint = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Super.Constructor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EntryId(Assigns Value As String)
		  If Self.mEntryId = Value Then
		    Return
		  End If
		  
		  Self.mEntryId = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ImmutableVersion() As ArkSA.LootItemSetEntry
		  Return New ArkSA.LootItemSetEntry(Self)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQuality(Assigns Value As ArkSA.Quality)
		  If Self.mMaxQuality = Value Then
		    Return
		  End If
		  
		  Self.mMaxQuality = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQualityOverride(Assigns Value As NullableDouble)
		  If Self.mMaxQualityOverride = Value Then
		    Return
		  End If
		  
		  Self.mMaxQualityOverride = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MaxQuantity(Assigns Value As Integer)
		  Value = Max(Value, 0)
		  If Self.mMaxQuantity = Value Then
		    Return
		  End If
		  
		  Self.mMaxQuantity = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MigrateBlueprints(Migrator As Beacon.BlueprintMigrator) As Boolean
		  // Part of the Beacon.BlueprintConsumer interface.
		  
		  Var Changed As Boolean
		  For Idx As Integer = 0 To Self.mOptions.LastIndex
		    Var NewEngramRef As ArkSA.BlueprintReference = ArkSA.FindMigratedBlueprint(Migrator, Self.mOptions(Idx).Reference)
		    If NewEngramRef Is Nil Or NewEngramRef.IsEngram = False Then
		      Continue
		    End If
		    
		    Self.mOptions(Idx) = New ArkSA.LootItemSetEntryOption(NewEngramRef, Self.mOptions(Idx).RawWeight, Self.mOptions(Idx).UUID)
		    Self.Modified = True
		    Changed = True
		  Next
		  Return Changed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQuality(Assigns Value As ArkSA.Quality)
		  If Self.mMinQuality = Value Then
		    Return
		  End If
		  
		  Self.mMinQuality = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQualityOverride(Assigns Value As NullableDouble)
		  If Self.mMinQualityOverride = Value Then
		    Return
		  End If
		  
		  Self.mMinQualityOverride = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MinQuantity(Assigns Value As Integer)
		  Value = Max(Value, 0)
		  If Self.mMinQuantity = Value Then
		    Return
		  End If
		  
		  Self.mMinQuantity = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MutableVersion() As ArkSA.MutableLootItemSetEntry
		  Return Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns Item As ArkSA.LootItemSetEntryOption)
		  Self.mOptions(Index) = Item
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PreventGrinding(Assigns Value As Boolean)
		  If Self.mPreventGrinding = Value Then
		    Return
		  End If
		  
		  Self.mPreventGrinding = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PruneUnknownContent(ContentPackIds As Beacon.StringList)
		  // Part of the ArkSA.Prunable interface.
		  
		  For Idx As Integer = Self.mOptions.LastIndex DownTo 0
		    Var Reference As ArkSA.BlueprintReference = Self.mOptions(Idx).Reference
		    Var Blueprint As ArkSA.Blueprint = Reference.Resolve(ContentPackIds, 0)
		    If Blueprint Is Nil Then
		      Self.mOptions.RemoveAt(Idx)
		      Self.Modified = True
		    End If
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawWeight(Assigns Value As Double)
		  Value = Max(Value, 0)
		  If Self.mWeight = Value Then
		    Return
		  End If
		  
		  Self.mWeight = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAt(Index As Integer)
		  Self.mOptions.RemoveAt(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ResizeTo(Bound As Integer)
		  Self.mOptions.ResizeTo(Bound)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SingleItemQuantity(Assigns Value As Boolean)
		  If Self.mSingleItemQuantity = Value Then
		    Return
		  End If
		  
		  Self.mSingleItemQuantity = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StatClampMultiplier(Assigns Value As Double)
		  If Self.mStatClampMultiplier = Value Then
		    Return
		  End If
		  
		  Self.mStatClampMultiplier = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UseCustomQualities(Assigns Value As Boolean)
		  If Self.mUseCustomQualities = Value Then
		    Return
		  End If
		  
		  Self.mUseCustomQualities = Value
		  Self.Modified = True
		End Sub
	#tag EndMethod


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
