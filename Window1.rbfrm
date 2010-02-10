#tag WindowBegin Window Window1   BackColor       =   &hFFFFFF   Backdrop        =   ""   CloseButton     =   True   Composite       =   True   Frame           =   0   FullScreen      =   False   HasBackColor    =   False   Height          =   498   ImplicitInstance=   True   LiveResize      =   True   MacProcID       =   0   MaxHeight       =   32000   MaximizeButton  =   False   MaxWidth        =   32000   MenuBar         =   866092770   MenuBarVisible  =   True   MinHeight       =   498   MinimizeButton  =   True   MinWidth        =   657   Placement       =   0   Resizeable      =   True   Title           =   "Melative Library"   Visible         =   True   Width           =   657   Begin Listbox yourlist      AutoDeactivate  =   True      AutoHideScrollbars=   True      Bold            =   ""      Border          =   True      ColumnCount     =   1      ColumnsResizable=   ""      ColumnWidths    =   ""      DataField       =   ""      DataSource      =   ""      DefaultRowHeight=   -1      Enabled         =   True      EnableDrag      =   ""      EnableDragReorder=   ""      GridLinesHorizontal=   0      GridLinesVertical=   0      HasHeading      =   ""      HeadingIndex    =   -1      Height          =   471      HelpTag         =   ""      Hierarchical    =   True      Index           =   -2147483648      InitialParent   =   ""      InitialValue    =   ""      Italic          =   False      Left            =   0      LockBottom      =   True      LockedInPosition=   False      LockLeft        =   True      LockRight       =   True      LockTop         =   True      RequiresSelection=   ""      Scope           =   0      ScrollbarHorizontal=   ""      ScrollBarVertical=   True      SelectionType   =   0      TabIndex        =   0      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "System"      TextSize        =   11      TextUnit        =   0      Top             =   0      Underline       =   ""      UseFocusRing    =   False      Visible         =   True      Width           =   657      _ScrollWidth    =   -1   End   Begin ProgressWheel ProgressWheel1      AutoDeactivate  =   True      Enabled         =   True      Height          =   16      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Left            =   619      LockBottom      =   True      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   True      LockTop         =   ""      Scope           =   0      TabIndex        =   1      TabPanelIndex   =   0      TabStop         =   True      Top             =   476      Visible         =   False      Width           =   16   End   Begin maintoolbar maintoolbar      Enabled         =   True      Height          =   77      Index           =   -2147483648      InitialParent   =   ""      Left            =   233      LockedInPosition=   False      Scope           =   0      TabPanelIndex   =   0      Top             =   -85      Visible         =   True      Width           =   374   End   Begin MacOSXSearchField MacOSXSearchField1      Active          =   0      Enabled         =   True      HasSearchIcon   =   0      Height          =   32      Index           =   -2147483648      InitialParent   =   ""      Left            =   -54      LiveSearch      =   True      LockedInPosition=   False      Scope           =   0      TabPanelIndex   =   0      Top             =   4      Visible         =   True      Width           =   32   End   Begin PopupMenu statemenu      AutoDeactivate  =   True      Bold            =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   "Filter by Status"      Index           =   -2147483648      InitialParent   =   ""      InitialValue    =   "current\rcomplete\rplanned\rstarted\rpaused\rresumed\rhold\rwishlisted\rmarathon\rbacklog\rdropped\rsubscribed\runknown\r-\rView All"      Italic          =   ""      Left            =   153      ListIndex       =   0      LockBottom      =   True      LockedInPosition=   False      LockLeft        =   True      LockRight       =   ""      LockTop         =   False      Scope           =   0      TabIndex        =   2      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "System"      TextSize        =   11      TextUnit        =   0      Top             =   476      Underline       =   ""      Visible         =   True      Width           =   102   EndEnd#tag EndWindow#tag WindowCode	#tag Event		Sub Close()		  savewindowposition		  savewindowsize		  app.prefs.root.SetString("statefilter",cstr(statemenu.listindex))		  quit		End Sub	#tag EndEvent	#tag Event		Sub Open()		  // Set Media Type		  mediatype = app.prefs.root.GetString("mediatype","anime")		  		  // Set Up Interface		  me.HasToolbarButton = false		  self.windowset		  loadwindowposition		  loadwindowsize		  me.Title = "Melative Library - Logged in as: " + app.MemUsername + " - " + mediatype		  		  //set up yourlist listbox		  yourlist.columncount=5		  yourlist.columnwidths="0,50%,12%,22%,16%"		  yourlist.HasHeading=True		  yourlist.Heading(0)="ID"		  yourlist.Heading(1)="Title"		  yourlist.Heading(2)="State"		  yourlist.Heading(3)="Last Used"		  yourlist.Heading(4)="Progress"		  yourlist.Column(0).UserResizable=false		  		  // Load Searchfield		  if macosxsearchfield1.create(self) then		    macosxsearchfield1.visible = true		    macosxsearchfield1.placeholder = "Filter by Title"		    macosxsearchfield1.hassearchicon = true		    macosxsearchfield1.left = 4		    macosxsearchfield1.top = 473		    macosxsearchfield1.width = 144		    macosxsearchfield1.height = 16		  end		  		  //load the list		  loadlist(true)		  		  // Set State filtering:		  me.statemenu.listindex = val(app.prefs.root.GetString("statefilter","0"))		End Sub	#tag EndEvent	#tag Event		Sub Resizing()		  MacOSXSearchField1.top = (self.height - (MacOSXSearchField1.height+9))		End Sub	#tag EndEvent	#tag MenuHandler		Function FileClose() As Boolean Handles FileClose.Action			me.close			Return True					End Function	#tag EndMenuHandler	#tag Method, Flags = &h0		Sub getinfo()		  If infowindow = false then		    informationwindow.show		    infowindow = true		  end if		  informationwindow.seriestitle.text = yourlist.cell(yourlist.listindex,1)		  informationwindow.loadmelativexml		  informationwindow.mediatype = mediatype		  informationwindow.BevelButton2.enabled = true		  informationwindow.BevelButton1.enabled = true		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub listsearch(searchterm as string)		  Dim rg as New RegEx		  Dim myMatch as RegExMatch		  dim t as new dictionary		  yourlist.DeleteAllRows		  yourlist.visible = false		  dim i as integer		  for i = 0 to l.Count -1		    if l.value(l.key(i)) isa dictionary then		      t = l.value(l.key(i))		      try		        rg.SearchPattern=searchterm		        myMatch=rg.search(t.Value("alias"))		        if myMatch <> Nil then		          If t.value("state") = statemenu.text or statemenu.text = "View All" then		            Yourlist.AddRow(l.key(i))		            Yourlist.Cell(Yourlist.LastIndex, 1) = t.value("alias")		            Yourlist.Cell(Yourlist.LastIndex, 2) = t.Value("state")		            Yourlist.Cell(Yourlist.LastIndex, 3) = t.Value("last")		            If t.haskey("type") = true and t.haskey("segname") then		              Yourlist.Cell(Yourlist.LastIndex, 4) = t.value("type") + " " + t.value("segname")		            elseif t.haskey("segname") = true then		              Yourlist.Cell(Yourlist.LastIndex, 4) = t.value("segname")		            end if		            If t.haskey("favorite") = true then		              If t.value("favorite") = 1 then		                yourlist.CellBold(Yourlist.LastIndex, 1) = true		              end if		            end if		          end if		        else		        End if		      catch		      end try		    else		    end if		  next		  yourlist.listboxsort(1)		  yourlist.visible = true		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub loadlist(silent as boolean)		  dim socket1 as new httpsocket		  dim listdata as string		  ProgressWheel1.visible = true		  socket1.yield = true		  socket1.setrequestheader "Authorization","Basic " + app.loginenc		  listdata= socket1.get("http://melative.com/api/library.xml?media=" + mediatype + "&alpha=1" ,10)		  // debugyourlist.text = data		  If socket1.httpstatuscode = 200 then		    //Populate data to the list		    // clear list		    dim XML as new XMLDocument		    dim d as new dictionary // store item information		    dim d2 as new dictionary // context information		    dim d3 as new dictionary // progress		    dim p as new xmlnodelist // store item information		    dim p2 as new xmlnodelist // context information		    dim p3 as new xmlnodelist // progress		    dim c , i, pcount as integer		    dim r as xmlnode		    xml.LoadXML(listdata)		    r = getXMLroot(xml)		    p = getanything(r, "//experience/item") // load item information		    p2=getanything(r, "//experience/item/context") // load context information		    p3 = getanything(r, "//experience/item/progress") //load progress information		    c = p.Length - 1		    dim t as dictionary		    l = new dictionary		    for i = 0 to c		      t = new dictionary		      d = parseAnime(p.Item(i))		      d2 = parsecontext(p2.Item(i))		      t.value("alias") = d2.value("alias")		      t.value("state") = d.value("state")		      t.value("last") = d.value("last")		      If d.haskey("favorite") = true then		        t.value("favorite") = d.value("favorite")		      end if		      if d.HasKey("progress")= true then		        d3 = parseAnime(p3.item(pcount))		        pcount = pcount + 1		        If d3.haskey("type") = true then		          t.value("type") = d3.value("type")		          t.value("segname") = d3.value("name")		        else		          t.value("segname") = d3.value("name")		        end if		      end if		      l.value(d2.value("id")) = t		    next		    yourlist.visible = false		    reloadlist		    yourlist.visible = true		    ProgressWheel1.visible = false		  else		    if silent = false then		      self.errboxshow("There is a problem while retreving your list",   "Unable to refresh your Library. Make sure you are connected to the internet!")		    end if		    ProgressWheel1.visible = false		  end if		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub LoadWindowPosition()		  dim l as integer		  dim t as integer		  l =val(app.prefs.root.GetString("left"))		  t= val(app.prefs.root.GetString("top"))		  		  if l = 0 then		  else		    self.left = l		  end if		  if t = 0 then		  else		    self.top = t		  end if		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub LoadWindowSize()		  dim winwidth as integer		  dim winheight as integer		  winwidth=val(app.prefs.root.GetString("WindowWidth",cstr(me.MinWidth)))		  winheight= val(app.prefs.root.GetString("WindowHeight", cstr(me.MinHeight)))		  If me.minwidth = winwidth then		  else		    me.width = winwidth		  end if		  if me.minwidth = winheight then		  else		    me.height = winheight		  end if		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub reloadcell(mediatitle as string, favoritestatus as boolean)		  dim socket1 as new httpsocket		  dim data as string		  socket1.yield = true		  socket1.setrequestheader "Authorization","Basic " + app.loginenc		  data= socket1.get("http://melative.com/api/entity/meta.xml?" + mediatype + "=" +  EncodeURLComponent(mediatitle) , 30)		  If socket1.httpstatuscode = 200 then		    dim segtype as string		    If Window1.mediatype = "Anime" then		      segtype = "episode"		    elseif Window1.mediatype = "manga" or Window1.mediatype = "lightnovel" then		      segtype = "chapter"		    elseif Window1.mediatype = "vn" then		    end if		    dim XML as new XMLDocument		    dim d as new dictionary		    dim p as new xmlnodelist		    dim r as xmlnode		    xml.LoadXML(data)		    r = getXMLroot(xml)		    p = getanything(r, "//response/context/library") // load Library information		    d = parseAnime(p.Item(0))		    // Update the cells		    yourlist.cell(yourlist.listindex,2) = d.value("state")		    yourlist.cell(yourlist.listindex,3) = d.value("last")		    // Also the dictionary		    dim t as new dictionary		    t = l.value(yourlist.cell(yourlist.listindex,0))		    t.value("state") = d.value("state")		    t.value("last")  = d.value("last")		    If d.hasKey("Segment")  = true then		      yourlist.cell(yourlist.listindex,4) = Replace(d.value("segment"), "|", " ")		      t.value("segname") = Replace(d.value("segment"), segtype + "|", " ")		    end if		    If favoritestatus = true then		      t.value("favorite") = "1"		    elseif favoritestatus = false then		      t.value("favorite") = "0"		    end if		    If t.haskey("favorite") = true then		      If t.value("favorite") = 1 then		        yourlist.CellBold(yourlist.listindex, 1) = true		      else		        yourlist.CellBold(yourlist.listindex, 1) = false		      end if		    end if		    // store updated info		    l.value(yourlist.cell(yourlist.listindex,0)) = t		  End If		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub reloadlist()		  yourlist.DeleteAllRows		  dim t as new dictionary		  dim i as integer		  for i = 0 to l.Count -1		    if l.value(l.key(i)) isa dictionary then		      t = l.value(l.key(i))		      If t.value("state") = statemenu.text or statemenu.text = "View All" then		        Yourlist.AddRow(l.key(i))		        Yourlist.Cell(Yourlist.LastIndex, 1) = t.value("alias")		        Yourlist.Cell(Yourlist.LastIndex, 2) = t.Value("state")		        Yourlist.Cell(Yourlist.LastIndex, 3) = t.Value("last")		        If t.haskey("type") = true and t.haskey("segname") then		          Yourlist.Cell(Yourlist.LastIndex, 4) = t.value("type") + " " + t.value("segname")		        elseif t.haskey("segname") = true then		          Yourlist.Cell(Yourlist.LastIndex, 4) = t.value("segname")		        end if		        If t.haskey("favorite") = true then		          If t.value("favorite") = 1 then		            yourlist.CellBold(Yourlist.LastIndex, 1) = true		          end if		        end if		      end if		    end if		  next		  yourlist.listboxsort(1)		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub RemoveTitle()		  dim socket1 as new httpsocket		  dim t as new dictionary		  t = l.value(yourlist.cell(yourlist.listindex,0))		  Dim d as New MessageDialog //declare the MessageDialog object		  Dim b as MessageDialogButton //for handling the result		  d.icon=MessageDialog.GraphicCaution //display warning icon		  d.ActionButton.Caption="Delete"		  d.CancelButton.Default = true // don't make Delete the default button.		  d.CancelButton.Visible=True    //show the Cancel button		  d.Message="Are you sure you want to delete " + t.value("alias") + " from your list?"		  d.Explanation="Once deleted, this operation cannot be undone."		  b=d.ShowModalWithin(self) //display the dialog		  Select Case b //determine which button was pressed.		  Case d.ActionButton		    //user pressed Delete		    //perform delete		    dim form as dictionary		    form = New Dictionary		    form.value(mediatype) = t.value("alias")		    // setup the socket to POST the form		    socket1.setFormData form		    socket1.setrequestheader "Authorization","Basic " + app.loginenc		    Dim data as string		    data = socket1.post ("http://melative.com/api/library/remove.json",10)		    form = nil		    If socket1.httpstatuscode = 200 then		      Msgbox t.value("alias") + " is removed from your list."		      me.l.remove(yourlist.cell(yourlist.listindex,0))		      me.reloadlist		    else		      errboxshowdialog("There was a problem when we were trying to remove a title.", "Check your internet connection and try removing that title again.")		    end if		  Case d.CancelButton		    //user pressed Cancel		  End select		  		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub SaveWindowPosition()		  app.prefs.root.SetString("top",cstr(self.top))		  app.prefs.root.SetString("left", cstr(self.left))		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Sub savewindowsize()		  app.prefs.root.SetString("windowwidth",cstr(self.width))		  app.prefs.root.SetString("windowheight", cstr(self.height))		End Sub	#tag EndMethod	#tag Property, Flags = &h0		infowindow As boolean	#tag EndProperty	#tag Property, Flags = &h0		l As dictionary	#tag EndProperty	#tag Property, Flags = &h0		mediatype As string = "anime"	#tag EndProperty#tag EndWindowCode#tag Events yourlist	#tag Event		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean		  #If TargetMacOS		    if row mod 2 = 0 then		      g.forecolor = GetThemeColor(kThemeBrushListViewOddRowBackground)		    else		      g.forecolor = GetThemeColor(kThemeBrushListViewEvenRowBackground)		    end		    g.fillrect(0,0,g.width,g.height)		  #endif		End Function	#tag EndEvent	#tag Event		Sub Change()		  If yourlist.listindex = -1 then		    maintoolbar.usebut.enabled = false		    maintoolbar.UpdateBut.enabled = false		    maintoolbar.InfoBut.enabled = false		    maintoolbar.RemoveBut.enabled = false		  else		    maintoolbar.usebut.enabled = true		    maintoolbar.UpdateBut.enabled = true		    maintoolbar.InfoBut.enabled = true		    maintoolbar.RemoveBut.enabled = true		  End If		End Sub	#tag EndEvent	#tag Event		Sub DoubleClick()		  getinfo		End Sub	#tag EndEvent	#tag Event		Function KeyDown(Key As String) As Boolean		  if key = chr(13) then		    getinfo		  end if		End Function	#tag EndEvent#tag EndEvents#tag Events maintoolbar	#tag Event		Sub Action(item As ToolItem)		  Select Case item.name		  Case "UpdateBut"		    dim w as new updatewin		    dim t as new dictionary		    t = l.value(yourlist.cell(yourlist.listindex,0))		    w.titleprob = t.value("alias")		    w.StaticText1.text = w.StaticText1.text + " " + w.titleprob		    w.combobox1.text = t.value("state")		    If t.haskey("segname") then		      w.epiwatched.text = t.value("segname")		    end if		    If t.haskey("favorite") then		      If t.value("favorite") = "1" then		        w.favorite.value = true		      else		        w.favorite.value = false		      end if		    end if		    w.showmodalwithin(self)		    If w.updated = true then		      w.close		    end if		  Case "RemoveBut"		    RemoveTitle		  Case "UseBut"		    ShowUseDialog( yourlist.cell(yourlist.listindex,1),mediatype)		  Case "InfoBut"		    Getinfo		  Case "Refreshbut"		    loadlist(false)		  Case "SwitchList"		    dim w as new ListSwitch		    If mediatype = "anime" then		      w.popupmenu1.listindex = 0		    elseif mediatype = "manga" then		      w.popupmenu1.listindex = 1		    elseif mediatype = "lightnovel" then		      w.popupmenu1.listindex = 2		    elseif mediatype = "vn" then		      w.popupmenu1.listindex = 3		    elseif mediatype = "adrama" then		      w.popupmenu1.listindex = 4		    end if		    w.showmodalwithin(self)		    If w.success = true then		      If w.popupmenu1.text = "visualnovel" then		        mediatype = "vn"		      else		        mediatype = w.popupmenu1.text		      end if		      app.prefs.root.SetString("mediatype",mediatype)		      self.Title = "Melative Library - Logged in as: " + app.MemUsername + " - " + mediatype		      loadlist(true)		      app.prefs.save		    end if		    w.close		  Case "Timeline"		    Timeline.show		  end select		End Sub	#tag EndEvent#tag EndEvents#tag Events MacOSXSearchField1	#tag Event		Sub Search(SearchString As String)		  If searchstring = "" then		    reloadlist		  else		    listsearch(searchstring)		  end if		End Sub	#tag EndEvent	#tag Event		Sub SearchCleared()		  reloadlist		End Sub	#tag EndEvent#tag EndEvents#tag Events statemenu	#tag Event		Sub Change()		  reloadlist		End Sub	#tag EndEvent#tag EndEvents