#tag WindowBegin Window Import   BackColor       =   &hFFFFFF   Backdrop        =   ""   CloseButton     =   False   Composite       =   True   Frame           =   8   FullScreen      =   False   HasBackColor    =   False   Height          =   1.48e+2   ImplicitInstance=   True   LiveResize      =   False   MacProcID       =   0   MaxHeight       =   32000   MaximizeButton  =   False   MaxWidth        =   32000   MenuBar         =   ""   MenuBarVisible  =   True   MinHeight       =   64   MinimizeButton  =   False   MinWidth        =   64   Placement       =   0   Resizeable      =   False   Title           =   "Melative Import"   Visible         =   True   Width           =   4.55e+2   Begin StaticText StaticText1      AutoDeactivate  =   True      Bold            =   True      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   26      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Multiline       =   ""      Scope           =   0      TabIndex        =   1      TabPanelIndex   =   0      Text            =   "Warning: Importing data can overwrite your current status!"      TextAlign       =   0      TextColor       =   &h000000      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   9      Underline       =   ""      Visible         =   True      Width           =   419   End   Begin PopupMenu PopupMenu1      AutoDeactivate  =   True      Bold            =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      InitialValue    =   "MyAnimeList - Anime\rMyAnimeList - Manga"      Italic          =   ""      Left            =   144      ListIndex       =   0      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Scope           =   0      TabIndex        =   2      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   41      Underline       =   ""      Visible         =   True      Width           =   182   End   Begin StaticText StaticText2      AutoDeactivate  =   True      Bold            =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   28      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Multiline       =   ""      Scope           =   0      TabIndex        =   3      TabPanelIndex   =   0      Text            =   "Import from:"      TextAlign       =   0      TextColor       =   &h000000      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   41      Underline       =   ""      Visible         =   True      Width           =   121   End   Begin StaticText StaticText3      AutoDeactivate  =   True      Bold            =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   29      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Multiline       =   ""      Scope           =   0      TabIndex        =   4      TabPanelIndex   =   0      Text            =   "Username:"      TextAlign       =   0      TextColor       =   &h000000      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   75      Underline       =   ""      Visible         =   True      Width           =   100   End   Begin TextField Username      AcceptTabs      =   ""      Alignment       =   0      AutoDeactivate  =   True      BackColor       =   &hFFFFFF      Bold            =   ""      Border          =   True      CueText         =   ""      DataField       =   ""      DataSource      =   ""      Enabled         =   True      Format          =   ""      Height          =   22      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   144      LimitText       =   0      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Mask            =   ""      Password        =   ""      ReadOnly        =   ""      Scope           =   0      TabIndex        =   5      TabPanelIndex   =   0      TabStop         =   True      Text            =   ""      TextColor       =   &h000000      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   75      Underline       =   ""      UseFocusRing    =   True      Visible         =   True      Width           =   182   End   Begin PushButton PushButton1      AutoDeactivate  =   True      Bold            =   ""      Cancel          =   ""      Caption         =   "Import"      Default         =   True      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   355      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Scope           =   0      TabIndex        =   6      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   114      Underline       =   ""      Visible         =   True      Width           =   80   End   Begin PushButton PushButton2      AutoDeactivate  =   True      Bold            =   ""      Cancel          =   True      Caption         =   "Cancel"      Default         =   ""      Enabled         =   True      Height          =   20      HelpTag         =   ""      Index           =   -2147483648      InitialParent   =   ""      Italic          =   ""      Left            =   263      LockBottom      =   ""      LockedInPosition=   False      LockLeft        =   ""      LockRight       =   ""      LockTop         =   ""      Scope           =   0      TabIndex        =   7      TabPanelIndex   =   0      TabStop         =   True      TextFont        =   "System"      TextSize        =   0      TextUnit        =   0      Top             =   114      Underline       =   ""      Visible         =   True      Width           =   80   EndEnd#tag EndWindow#tag WindowCode	#tag Property, Flags = &h0		Success As boolean = false	#tag EndProperty#tag EndWindowCode#tag Events PushButton1	#tag Event		Sub Action()		  If Username.text = "" then		    beep		  else		    Dim d as New MessageDialog //declare the MessageDialog object		    Dim b as MessageDialogButton //for handling the result		    d.icon=MessageDialog.GraphicCaution //display warning icon		    d.ActionButton.Caption="Import"		    d.CancelButton.Default = true // don't make Delete the default button.		    d.CancelButton.Visible=True    //show the Cancel button		    d.Message="Are you sure you want to import " + username.text+ "'s " + PopupMenu1.text + " to your Melative Library?"		    d.Explanation="Once done, this action cannot be undone. Also, it can overwrite your current title status in your library."		    b=d.ShowModal //display the dialog		    Select Case b //determine which button was pressed.		    Case d.ActionButton		      Success = true		      hide		    Case d.CancelButton		      //user pressed Cancel		    End select		  end if		End Sub	#tag EndEvent#tag EndEvents#tag Events PushButton2	#tag Event		Sub Action()		  hide		End Sub	#tag EndEvent#tag EndEvents