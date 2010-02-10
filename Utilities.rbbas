#tag ModuleProtected Module Utilities	#tag Method, Flags = &h0		Sub errboxshow(extends w as window, errtitle as string, errmsg as string)		  Dim b as MessageDialogButton //for handling the result		  Dim d as New MessageDialog //declare the MessageDialog object		  d.icon=MessageDialog.GraphicCaution //display warning icon		  d.ActionButton.Caption="OK"		  d.Message=errtitle		  d.Explanation=errmsg		  b=d.ShowModalWithin(w.TrueWindow)		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub errboxshowdialog(errtitle as string, errmsg as string)		  Dim b as MessageDialogButton //for handling the result		  Dim d as New MessageDialog //declare the MessageDialog object		  d.icon=MessageDialog.GraphicCaution //display warning icon		  d.ActionButton.Caption="OK"		  d.Message=errtitle		  d.Explanation=errmsg		  b=d.ShowModal		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function getPictFromURL(theURL as string) As picture		  // GetPictFromURL is an Image download method. Which obtains a picture given a URL.		  // handles a single level redirects to .com sites.		  // returns a picture or nil		  dim theStr, redirectURL as string		  dim gotFile as Boolean		  dim p as picture		  dim prefix as string		  dim nPos as integer		  Dim tempFile As FolderItem		  Dim theSocket as HTTPSocket = new HTTPSocket		  thesocket.yield = true		  tempFile = new folderitem		  tempfile = specialfolder.temporary.child("temp.jpg")		  if tempFile <> nil then		    		    //load url targetfile using httpsocket in synchronous mode		    gotFile = theSocket.get(theURL, tempFile, 10)		    if theSocket.HTTPStatusCode = 301 then		      redirectURL = theSocket.PageHeaders.Value("Location")		      //see if redirectURL needs prefix		      if instr(redirectURL, "http:") = 0 then		        nPos = instr(theURL, ".com")		        prefix = left(theURL, nPos) + "com"		        redirectURL = prefix + redirectURL		      end		      gotFile = theSocket.get(redirectURL,tempFile, 60)		    end if		    		    if gotFile then		      p = tempfile.OpenAsPicture		      return p		    end		  end		  		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function GetThemeColor(Brush As Integer) As Color		  #if TargetMacOS		    if not system.isfunctionavailable("HIThemeBrushCreateCGColor","Carbon") then		      return &c000000		    end		    		    Soft Declare Function HIThemeBrushCreateCGColor Lib "Carbon" (inBrush As Integer, ByRef outColor As Integer) As Integer		    Soft Declare Function CGColorGetNumberOfComponents Lib "Carbon" (color As Integer) As Integer		    Soft Declare Function CGColorGetComponents Lib "Carbon" (color As Integer) As Ptr		    Soft Declare Sub CGColorRelease Lib "Carbon" (color As Integer)		    		    static lastBrush as integer		    static lastColor as color		    		    if brush = lastbrush then		      return lastcolor		    end		    		    dim colorRef as integer		    dim err as integer = HIThemeBrushCreateCGColor(brush,colorRef)		    		    dim num as integer = CGColorGetNumberOfComponents(colorRef)		    dim p as ptr = CGColorGetComponents(colorRef)		    		    		    dim components() as integer		    dim lastOffset as Integer = 4 * (num - 1)		    dim offset as integer		    for offset = 0 to lastOffset step 4		      components.Append(255 * p.Single(offset))		    next		    if num = 2 then		      // the first value repeats twice more, second is the alpha		      components.insert(1,components(0))		      components.insert(2,components(0))		    end		    while ubound(components) < 2		      components.append(255)		    wend		    		    CGColorRelease(colorRef)		    		    dim c as color = rgb(components(0),components(1),components(2))		    		    lastcolor = c		    lastbrush = brush		    		    Return c		  #else		    return &c000000		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub listboxsort(extends l as listbox, sc as integer)		  //Sort list		  l.ColumnsortDirection(sc)=ListBox.sortascending		  l.SortedColumn=sc //sort by name		  l.Sort		End Sub	#tag EndMethod	#tag Note, Name = Usage		Utilities Module 1.0		Works only on Mac OS X. Part of MAL Client OS X and covered under GPL V3				Errboxshow		This shows a sheet message dialog on a window. 		Usage:		Self.errboxshow("Message Line 1","Message Line 2")				GetThemeColor		Gives the ListBoxes a Mac OS X feel.				Errboxshowdialog		Shows a warning modal message dialog				listboxsort		Sorts Listbox 		listbox(extends l as listbox, sc as integer)		sc is what columb you want to sort	#tag EndNote	#tag Constant, Name = kThemeBrushListViewEvenRowBackground, Type = Double, Dynamic = False, Default = \"57", Scope = Public	#tag EndConstant	#tag Constant, Name = kThemeBrushListViewOddRowBackground, Type = Double, Dynamic = False, Default = \"56", Scope = Public	#tag EndConstant	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Module#tag EndModule