#tag Class
Protected Class CraftingCost
	#tag Method, Flags = &h0
		Sub Append(Resource As Beacon.Engram, Quantity As Integer, RequireExact As Boolean)
		  If Resource = Nil Then
		    Return
		  End If
		  
		  If Self.IndexOf(Resource) > -1 Then
		    Return
		  End If
		  
		  Self.mResources.Append(Resource)
		  Self.mQuantities.Append(Quantity)
		  Self.mRequireExacts.Append(RequireExact)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.mObjectID = Beacon.CreateUUID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Beacon.CraftingCost)
		  Self.Constructor()
		  Self.Engram = Source.Engram
		  For I As Integer = 0 To Source.Ubound
		    Self.Append(Source.Resource(I), Source.Quantity(I), Source.RequireExactResource(I))
		  Next
		  Self.Modified = Source.Modified
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Engram As Beacon.Engram)
		  Self.Constructor()
		  Self.Engram = Engram
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Export() As Xojo.Core.Dictionary
		  Dim Dict As New Xojo.Core.Dictionary
		  
		  If Self.mEngram <> Nil Then
		    Dict.Value("Engram") = Self.mEngram.ClassString
		  End If
		  
		  Dim Resources() As Xojo.Core.Dictionary
		  For I As Integer = 0 To Self.mResources.Ubound
		    Dim Engram As Beacon.Engram = Self.mResources(I)
		    Dim Quantity As Integer = Self.mQuantities(I)
		    Dim RequireExact As Boolean = Self.mRequireExacts(I)
		    
		    Dim Resource As New Xojo.Core.Dictionary
		    Resource.Value("Class") = Engram.ClassString
		    Resource.Value("Quantity") = Quantity
		    Resource.Value("Exact") = RequireExact
		    
		    Resources.Append(Resource)
		  Next
		  Dict.Value("Resources") = Resources
		  
		  Return Dict
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromBeacon(Dict As Xojo.Core.Dictionary) As Beacon.CraftingCost
		  Dim Cost As New Beacon.CraftingCost
		  
		  If Dict.HasKey("Engram") Then
		    Dim ClassString As Text = Dict.Value("Engram")
		    Dim Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Engram = Beacon.Engram.CreateUnknownEngram(ClassString)
		    End If
		    Cost.mEngram = Engram
		  End If
		  
		  If Dict.HasKey("Resources") Then
		    Dim Resources() As Auto = Dict.Value("Resources")
		    For Each Resource As Xojo.Core.Dictionary In Resources
		      Dim ClassString As Text = Resource.Lookup("Class", "")
		      Dim Quantity As Integer = Resource.Lookup("Quantity", 1)
		      Dim RequireExact As Boolean = Resource.Lookup("Exact", False)
		      Dim Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(ClassString)
		      If Engram = Nil Then
		        Engram = Beacon.Engram.CreateUnknownEngram(ClassString)
		      End If
		      Cost.mQuantities.Append(Quantity)
		      Cost.mRequireExacts.Append(RequireExact)
		      Cost.mResources.Append(Engram)
		    Next
		  End If
		  
		  Return Cost
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function ImportFromConfig(Dict As Xojo.Core.Dictionary) As Beacon.CraftingCost
		  Try
		    Dim ClassString As Text = Dict.Lookup("ItemClassString", "")
		    If ClassString = "" Then
		      Return Nil
		    End If
		    
		    Dim Engram As Beacon.Engram = Beacon.Data.GetEngramByClass(ClassString)
		    If Engram = Nil Then
		      Engram = Beacon.Engram.CreateUnknownEngram(ClassString)
		    End If
		    
		    Dim Cost As New Beacon.CraftingCost(Engram)
		    If Dict.HasKey("BaseCraftingResourceRequirements") Then
		      Dim Resources() As Auto = Dict.Value("BaseCraftingResourceRequirements")
		      For Each Resource As Xojo.Core.Dictionary In Resources
		        Dim ResourceClass As Text = Resource.Lookup("ResourceItemTypeString", "")
		        If ResourceClass = "" Then
		          Continue
		        End If
		        Dim ResourceEngram As Beacon.Engram = Beacon.Data.GetEngramByClass(ResourceClass)
		        If ResourceEngram = Nil Then
		          ResourceEngram = Beacon.Engram.CreateUnknownEngram(ResourceClass)
		        End If
		        Dim Quantity As Integer = Resource.Lookup("BaseResourceRequirement", 1)
		        Dim RequireExact As Boolean = Resource.Lookup("bCraftingRequireExactResourceType", False)
		        Cost.Append(ResourceEngram, Quantity, RequireExact)
		      Next
		    End If
		    
		    Return Cost
		  Catch Err As RuntimeException
		    Return Nil
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Resource As Beacon.Engram) As Integer
		  For I As Integer = 0 To Self.mResources.Ubound
		    If Self.mResources(I) = Resource Then
		      Return I
		    End If
		  Next
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Resource As Beacon.Engram, Quantity As Integer, RequireExact As Boolean)
		  If Resource = Nil Then
		    Return
		  End If
		  
		  If Self.IndexOf(Resource) > -1 Then
		    Return
		  End If
		  
		  Self.mResources.Insert(Index, Resource)
		  Self.mQuantities.Insert(Index, Quantity)
		  Self.mRequireExacts.Insert(Index,RequireExact)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsValid() As Boolean
		  Return Self.mEngram <> Nil And Self.Ubound > -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As Text
		  If Self.mEngram = Nil Then
		    Return ""
		  End If
		  
		  Return Self.mEngram.Label
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Modified() As Boolean
		  If Self.mLastModifiedTime > Self.mLastSaveTime Then
		    Return True
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Modified(Assigns Value As Boolean)
		  If Value = False Then
		    Self.mLastSaveTime = Microseconds
		  Else
		    Self.mLastModifiedTime = Microseconds
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ObjectID() As Text
		  Return Self.mObjectID
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Beacon.CraftingCost) As Integer
		  If Other = Nil Then
		    Return 1
		  End If
		  
		  If Self.mObjectID = Other.mObjectID Then
		    Return 0
		  End If
		  
		  // Try to sort by name first, otherwise sort by object id for lack of a better option
		  Dim SelfName As Text = If(Self.mEngram <> Nil, Self.mEngram.Label, "")
		  Dim OtherName As Text = If(Other.mEngram <> Nil, Other.mEngram.Label, "")
		  Dim Result As Integer = SelfName.Compare(OtherName)
		  If Result = 0 Then
		    Result = Self.mObjectID.Compare(Other.mObjectID)
		  End If
		  Return Result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Quantity(Index As Integer) As Integer
		  Return Self.mQuantities(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Quantity(Index As Integer, Assigns Value As Integer)
		  Value = Min(Max(Value, 1), 65535)
		  
		  If Self.mQuantities(Index) <> Value Then
		    Self.mQuantities(Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Resource As Beacon.Engram)
		  Dim Idx As Integer = Self.IndexOf(Resource)
		  If Idx > -1 Then
		    Self.Remove(Idx)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  Self.mQuantities.Remove(Index)
		  Self.mRequireExacts.Remove(Index)
		  Self.mResources.Remove(Index)
		  Self.Modified = True
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RequireExactResource(Index As Integer) As Boolean
		  Return Self.mRequireExacts(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RequireExactResource(Index As Integer, Assigns Value As Boolean)
		  If Self.mRequireExacts(Index) <> Value Then
		    Self.mRequireExacts(Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Resource(Index As Integer) As Beacon.Engram
		  Return Self.mResources(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Resource(Index As Integer, Assigns Value As Beacon.Engram)
		  If Self.mResources(Index) <> Value Then
		    Self.mResources(Index) = Value
		    Self.Modified = True
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextValue() As Text
		  Dim Components() As Text
		  For I As Integer = 0 To Self.mResources.Ubound
		    Dim ClassString As Text = Self.mResources(I).ClassString
		    Dim QuantityString As Text = Self.mQuantities(I).ToText(Xojo.Core.Locale.Raw, "0")
		    Dim RequireExactString As Text = If(Self.mRequireExacts(I), "true", "false")
		    Components.Append("(ResourceItemTypeString=""" + ClassString + """,BaseResourceRequirement=" + QuantityString + ",bCraftingRequireExactResourceType=" + RequireExactString + ")")
		  Next
		  
		  Dim Pieces() As Text
		  Pieces.Append("ItemClassString=""" + If(Self.mEngram <> Nil, Self.mEngram.ClassString, "") + """")
		  Pieces.Append("BaseCraftingResourceRequirements=(" + Components.Join(",") + ")")
		  Return "(" + Pieces.Join(",") + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Ubound() As Integer
		  Return Self.mResources.Ubound
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mEngram
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If Self.mEngram = Value Then
			    Return
			  End If
			  
			  Self.mEngram = Value
			  Self.Modified = True
			End Set
		#tag EndSetter
		Engram As Beacon.Engram
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mEngram As Beacon.Engram
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastModifiedTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLastSaveTime As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mObjectID As Text
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mQuantities() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mRequireExacts() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mResources() As Beacon.Engram
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
