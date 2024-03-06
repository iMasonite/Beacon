#tag Class
Protected Class ConfigOption
Implements Beacon.GameSetting
	#tag Method, Flags = &h0
		Function AutoImported() As Boolean
		  Var AutoImported As Variant = Self.Constraint("auto_imported")
		  If AutoImported.IsNull Then
		    Return True
		  End If
		  Return AutoImported.BooleanValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ConfigOptionId() As String
		  Return Self.mConfigOptionId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Constraint(Key As String) As Variant
		  If Self.mConstraints Is Nil Or Self.mConstraints.HasKey(Key) = False Then
		    Return Nil
		  End If
		  
		  Return Self.mConstraints.Value(Key)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Source As Palworld.ConfigOption)
		  Self.mConfigOptionId = Source.mConfigOptionId
		  Self.mLabel = Source.mLabel
		  Self.mFile = Source.mFile
		  Self.mHeader = Source.mHeader
		  Self.mStruct = Source.mStruct
		  Self.mKey = Source.mKey
		  Self.mValueType = Source.mValueType
		  Self.mMaxAllowed = Source.mMaxAllowed
		  Self.mDescription = Source.mDescription
		  Self.mDefaultValue = Source.mDefaultValue
		  Self.mNitradoPaths = Source.NitradoPaths // Use this version to make a clone of the array
		  Self.mNitradoFormat = Source.mNitradoFormat
		  Self.mNitradoDeployStyle = Source.mNitradoDeployStyle
		  Self.mUIGroup = Source.mUIGroup
		  Self.mContentPackId = Source.mContentPackId
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(File As String, Header As String, Struct As NullableString, Key As String)
		  Self.mFile = File
		  Self.mHeader = Header
		  Self.mStruct = Struct
		  Self.mKey = Key
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ConfigOptionId As String, Label As String, File As String, Header As String, Struct As NullableString, Key As String, ValueType As Palworld.ConfigOption.ValueTypes, MaxAllowed As NullableDouble, Description As String, DefaultValue As Variant, NitradoPath As NullableString, NitradoFormat As Palworld.ConfigOption.NitradoFormats, NitradoDeployStyle As Palworld.ConfigOption.NitradoDeployStyles, NativeEditorVersion As NullableDouble, UIGroup As NullableString, CustomSort As NullableString, Constraints As Dictionary, ContentPackId As String)
		  Self.Constructor(File, Header, Struct, Key)
		  
		  Self.mConfigOptionId = ConfigOptionId
		  Self.mLabel = Label
		  Self.mValueType = ValueType
		  Self.mMaxAllowed = MaxAllowed
		  Self.mDescription = Description
		  Self.mDefaultValue = DefaultValue
		  Self.mNativeEditorVersion = NativeEditorVersion
		  Self.mUIGroup = UIGroup
		  Self.mContentPackId = ContentPackId
		  Self.mCustomSort = CustomSort
		  Self.mConstraints = Constraints
		  
		  If (NitradoPath Is Nil) = False Then
		    Self.mNitradoPaths = NitradoPath.Split(";")
		    Self.mNitradoFormat = NitradoFormat
		    Self.mNitradoDeployStyle = NitradoDeployStyle
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContentPackId() As String
		  Return Self.mContentPackId
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CustomSort() As NullableString
		  Return Self.mCustomSort
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultValue() As Variant
		  Return Self.mDefaultValue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Description() As String
		  Return Self.mDescription
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function File() As String
		  Return Self.mFile
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNativeEditor() As Boolean
		  Return (Self.mNativeEditorVersion Is Nil) = False And Self.mNativeEditorVersion.IntegerValue >= App.BuildNumber
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNitradoEquivalent() As Boolean
		  Return Self.mNitradoPaths.Count > 0 And Self.mNitradoFormat <> Palworld.ConfigOption.NitradoFormats.Unsupported
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Header() As String
		  Return Self.mHeader
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsArray() As Boolean
		  Return Self.mValueType = Palworld.ConfigOption.ValueTypes.TypeArray
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsBoolean() As Boolean
		  Return Self.mValueType = Palworld.ConfigOption.ValueTypes.TypeBoolean
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsNumeric() As Boolean
		  Return Self.mValueType = Palworld.ConfigOption.ValueTypes.TypeNumeric
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsString() As Boolean
		  Return Self.mValueType = Palworld.ConfigOption.ValueTypes.TypeText
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsStruct() As Boolean
		  Return Self.mValueType = Palworld.ConfigOption.ValueTypes.TypeStructure
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As String
		  Return Self.mKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Label() As String
		  Return Self.mLabel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MaxAllowed() As NullableDouble
		  Return Self.mMaxAllowed
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NativeEditorVersion() As NullableDouble
		  Return Self.mNativeEditorVersion
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoDeployStyle() As Palworld.ConfigOption.NitradoDeployStyles
		  Return Self.mNitradoDeployStyle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoFormat() As Palworld.ConfigOption.NitradoFormats
		  Return Self.mNitradoFormat
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NitradoPaths() As String()
		  Var Clone() As String
		  Clone.ResizeTo(Self.mNitradoPaths.LastIndex)
		  For Idx As Integer = 0 To Clone.LastIndex
		    Clone(Idx) = Self.mNitradoPaths(Idx)
		  Next
		  Return Clone
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(Other As Palworld.ConfigOption) As Integer
		  If Other Is Nil Then
		    Return 1
		  End If
		  
		  If Self.mConfigOptionId = Other.mConfigOptionId Then
		    Return 0
		  End If
		  
		  Var StringOne As String = Self.Signature
		  Var StringTwo As String = Other.Signature
		  Return StringOne.Compare(StringTwo, ComparisonOptions.CaseInsensitive, Locale.Raw)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SimplifiedKey() As String
		  // Returns the key without its attribute
		  
		  Return Palworld.ConfigValue.SimplifyKey(Self.mKey)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Struct() As NullableString
		  Return Self.mStruct
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UIGroup() As NullableString
		  Return Self.mUIGroup
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValuesEqual(FirstValue As Variant, SecondValue As Variant) As Boolean
		  Select Case Self.mValueType
		  Case ValueTypes.TypeNumeric
		    Var FirstDouble, SecondDouble As Double
		    Try
		      FirstDouble = FirstValue.DoubleValue
		    Catch Err As RuntimeException
		      Return False
		    End Try
		    Try
		      SecondDouble = SecondValue.DoubleValue
		    Catch Err As RuntimeException
		      Return False
		    End Try
		    Return FirstDouble = SecondDouble
		  Case ValueTypes.TypeBoolean
		    Return FirstValue.IsTruthy = SecondValue.IsTruthy
		  Else
		    Var FirstString As String = Beacon.VariantToString(FirstValue)
		    Var SecondString As String = Beacon.VariantToString(SecondValue)
		    Return FirstString.Compare(SecondString, ComparisonOptions.CaseSensitive, Locale.Raw) = 0
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ValueType() As Palworld.ConfigOption.ValueTypes
		  Return Self.mValueType
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mConfigOptionId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mConstraints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mContentPackId As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mCustomSort As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefaultValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDescription As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFile As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHeader As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mKey As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mLabel As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mMaxAllowed As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNativeEditorVersion As NullableDouble
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNitradoDeployStyle As Palworld.ConfigOption.NitradoDeployStyles
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNitradoFormat As Palworld.ConfigOption.NitradoFormats
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mNitradoPaths() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mStruct As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mUIGroup As NullableString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValueType As Palworld.ConfigOption.ValueTypes
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return Self.mFile + "." + Self.mHeader + "." + If(Self.mStruct Is Nil, "", Self.mStruct.StringValue + ".") + Self.mKey
			End Get
		#tag EndGetter
		Signature As String
	#tag EndComputedProperty


	#tag Enum, Name = NitradoDeployStyles, Type = Integer, Flags = &h0
		Unsupported
		  Guided
		  Expert
		Both
	#tag EndEnum

	#tag Enum, Name = NitradoFormats, Type = Integer, Flags = &h0
		Unsupported
		  Line
		Value
	#tag EndEnum

	#tag Enum, Name = ValueTypes, Type = Integer, Flags = &h0
		TypeNumeric
		  TypeArray
		  TypeStructure
		  TypeBoolean
		TypeText
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
			Name="Signature"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
