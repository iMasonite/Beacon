#tag Class
Private Class ConfigParser
	#tag Method, Flags = &h0
		Function AddCharacter(Char As String) As Boolean
		  Static LineEndingChar As String = Palworld.ImportThread.LineEndingChar
		  
		  Self.ConsumedLastChar = True
		  
		  If Self.SubParser <> Nil Then
		    If Self.SubParser.AddCharacter(Char) Then
		      // This parser is done
		      
		      Select Case Self.Type
		      Case Self.TypePair
		        Self.mValue = New Beacon.KeyValuePair(Self.Key, Self.SubParser.Value)
		        Self.ConsumedLastChar = Self.SubParser.ConsumedLastChar
		        Self.SubParser = Nil
		        Return True
		      Case Self.TypeArray
		        Var Values() As Variant = Self.mValue
		        Values.Add(Self.SubParser.Value)
		        Self.mValue = Values
		        Var Consumed As Boolean = Self.SubParser.ConsumedLastChar
		        Self.SubParser = Nil
		        
		        If Consumed Then
		          Return False
		        End If
		      End Select
		    Else
		      Return False
		    End If
		  End If
		  
		  If InQuotes Then
		    Var LastChar As String
		    If Self.Buffer.LastIndex > -1 Then
		      LastChar = Self.Buffer(Self.Buffer.LastIndex)
		    End If
		    
		    If Char = """" Then
		      If LastChar = "\" Then
		        Self.Buffer(Self.Buffer.LastIndex) = Char
		      Else
		        InQuotes = False
		      End If
		    ElseIf Char = "n" And LastChar = "\" Then
		      Self.Buffer(Self.Buffer.LastIndex) = EndOfLine
		    Else
		      Self.Buffer.Add(Char)
		    End If
		    Return False
		  End If
		  
		  Select Case Self.Type
		  Case Self.TypeIntrinsic
		    Select Case Char
		    Case "("
		      If Self.Buffer.LastIndex = -1 Then
		        Self.SubParser = New Palworld.ConfigParser(Self.Level + 1)
		        Self.Type = Self.TypeArray
		        
		        Var Values() As Variant
		        Self.mValue = Values
		      Else
		        Self.Buffer.Add(Char)
		      End If
		    Case "="
		      If Not Self.KeyFound Then
		        Self.Key = Self.Buffer.Join("").Trim
		        Self.Buffer.ResizeTo(-1)
		        Self.Type = Self.TypePair
		        Self.SubParser = New Palworld.ConfigParser(Self.Level) // Same level
		        // We want the subparser to know the key was found too. The ( will start a new
		        // parser whose KeyFound will be false
		        Self.SubParser.KeyFound = True
		        Self.KeyFound = True
		      Else
		        Self.Buffer.Add(Char)
		      End If
		    Case ")", ",", LineEndingChar
		      If Self.Level = 0 And Char <> LineEndingChar Then
		        Self.Buffer.Add(Char)
		      Else
		        Self.ConsumedLastChar = False
		        Self.mValue = Self.Buffer.Join("")
		        Self.Buffer.ResizeTo(-1)
		        Self.KeyFound = False
		        Return True
		      End If
		    Case """"
		      Self.InQuotes = True
		    Else
		      Self.Buffer.Add(Char)
		    End Select
		  Case Self.TypeArray
		    Select Case Char
		    Case ")", LineEndingChar
		      Return True
		    Case ","
		      Self.SubParser = New Palworld.ConfigParser(Self.Level + 1)
		    End Select
		  End Select
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Level As Integer = 0)
		  Self.Type = Self.TypeIntrinsic
		  Self.Level = Level
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  Return Self.mValue
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Buffer() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ConsumedLastChar As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private InQuotes As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Key As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private KeyFound As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Level As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValue As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SubParser As Palworld.ConfigParser
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Type As Integer
	#tag EndProperty


	#tag Constant, Name = TypeArray, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TypeIntrinsic, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TypePair, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
