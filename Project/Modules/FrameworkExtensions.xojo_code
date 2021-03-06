#tag Module
Protected Module FrameworkExtensions
	#tag Method, Flags = &h0
		Function ActualStringHeight(Extends G As Graphics, Source As String, WrapWidth As Double) As Double
		  // G.StringHeight is not always correct. It should be G.TextHeight * LineCount,
		  // but it seems to be missing a pixel per line in most cases. This code will work
		  // around the issue, and will remain correct even if the bug is fixed.
		  
		  Dim ExpectedLineHeight As Double = G.TextHeight
		  Dim ActualLineHeight As Double = G.StringHeight("A", 100)
		  Dim LineHeightDelta As Double = ExpectedLineHeight - ActualLineHeight
		  
		  Dim Height As Double = G.StringHeight(Source, WrapWidth)
		  Dim LineCount As Double = Height / ActualLineHeight
		  Return Height + (LineCount * LineHeightDelta)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AddSuffix(Extends Title As Text, Suffix As Text) As Text
		  Dim Words() As Text = Title.Split(" ")
		  If Words.Ubound >= 0 And Words(Words.Ubound) = Suffix Then
		    Words.Append("2")
		  ElseIf Words.Ubound >= 1 And Words(Words.Ubound - 1) = Suffix Then
		    Dim CopyNum As Integer
		    #Pragma BreakOnExceptions Off
		    Try
		      CopyNum = Integer.FromText(Words(Words.Ubound), Xojo.Core.Locale.Raw) + 1
		      Words(Words.Ubound) = CopyNum.ToText(Xojo.Core.Locale.Raw, "0")
		    Catch Err As RuntimeException
		      Words.Append(Suffix)
		    End Try
		    #Pragma BreakOnExceptions Default
		  Else
		    Words.Append(Suffix)
		  End If
		  Return Words.Join(" ")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function AutoToDouble(Value As Auto, ResolveWithFirst As Boolean = False) As Double
		  Dim Info As Xojo.Introspection.TypeInfo = Xojo.Introspection.GetType(Value)
		  Select Case Info.FullName
		  Case "Text"
		    Dim TextValue As Text = Value
		    If TextValue = "" Then
		      Return 0
		    Else
		      Return Double.FromText(TextValue)
		    End If
		  Case "Double"
		    Dim DoubleValue As Double = Value
		    Return DoubleValue
		  Case "Single"
		    Dim SingleValue As Single = Value
		    Return SingleValue
		  Case "Int8", "Int16", "Int32", "Int64"
		    Dim IntegerValue As Int64 = Value
		    Return IntegerValue
		  Case "UInt8", "UInt16", "UInt32", "UInt64"
		    Dim UIntegerValue As UInt64 = Value
		    Return UIntegerValue
		  Case "Auto()"
		    Dim Arr() As Auto = Value
		    Dim Possibles() As Double
		    For Each Possible As Auto In Arr
		      Dim Decoded As Double = AutoToDouble(Possible, ResolveWithFirst)
		      Possibles.Append(Decoded)
		    Next
		    If Possibles.Ubound = -1 Then
		      Return 0
		    End If
		    If ResolveWithFirst Then
		      Return Possibles(0)
		    Else
		      Return Possibles(Possibles.Ubound)
		    End If
		  Else
		    Break
		  End Select
		  
		  Exception Err As TypeMismatchException
		    Return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function BeginsWith(Extends Source As String, Other As String) As Boolean
		  Return Left(Source, Len(Other)) = Other
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Characters(Extends Source As String) As String()
		  Return Split(Source, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DoubleValue(Extends Dict As Xojo.Core.Dictionary, Key As Auto, ResolveWithFirst As Boolean = False) As Double
		  Dim Value As Auto = Dict.Value(Key)
		  Return AutoToDouble(Value, ResolveWithFirst)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndsWith(Extends Source As String, Other As String) As Boolean
		  Return Right(Source, Len(Other)) = Other
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Explanation(Extends Err As RuntimeException) As Text
		  If Err.Reason <> "" Then
		    Return Err.Reason
		  ElseIf Err.Message <> "" Then
		    Return Err.Message.ToText
		  Else
		    Return ""
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(Extends Source As String, StartAt As Integer = 0, Other As String) As Integer
		  Return InStr(StartAt, Source, Other) - 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Join(Extends Source() As String, Delimiter As String) As String
		  Return Join(Source, Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Join(Extends Source() As Text, Delimiter As Text) As Text
		  #if TargetWin32
		    // Thanks to bug <feedback://showreport?report_id=54183>
		    Dim Arr() As String
		    Redim Arr(Source.Ubound)
		    For I As Integer = 0 To Source.Ubound
		      Arr(I) = Source(I)
		    Next
		    Return Arr.Join(Delimiter).ToText
		  #endif
		  
		  Return Text.Join(Source, Delimiter)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length(Extends Source As String) As Integer
		  Return Len(Source)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Localize(Extends Rect As Xojo.Core.Rect, Point As Xojo.Core.Point) As Xojo.Core.Point
		  Return New Xojo.Core.Point(Point.X - Rect.Origin.X, Point.Y - Rect.Origin.Y)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Localize(Extends Rect As Xojo.Core.Rect, OtherRect As Xojo.Core.Rect) As Xojo.Core.Rect
		  Return New Xojo.Core.Rect(Rect.Localize(OtherRect.Origin), OtherRect.Size)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubString(Extends Source As String, Start As Integer, Length As Integer = -1) As String
		  If Length = -1 Then
		    Return Mid(Source, Start - 1)
		  Else
		    Return Mid(Source, Start - 1, Length)
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToHex(Extends Source As Color) As Text
		  Return Source.Red.ToHex(2).Lowercase + Source.Green.ToHex(2).Lowercase + Source.Blue.ToHex(2).Lowercase + Source.Alpha.ToHex(2).Lowercase
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
