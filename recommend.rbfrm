#tag WindowBegin Window recommend   BackColor       =   &hFFFFFF   Backdrop        =   ""   CloseButton     =   False   Composite       =   True   Frame           =   8   FullScreen      =   False   HasBackColor    =   False   Height          =   1.41e+2   ImplicitInstance=   True   LiveResize      =   False   MacProcID       =   0   MaxHeight       =   32000   MaximizeButton  =   False   MaxWidth        =   32000   MenuBar         =   ""   MenuBarVisible  =   True   MinHeight       =   64   MinimizeButton  =   False   MinWidth        =   64   Placement       =   0   Resizeable      =   False   Title           =   "Untitled"   Visible         =   True   Width           =   4.18e+2   Begin StaticText recommendlbl      AutoDeactivate  =   True      Bold            =   True      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   13      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Multiline       =   ""      Scope           =   0      TabIndex        =   0      TabPanelIndex   =   0      Text            =   "Recommend:"      TextAlign       =   0      TextColor       =   &h000000      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   8      Underline       =   ""      Visible         =   True      Width           =   392   End   Begin StaticText StaticText2      AutoDeactivate  =   True      Bold            =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   13      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Multiline       =   ""      Scope           =   0      TabIndex        =   1      TabPanelIndex   =   0      Text            =   "Reason:"      TextAlign       =   2      TextColor       =   &h000000      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   34      Underline       =   ""      Visible         =   True      Width           =   79   End   Begin TextArea reason      AcceptTabs      =   ""      Alignment       =   0      AutoDeactivate  =   True      BackColor       =   &hFFFFFF      Bold            =   ""      Border          =   True      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Format          =   ""      Height          =   68      HelpTag         =   ""      HideSelection   =   True      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   98      LimitText       =   0      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Mask            =   ""      Multiline       =   True      ReadOnly        =   ""      Scope           =   0      ScrollbarHorizontal=   ""      ScrollbarVertical=   True      Styled          =   True      TabIndex        =   2      TabPanelIndex   =   0      TabStop         =   True      Text            =   ""      TextColor       =   &h000000      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   34      Underline       =   ""      UseFocusRing    =   True      Visible         =   True      Width           =   276   End   Begin PushButton PushButton1      AutoDeactivate  =   True      Bold            =   ""      Cancel          =   ""      Caption         =   "OK"      Default         =   True      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   334      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Scope           =   0      TabIndex        =   3      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   111      Underline       =   ""      Visible         =   True      Width           =   64   End   Begin PushButton PushButton2      AutoDeactivate  =   True      Bold            =   ""      Cancel          =   True      Caption         =   "Cancel"      Default         =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   240      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Scope           =   0      TabIndex        =   4      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   112      Underline       =   ""      Visible         =   True      Width           =   80   End   Begin ProgressWheel ProgressWheel1      AutoDeactivate  =   True      Enabled         =   True      Height          =   16      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Left            =   13      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Scope           =   0      TabIndex        =   5      TabPanelIndex   =   0      TabStop         =   True      Top             =   113      Visible         =   False      Width           =   16   EndEnd#tag EndWindow#tag WindowCode	#tag Property, Flags = &h0		titleprob As string	#tag EndProperty#tag EndWindowCode#tag Events PushButton1	#tag Event		Sub Action()		  progresswheel1.visible = true		  If reason.text = "" then		    errboxshowdialog("Melative Library was unable to post your recommendation for this title since you didn't specify a reason. ", "Please specify a reason and try submitting it again.")		    progresswheel1.visible = false		  else		    dim form2 as new dictionary		    dim socket1 as new httpsocket		    dim data as string		    //post recommendation		    form2.value("message") = "/recommend /"+ window1.mediatype + "/"  + titleprob + "/ : " +reason.text		    // Set Client ( e.g. <username> in anime <time> ago from MAL Client OS X)		    form2.value("source") = "Melative Library"		    // setup the socket to POST the form		    socket1.setFormData form2		    socket1.setrequestheader "Authorization","Basic " + app.loginenc		    data = socket1.post("http://melative.com/api/micro/update.json",10)		    If socket1.httpstatuscode = 200  then		      hide		    else		      // Show Error		      errboxshowdialog("Melative Library was unable to post your recommendation for this title. ", "Check your internet connection and try posting it again again.")		      progresswheel1.visible = false		    end if		  end if		End Sub	#tag EndEvent#tag EndEvents#tag Events PushButton2	#tag Event		Sub Action()		  hide		End Sub	#tag EndEvent#tag EndEvents