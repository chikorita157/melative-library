#tag ModuleProtected Module MacOSXSearchFieldModule	#tag Method, Flags = &h1		Protected Sub Debug_CountSubviews(forView As Integer)		  #if DebugBuild		    Declare Function HIViewCountSubviews Lib Carbon (inView As Integer) As Integer		    Declare Function HIViewGetBounds Lib Carbon (inView As Integer, ByRef outRect As HIRect) As Integer		    Declare Function HIViewGetIndexedSubview Lib Carbon (inView As Integer, inSubviewIndex As Integer, ByRef outSubview As Integer) As Integer		    		    dim i,c,subViewsCount,subView,err as integer		    dim bounds as HIRect		    c = HIViewCountSubviews(forView)		    for i = 1 to c		      subviewscount = HIViewGetIndexedSubview(forView,i,subView)		      err = HIViewGetBounds(subView,bounds)		      msgbox "Child View #" + str(i) + " (" + str(subview) + ") of " + str(forview) + ": Left " + str(bounds.left) + ", Top " + str(bounds.top) + ", Width " + str(bounds.width) + ", Height " + str(bounds.height) + ". With " + str(subviewscount) + " Subviews."		      if subviewscount <> 0 then		        Debug_CountSubviews(subview)		      end		    next		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h1		Protected Function GetContentViewForWindow(InWindow As Window) As Integer		  #if TargetCarbon		    Declare Function HIViewGetRoot Lib Carbon (inWindow As WindowPtr) As Integer		    Declare Function HIViewFindByID Lib Carbon (inStartView As Integer, inID As ControlID, ByRef outControl As Integer) As Integer		    		    dim rootView,contentView,err as integer		    dim type as controlid		    		    type.signature = SmartReverse("wind")		    type.id = 1		    		    rootView = HIViewGetRoot(InWindow)		    err = HIViewFindByID(rootView,type,contentView)		    if err <> 0 then		      return 0		    else		      return contentView		    end		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function OSTypeToUInt32(x as OSType) As UInt32		  dim char() as String = SplitB(x, "")		  return ((AscB(char(0))*256 + AscB(char(1)))*256 + AscB(char(2)))*256 + AscB(char(3))		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Function Reverse(aString As String) As String		  Dim i, L As Integer		  Dim outString As String		  		  outString = ""		  L = Len(aString)		  For i = L DownTo 1		    outString = outString + Mid(aString, i, 1)		  Next i		  		  Return outString		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function SmartReverse(Extends aString As String) As String		  return smartreverse(aString)		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function SmartReverse(aString As String) As String		  #If TargetLittleEndian then		    Return Reverse(aString)		  #else		    Return aString		  #endif		End Function	#tag EndMethod	#tag Constant, Name = Carbon, Type = String, Dynamic = False, Default = \"CarbonLib", Scope = Private		#Tag Instance, Platform = Mac Mach-O, Language = Default, Definition  = \"Carbon"	#tag EndConstant	#tag Structure, Name = ControlID, Flags = &h0		signature as string * 4		id as integer	#tag EndStructure	#tag Structure, Name = HIPoint, Flags = &h0		x as integer		y as integer	#tag EndStructure	#tag Structure, Name = HIRect, Flags = &h0		left as single		  top as single		  width as single		height as single	#tag EndStructure	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule