#tag ClassProtected Class AppInherits Application	#tag Event		Sub Close()		  // Checks if RememberPassword is check and erases password if not.		  'If  app.prefs.root.GetBoolean("RememberPassword",false) = false then		  'app.prefs.root.SetString("Password","")		  'else		  ' //Encode and Store Password		  'app.prefs.root.SetString("Password",encodebase64(mempassword))		  'end if		  // Save Preferences		  app.prefs.Save		End Sub	#tag EndEvent	#tag Event		Sub Open()		  //You can pass a FolderItem for Sparkle.framework, or you can pass nil.  In this case, Sparkle will look for Sparkle.framework		  //in the Frameworks subdirectory of the app bundle, in ~/Library/Frameworks, and in /Library/Frameworks.		  		  dim SparkleFrameworkLocation as FolderItem = nil		  Sparkle.Initialize SparkleFrameworkLocation		  Sparkle.FoundVersionHandler = AddressOf HandleSparkleFoundVersion		  Sparkle.CancelQuitHandler = AddressOf HandleSparkleCancelQuit		  		  //Create Plist File		  dim f As FolderItem		  f=SpecialFolder.Preferences.child("com.chikorita157sanimeblog.melativelibrary.plist")		  prefs=new plist(f)		  		  //setting this will prevent problems with unhandled NSExceptions		  Sparkle.UserDefault("SUFeedURL") = "http://chikorita157.notcliche.com/malclientosx/melappcast.xml"		  		  // Check Login		  If app.prefs.root.GetBoolean("AutoLogin",false) = true then		    //Start auto login		    dim statuscode as integer		    memusername = app.prefs.root.GetString("Username")		    If checkkeychain = true then		      //mempassword = DecodeBase64(app.prefs.root.GetString("Password"))		      mempassword = loadpassword		      statuscode = app.login(memusername,mempassword, false)		      If statuscode  = 200 then		        Window1.show		      Elseif statuscode = 401 then		        errboxshowdialog("Melative Library was unable to log you in since you don't have the correct Username and/or Password.","Check your username and password and try logging in again. If you recently changed your password, enter your new password and try logging in.")		        loginenc = ""		        Window2.show		      else		        errboxshowdialog("Melative Library was unable to log you in since it cannot connect to the server. ", "Check your internet connection and try logging in again.")		        loginenc = ""		        Window2.show		      end if		    else		      errboxshowdialog("Melative Library was unable to log you in since no keychain exists or the keychain is locked.", "Please reenter your password and try again. If your keychain is locked, unlock it and try again.")		      loginenc = ""		      Window2.show		    end if		  else		    Window2.show		  end if		End Sub	#tag EndEvent	#tag Event		Function UnhandledException(error As RuntimeException) As Boolean		  dim f as new errorreporting(error)		  f.ShowModal		  return true		End Function	#tag EndEvent	#tag MenuHandler		Function EditPreferences() As Boolean Handles EditPreferences.Action			winprefs.show			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function FileAboutMelativeLibrary() As Boolean Handles FileAboutMelativeLibrary.Action						Carbon.ShowAboutBox "Melative Library",  "Version " + app.shortVersion, "", "Copyright © 2010 " + "James M." + EndOfLine +  "All rights reserved."			return true					End Function	#tag EndMenuHandler	#tag MenuHandler		Function FileAddNewTitle() As Boolean Handles FileAddNewTitle.Action			addnewtitle("", Window1.mediatype)		End Function	#tag EndMenuHandler	#tag MenuHandler		Function FileCheckforUpdates() As Boolean Handles FileCheckforUpdates.Action			Sparkle.CheckForUpdates true			Sparkle.CheckStatus			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function FileRefreshLibrary() As Boolean Handles FileRefreshLibrary.Action			window1.loadlist(false)			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function HelpMelativeLibraryHelp() As Boolean Handles HelpMelativeLibraryHelp.Action			showurl "http://chikorita157.notcliche.com/melativelibrary/help/"			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function HelpMelativeLibraryWebsite() As Boolean Handles HelpMelativeLibraryWebsite.Action			showurl "http://chikorita157.notcliche.com/melativelibrary"			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function ToolsImportList() As Boolean Handles ToolsImportList.Action			dim importw as new import			importw.showmodalwithin(Window1.truewindow)			If importw.success = true then			Dim progressw as new ImportProgressWindow			progressw.ImportUsername = Importw.Username.text			If Importw.PopupMenu1.text = "MyAnimeList - Anime" then			Progressw.importanimelist			elseif Importw.PopupMenu1.text = "MyAnimeList - Manga" then			progressw.importmangalist			end if			progressw.show			end if			importw.close			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function ToolsMediaMicrobloggingWindow() As Boolean Handles ToolsMediaMicrobloggingWindow.Action			dim mu as new melupdatewindow			mu.truewindow.Title = "Post Melative Update - " + ""			mu.checkbox1.value = true			If app.prefs.root.GetString("mediatype","anime") = "anime" then			mu.PopupMenu1.ListIndex =0			mu.segmentlbl.text = "Episode:"			mu.segmenttitle = "Episode"			elseif app.prefs.root.GetString("mediatype","anime")  = "manga" then			mu.PopupMenu1.ListIndex =1			mu.segmentlbl.text = "Chapter:"			mu.segmenttitle = "Chapter"			end if			mu.Show			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function ToolsRecommendationsBrowser() As Boolean Handles ToolsRecommendationsBrowser.Action			RecommendationBrowser.show			Return True					End Function	#tag EndMenuHandler	#tag MenuHandler		Function ToolsTimeline() As Boolean Handles ToolsTimeline.Action			Timeline.show			Return True					End Function	#tag EndMenuHandler	#tag Method, Flags = &h0		Sub AddNewTitle(MediaTitle as string, MediaType as string)		  Dim addw as new addwindow		  addw.TextField1.text = MediaTitle		  If MediaType = "anime" then		    addw.popupmenu1.listindex = 0		  elseif MediaType = "manga" then		    addw.popupmenu1.listindex = 1		  elseif MediaType = "lightnovel" then		    addw.popupmenu1.listindex = 2		  elseif MediaType = "vn" then		    addw.popupmenu1.listindex = 3		  end if		  addw.showmodalwithin(Window1)		  If addw.success = true then		    If window1.mediatype = addw.popupmenu1.text then		      Window1.loadlist(true)		    end if		  end if		  addw.close		  		End Sub	#tag EndMethod	#tag Method, Flags = &h21		Private Function HandleSparkleCancelQuit() As Boolean		  return true		End Function	#tag EndMethod	#tag Method, Flags = &h21		Private Sub HandleSparkleFoundVersion(isNew as Boolean, version as String)		  break		End Sub	#tag EndMethod	#tag Method, Flags = &h0		Function login(username as string, password as string, yield as boolean) As integer		  // using API to check credentials		  Dim socket1 as New HTTPSocket		  dim data as string		  socket1.yield = yield		  loginenc = EncodeBase64(username+ ":" + password)		  socket1.setrequestheader "Authorization","Basic " + loginenc		  data = socket1.get("http://melative.com/api/account/verify_credentials.xml",10)		  		  return socket1.httpstatuscode		End Function	#tag EndMethod	#tag Property, Flags = &h0		loginenc As string	#tag EndProperty	#tag Property, Flags = &h0		MemPassword As string	#tag EndProperty	#tag Property, Flags = &h0		MemUsername As String	#tag EndProperty	#tag Property, Flags = &h0		prefs As plist	#tag EndProperty	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"	#tag EndConstant	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"	#tag EndConstant	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"	#tag EndConstant	#tag ViewBehavior		#tag ViewProperty			Name="loginenc"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="MemPassword"			Group="Behavior"			Type="string"			EditorType="MultiLineEditor"		#tag EndViewProperty		#tag ViewProperty			Name="MemUsername"			Group="Behavior"			Type="String"			EditorType="MultiLineEditor"		#tag EndViewProperty	#tag EndViewBehaviorEnd Class#tag EndClass