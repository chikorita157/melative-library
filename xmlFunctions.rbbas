#tag ModuleProtected Module xmlFunctions	#tag Method, Flags = &h0		Function getanything(root As xmlnode, xqlquery as string) As xmlnodelist		  dim yourlist As XmlNodeList		  		  yourlist = root.Xql(xqlquery)		  		  Return yourlist		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function getXMLroot(xml As xmldocument) As xmlnode		  dim root As new XmlNode		  		  root = xml.FirstChild		  		  Return root		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function parseAnime(animeseries As xmlnode) As dictionary		  dim d As new Dictionary		  dim i As Integer		  dim c As Integer		  		  c = animeseries .ChildCount - 1		  		  for i = 0 to c		    if not (animeseries.Child(i).FirstChild is nil) then		      d.Value(animeseries.Child(i).Name) = animeseries.Child(i).FirstChild.Value		    Else		      d.Value(animeseries.Child(i).Name) = ""		    end if		  next		  		  		  		  Return d		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function parseAnime1(animeseries As xmlnode) As dictionary		  dim d As new Dictionary		  dim i As Integer		  dim c As Integer		  		  c = animeseries .ChildCount - 1		  		  for i = 0 to c		    if not (animeseries.Child(i).FirstChild is nil) then		      d.Value(animeseries.Child(i).Name) = animeseries.Child(i).FirstChild.Value		    Else		      d.Value(animeseries.Child(i).Name) = ""		    end if		  next		  		  		  		  Return d		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function parseContext(animeseries As xmlnode) As dictionary		  dim d As new Dictionary		  dim i As Integer		  //dim c As Integer		  		  //c = animeseries .ChildCount - 1		  		  //for i = 0 to c		  for i = 0 to 3		    if not (animeseries.Child(i).FirstChild is nil) then		      //break		      if animeseries.child(i).name = "alias" then		        d.Value(animeseries.Child(3).Name) = animeseries.Child(3).FirstChild.Value		      else		        d.Value(animeseries.Child(i).Name) = animeseries.Child(i).FirstChild.Value		      end if		    Else		      d.Value(animeseries.Child(i).Name) = ""		    end if		  next		  		  		  		  Return d		End Function	#tag EndMethod	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule