#tag ClassProtected Class MacOSXMenu	#tag Method, Flags = &h0		Sub Append(Item As String)		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Function AppendMenuItemTextWithCFString Lib Carbon (inMenu As Integer, inString As CFStringRef, inAttributes As Integer, inCommandID as Integer, outNewItem As Ptr) As Integer		    		    dim err as integer		    		    err = AppendMenuItemTextWithCFString(me,item,0,OSTypeToUInt32(""),nil)		    if err <> 0 then		      Error err		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub AppendSeparator()		  me.append "-"		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Function CFStringToString(StringHandle As Integer) As String		  #if TargetCarbon		    if StringHandle = 0 then		      Return ""		    end if		    		    Declare Function CFStringGetLength Lib Carbon (theString as Integer) as Integer		    Declare Function CFStringGetMaximumSizeForEncoding Lib Carbon (length as Integer, enc as Integer) as Integer		    Declare Function CFStringGetCString Lib Carbon (theString as Integer, buffer as Ptr, bufferSize as Integer, enc as Integer) as Boolean		    		    Const kCFStringEncodingUTF8 = &h08000100		    		    dim charCount as Integer = CFStringGetLength(StringHandle)		    dim maxSize as Integer = CFStringGetMaximumSizeForEncoding(charCount, kCFStringEncodingUTF8)		    		    const sizeOfCStringTerminator = 1		    dim buffer as new MemoryBlock(sizeOfCStringTerminator + maxSize)		    If CFStringGetCString(StringHandle, buffer, buffer.Size, kCFStringEncodingUTF8) then		      Return Left(DefineEncoding(buffer.StringValue(0, maxSize), Encodings.UTF8), charCount)		    Else		      Return ""		    End if		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Checked(Index As Integer) As Boolean		  #if TargetCarbon		    if phandle = 0 then		      return false		    end		    		    Declare Sub GetItemMark Lib Carbon (theMenu As Integer, item As Short, ByRef markChar As Short)		    		    dim mark as short		    const kMenuCheckmarkGlyph = &h12		    		    GetItemMark(me,index,mark)		    		    return mark = kMenuCheckmarkGlyph		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Checked(Index As Integer, Assigns Value As Boolean)		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Sub CheckMenuItem Lib Carbon (theMenu As Integer, item As Short, checked As Boolean)		    		    CheckMenuItem me,index,value		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Clone() As MacOSXMenu		  #if TargetCarbon		    if phandle = 0 then		      return nil		    end		    		    Declare Function DuplicateMenu Lib Carbon (inSourceMenu As Integer, ByRef outMenu As Integer) As Integer		    		    dim newMenuHandle,err As Integer		    dim newMenu As MacOSXMenu		    		    err = DuplicateMenu(me,newMenuHandle)		    if err <> 0 then		      Error err		      return nil		    else		      newmenu = new macosxmenu(newMenuHandle)		      return newmenu		    end		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor()		  #if TargetCarbon		    if phandle <> 0 then		      return		    end		    		    Declare Function CreateNewMenu Lib Carbon (inMenuID As Short, inMenuAttributes As Integer, ByRef outMenuRef As Integer) As Integer		    Declare Function ReleaseMenu Lib Carbon (theMenu As Integer) As Integer		    		    dim err,newMenuHandle as integer		    		    try		      err = CreateNewMenu(37,0,newMenuHandle)		      if err <> 0 then		        Error err		      else		        me.constructor(newMenuHandle)		      end		    finally		      if newMenuHandle <> 0 then		        err = ReleaseMenu(newMenuHandle)		        if err <> 0 then		          Error err		        end		      end		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Constructor(FromHandle As Integer)		  #if TargetCarbon		    if fromhandle = 0 then		      return		    end		    		    Declare Function RetainMenu Lib Carbon (inMenu As Integer) As Integer		    		    dim err as integer		    		    err = RetainMenu(fromhandle)		    if err = 0 then		      phandle = fromhandle		      Open		    else		      Error err		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Count() As Integer		  #if TargetCarbon		    if phandle = 0 then		      return 0		    end		    		    Declare Function CountMenuItems Lib Carbon (theMenu As Integer) As Short		    		    return CountMenuItems(me)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Destructor()		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Function ReleaseMenu Lib Carbon (theMenu As Integer) As Integer		    		    dim err as integer		    		    err = ReleaseMenu(me)		    if err <> 0 then		      Error err		    else		      phandle = 0		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Enabled(Index As Integer) As Boolean		  #if TargetCarbon		    if phandle = 0 then		      return false		    end		    		    Declare Function GetMenuItemAttributes Lib Carbon (menu As Integer, item As Short, ByRef outAttributes As Integer) As Integer		    		    dim attributesbit as integer		    dim err as integer		    		    err = GetMenuItemAttributes(me,index,attributesbit)		    if err = 0 then		      return bitwise.bitand(attributesbit,kMenuItemAttrDisabled) <> kMenuItemAttrDisabled		    else		      Error err		      return false		    end		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Enabled(Index As Integer, Assigns Value As Boolean)		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Function ChangeMenuItemAttributes Lib Carbon (menu As Integer, item As Short, setTheseAttributes As Integer, clearTheseAttributes As Integer) As Integer		    		    dim err as integer		    		    if value then		      err = ChangeMenuItemAttributes(me,index,0,kMenuItemAttrDisabled)		    else		      err = ChangeMenuItemAttributes(me,index,kMenuItemAttrDisabled,0)		    end		    		    if err <> 0 then		      Error err		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Handle() As Integer		  return phandle		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Indent(Index As Integer) As Integer		  #if TargetCarbon		    if phandle = 0 then		      return 0		    end		    		    Declare Function GetMenuItemIndent Lib Carbon (inMenu As Integer, inItem As Short, ByRef outIndent As Integer) As Integer		    		    dim indentLevel,err as integer		    		    err = GetMenuItemIndent(me,index,indentlevel)		    if err <> 0 then		      Error err		      return 0		    else		      return indentlevel		    end		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Indent(Index As Integer, Assigns Value As Integer)		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Function SetMenuItemIndent Lib Carbon (inMenu As Integer, inItem As Short, inIndent As Integer) As Integer		    		    dim err as integer		    		    err = SetMenuItemIndent(me,index,value)		    if err <> 0 then		      Error err		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub Insert(BeforeIndex As Integer, Item As String)		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Function InsertMenuItemTextWithCFString Lib Carbon (inMenu As Integer, inString As CFStringRef, inAfterItem As Short, inAttributes As Integer, inCommandID As Integer) As Integer		    		    dim err as integer		    		    err = InsertMenuItemTextWithCFString(me,item,beforeindex - 1,0,0)		    if err <> 0 then		      Error err		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub InsertSeparator(BeforeIndex As Integer)		  me.insert beforeindex,"-"		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Operator_Convert() As Integer		  return phandle		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Remove(Index As Integer)		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Sub DeleteMenuItem Lib Carbon (theMenu As Integer, item As Short)		    		    DeleteMenuItem me,index		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemTextBold(Index As Integer)		  #if TargetCarbon		    me.setstyle index,kTextBold		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemTextCondense(Index As Integer)		  #if TargetCarbon		    me.setstyle index,kTextCondense		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemTextExtend(Index As Integer)		  #if TargetCarbon		    me.setstyle index,kTextExtend		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemTextItalic(Index As Integer)		  #if TargetCarbon		    me.setstyle index,kTextItalic		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemTextNormal(Index As Integer)		  #if TargetCarbon		    me.setstyle index,kTextNormal		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemTextOutline(Index As Integer)		  #if TargetCarbon		    me.setstyle index,kTextOutline		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemTextShadow(Index As Integer)		  #if TargetCarbon		    me.setstyle index,kTextShadow		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SetItemTextUnderline(Index As Integer)		  #if TargetCarbon		    me.setstyle index,kTextUnderline		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Sub SetStyle(Index As Integer, Style As Integer)		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Sub SetItemStyle Lib Carbon (theMenu As Integer, item As Short, chStyle As Integer)		    		    SetItemStyle(me,Index,Style)		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function Show(X As Integer, Y As Integer) As Integer		  #if TargetCarbon		    if phandle = 0 then		      return 0		    end		    		    Declare Function PopUpMenuSelect Lib Carbon (menu As Integer, top As Short, left As Short, popupItem As Short) As Integer		    Declare Sub LocalToGlobal Lib Carbon (pt as Ptr)		    		    dim p as memoryblock		    dim sel as integer		    		    p = new memoryblock(4)		    p.short(0) = x		    p.short(2) = y		    LocalToGlobal(p)		    		    sel = PopUpMenuSelect(me,p.short(0),p.short(2),1)		    if sel <> 0 then		      return sel mod 65536		    end		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Submenu(Index As Integer) As MacOSXMenu		  #if TargetCarbon		    if phandle = 0 then		      return nil		    end		    		    Declare Function GetMenuItemHierarchicalMenu Lib Carbon (inMenu As Integer, inItem As Short, ByRef outHierMenu As Integer) As Integer		    		    dim menuHandle,err as integer		    		    err = GetMenuItemHierarchicalMenu(me,index,menuHandle)		    if err <> 0 then		      Error err		      return nil		    elseif menuHandle = 0 then		      return nil		    else		      return new MacOSXMenu(menuHandle)		    end		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Submenu(Index As Integer, Assigns Value As MacOSXMenu)		  #if TargetCarbon		    if value <> nil then		      if value.handle = 0 or phandle = 0 then		        return		      end		    end		    		    Declare Function SetMenuItemHierarchicalMenu Lib Carbon (inMenu As Integer, inItem As Short, inHierMenu As Integer) As Integer		    Declare Sub SetMenuID Lib Carbon (menu As Integer, menuID As Short)		    		    dim err as integer		    err = SetMenuItemHierarchicalMenu(me,index,value.handle)		    		    if err <> 0 then		      Error err		      return		    else		      me.lastmenuid = me.lastmenuid + 1		      SetMenuID me,me.lastmenuid		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Function TestStyle(Index As Integer, Style As Integer) As Boolean		  #if TargetCarbon		    if phandle = 0 then		      return false		    end		    		    Declare Sub GetItemStyle Lib Carbon (theMenu As Integer, item As Short, chStyle As Ptr)		    		    dim m as memoryblock		    m = new memoryblock(2)		    		    GetItemStyle me,index,m		    return bitwise.bitand(m.short(0),style) = style		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function Text(Index As Integer) As String		  #if TargetCarbon		    if phandle = 0 then		      return ""		    end		    		    Declare Function CopyMenuItemTextAsCFString Lib Carbon (inMenu As Integer, inItem As Short, ByRef outString As Integer) As Integer		    Declare Sub CFRelease Lib Carbon (cf As Integer)		    		    dim cfs,err as integer		    dim s as string		    		    err = CopyMenuItemTextAsCFString(me,index,cfs)		    if err <> 0 then		      Error err		      return ""		    elseif cfs = 0 then		      return ""		    else		      s = CFStringToString(cfs)		      CFRelease cfs		      return s		    end		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Sub Text(Index As Integer, Assigns Value As String)		  #if TargetCarbon		    if phandle = 0 then		      return		    end		    		    Declare Function SetMenuItemTextWithCFString Lib Carbon (inMenu As Integer, inItem As Short, inString As CFStringRef) As Integer		    		    dim err as integer		    		    err = SetMenuItemTextWithCFString(me,index,value)		    if err <> 0 then		      Error err		    end		  #endif		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function TextBold(Index As Integer) As Boolean		  #if TargetCarbon		    return me.TestStyle(index,kTextBold)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TextCondense(Index As Integer) As Boolean		  #if TargetCarbon		    return me.TestStyle(index,kTextCondense)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TextExtend(Index As Integer) As Boolean		  #if TargetCarbon		    return me.TestStyle(index,kTextExtend)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TextItalic(Index As Integer) As Boolean		  #if TargetCarbon		    return me.TestStyle(index,kTextItalic)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TextNormal(Index As Integer) As Boolean		  #if TargetCarbon		    return me.TestStyle(index,kTextNormal)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TextOutline(Index As Integer) As Boolean		  #if TargetCarbon		    return me.TestStyle(index,kTextOutline)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TextShadow(Index As Integer) As Boolean		  #if TargetCarbon		    return me.TestStyle(index,kTextShadow)		  #endif		End Function	#tag EndMethod	#tag Method, Flags = &h0		Function TextUnderline(Index As Integer) As Boolean		  #if TargetCarbon		    return me.TestStyle(index,kTextUnderline)		  #endif		End Function	#tag EndMethod	#tag Hook, Flags = &h0		Event Error(ErrorNum As Integer)	#tag EndHook	#tag Hook, Flags = &h0		Event Open()	#tag EndHook	#tag Property, Flags = &h21		Private LastMenuID As Integer	#tag EndProperty	#tag Property, Flags = &h21		Private pHandle As Integer	#tag EndProperty	#tag ComputedProperty, Flags = &h0		TextFont As String	#tag EndComputedProperty	#tag ComputedProperty, Flags = &h0		TextSize As Integer	#tag EndComputedProperty	#tag Constant, Name = Carbon, Type = String, Dynamic = False, Default = \"CarbonLib", Scope = Private		#Tag Instance, Platform = Mac Mach-O, Language = Default, Definition  = \"Carbon"	#tag EndConstant	#tag Constant, Name = kMenuItemAttrDisabled, Type = Double, Dynamic = False, Default = \"1", Scope = Private	#tag EndConstant	#tag Constant, Name = kTextBold, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Public	#tag EndConstant	#tag Constant, Name = kTextCondense, Type = Double, Dynamic = False, Default = \"&h0032", Scope = Public	#tag EndConstant	#tag Constant, Name = kTextExtend, Type = Double, Dynamic = False, Default = \"&h0064", Scope = Public	#tag EndConstant	#tag Constant, Name = kTextItalic, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Public	#tag EndConstant	#tag Constant, Name = kTextNormal, Type = Double, Dynamic = False, Default = \"&h0000", Scope = Public	#tag EndConstant	#tag Constant, Name = kTextOutline, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Public	#tag EndConstant	#tag Constant, Name = kTextShadow, Type = Double, Dynamic = False, Default = \"&h0016", Scope = Public	#tag EndConstant	#tag Constant, Name = kTextUnderline, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Public	#tag EndConstant	#tag ViewBehavior		#tag ViewProperty			Name="Index"			Visible=true			Group="ID"			InitialValue="-2147483648"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Left"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Name"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="Super"			Visible=true			Group="ID"			InheritedFrom="Object"		#tag EndViewProperty		#tag ViewProperty			Name="TextFont"			Group="Behavior"			Type="String"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="TextSize"			Group="Behavior"			InitialValue="0"			Type="Integer"		#tag EndViewProperty		#tag ViewProperty			Name="Top"			Visible=true			Group="Position"			InitialValue="0"			InheritedFrom="Object"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass