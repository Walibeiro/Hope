;NSIS Modern User Interface version 1.70
;HOPE - Object-Pascal Environment
;Written by Walison Ribeiro da Silva

SetCompressor /SOLID /FINAL lzma

;--------------------------------
;Include Modern UI

;  !include "Sections.nsh"
;  !define SF_SELECTED   1
  !include "MUI.nsh"

;--------------------------------
;General

  ;Name and file
  Name "HOPE Object-Pascal Environment"
  OutFile "HOPE_Setup.exe"

  BrandingText "Walison Ribeiro da Silva"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\HOPE"
  
  ; Turn on the xp style of drawing
  XPStyle ON
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\HOPE" ""

;--------------------------------
;Variables

  Var MUI_TEMP
  Var STARTMENU_FOLDER

;--------------------------------
;Interface Settings

;  !define MUI_ICON modern.ico
;  !define MUI_UNICON modernul.ico
;  !define MUI_BGCOLOR E0F0E0 
  !define MUI_ABORTWARNING

;--------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU" 
  !define MUI_LANGDLL_REGISTRY_KEY "Software\HOPE" 
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  !insertmacro MUI_PAGE_COMPONENTS

  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\HOPE" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  !insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER

  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_PAGE_FINISH
  
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"
;  !insertmacro MUI_LANGUAGE "German"

;--------------------------------
;Reserve Files
  
;These files should be inserted before other files in the data block
;Keep these lines before any File command
;Only for solid compression (by default, solid compression is enabled for BZIP2 and LZMA)
  
  !insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
;  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------

;Installer Sections

Section "Program Files" SecProgramFiles
  SetShellVarContext all

  SetOutPath "$INSTDIR"
  File "..\Binaries\x86\HOPE.exe"
  File "..\Binaries\x86\cef.pak"
  File "..\Binaries\x86\cef_100_percent.pak"
  File "..\Binaries\x86\cef_200_percent.pak"
  File "..\Binaries\x86\cef_extensions.pak"
  File "..\Binaries\x86\d3dcompiler_43.dll"
  File "..\Binaries\x86\d3dcompiler_47.dll"
  File "..\Binaries\x86\DCEF3.exe"
  File "..\Binaries\x86\devtools_resources.pak"
  File "..\Binaries\x86\ffmpegsumo.dll"
  File "..\Binaries\x86\HCC.exe"
  File "..\Binaries\x86\Hope.exe"
  File "..\Binaries\x86\icudtl.dat"
  File "..\Binaries\x86\libcef.dll"
  File "..\Binaries\x86\libEGL.dll"
  File "..\Binaries\x86\libGLESv2.dll"
  File "..\Binaries\x86\natives_blob.bin"
  File "..\Binaries\x86\snapshot_blob.bin"
  File "..\Binaries\x86\widevinecdmadapter.dll"
  File "..\Binaries\x86\wow_helper.exe"

  SetOutPath "$INSTDIR\locales"
  File "..\Binaries\x86\locales\am.pak"
  File "..\Binaries\x86\locales\ar.pak"
  File "..\Binaries\x86\locales\bg.pak"
  File "..\Binaries\x86\locales\bn.pak"
  File "..\Binaries\x86\locales\ca.pak"
  File "..\Binaries\x86\locales\cs.pak"
  File "..\Binaries\x86\locales\da.pak"
  File "..\Binaries\x86\locales\de.pak"
  File "..\Binaries\x86\locales\el.pak"
  File "..\Binaries\x86\locales\en-GB.pak"
  File "..\Binaries\x86\locales\en-US.pak"
  File "..\Binaries\x86\locales\es-419.pak"
  File "..\Binaries\x86\locales\es.pak"
  File "..\Binaries\x86\locales\et.pak"
  File "..\Binaries\x86\locales\fa.pak"
  File "..\Binaries\x86\locales\fi.pak"
  File "..\Binaries\x86\locales\fil.pak"
  File "..\Binaries\x86\locales\fr.pak"
  File "..\Binaries\x86\locales\gu.pak"
  File "..\Binaries\x86\locales\he.pak"
  File "..\Binaries\x86\locales\hi.pak"
  File "..\Binaries\x86\locales\hr.pak"
  File "..\Binaries\x86\locales\hu.pak"
  File "..\Binaries\x86\locales\id.pak"
  File "..\Binaries\x86\locales\it.pak"
  File "..\Binaries\x86\locales\ja.pak"
  File "..\Binaries\x86\locales\kn.pak"
  File "..\Binaries\x86\locales\ko.pak"
  File "..\Binaries\x86\locales\lt.pak"
  File "..\Binaries\x86\locales\lv.pak"
  File "..\Binaries\x86\locales\ml.pak"
  File "..\Binaries\x86\locales\mr.pak"
  File "..\Binaries\x86\locales\ms.pak"
  File "..\Binaries\x86\locales\nb.pak"
  File "..\Binaries\x86\locales\nl.pak"
  File "..\Binaries\x86\locales\pl.pak"
  File "..\Binaries\x86\locales\pt-BR.pak"
  File "..\Binaries\x86\locales\pt-PT.pak"
  File "..\Binaries\x86\locales\ro.pak"
  File "..\Binaries\x86\locales\ru.pak"
  File "..\Binaries\x86\locales\sk.pak"
  File "..\Binaries\x86\locales\sl.pak"
  File "..\Binaries\x86\locales\sr.pak"
  File "..\Binaries\x86\locales\sv.pak"
  File "..\Binaries\x86\locales\sw.pak"
  File "..\Binaries\x86\locales\ta.pak"
  File "..\Binaries\x86\locales\te.pak"
  File "..\Binaries\x86\locales\th.pak"
  File "..\Binaries\x86\locales\tr.pak"
  File "..\Binaries\x86\locales\uk.pak"
  File "..\Binaries\x86\locales\vi.pak"
  File "..\Binaries\x86\locales\zh-CN.pak"
  File "..\Binaries\x86\locales\zh-TW.pak"
  
  SetOutPath "$COMMONFILES\Hope\Welcome Page"
  File "..\Binaries\Common\Welcome Page\index.html"
  File "..\Binaries\Common\Welcome Page\main.css"
  File "..\Binaries\Common\Welcome Page\main.js"
  File "..\Binaries\Common\Welcome Page\Images\Icon.svg"
  File "..\Binaries\Common\Welcome Page\Images\ProjectNew.png"
  File "..\Binaries\Common\Welcome Page\Images\ProjectOpen.png"
  File "..\Binaries\Common\Welcome Page\Images\ProjectClose.png"
  
  SetOutPath "$DOCUMENTS\Hope\Test"
  File "..\Binaries\Common\Projects\Test\Test.hproj"

  ;Store installation folder
  WriteRegStr HKCU "Software\HOPE" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\HOPE.lnk" "$INSTDIR\HOPE.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_END

SectionEnd

;--------------------------------
;Installer Functions

Function .onInit

;  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecProgramFiles ${LANG_ENGLISH} "HOPE Program Files"

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecProgramFiles} $(DESC_SecProgramFiles)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...
  Delete "$INSTDIR\HOPE.exe"
  Delete "$INSTDIR\cef.pak"
  Delete "$INSTDIR\cef_100_percent.pak"
  Delete "$INSTDIR\cef_200_percent.pak"
  Delete "$INSTDIR\cef_extensions.pak"
  Delete "$INSTDIR\d3dcompiler_43.dll"
  Delete "$INSTDIR\d3dcompiler_47.dll"
  Delete "$INSTDIR\DCEF3.exe"
  Delete "$INSTDIR\devtools_resources.pak"
  Delete "$INSTDIR\ffmpegsumo.dll"
  Delete "$INSTDIR\HCC.exe"
  Delete "$INSTDIR\Hope.exe"
  Delete "$INSTDIR\icudtl.dat"
  Delete "$INSTDIR\libcef.dll"
  Delete "$INSTDIR\libEGL.dll"
  Delete "$INSTDIR\libGLESv2.dll"
  Delete "$INSTDIR\natives_blob.bin"
  Delete "$INSTDIR\snapshot_blob.bin"
  Delete "$INSTDIR\widevinecdmadapter.dll"
  Delete "$INSTDIR\wow_helper.exe"
  Delete "$INSTDIR\locales\am.pak"
  Delete "$INSTDIR\locales\ar.pak"
  Delete "$INSTDIR\locales\bg.pak"
  Delete "$INSTDIR\locales\bn.pak"
  Delete "$INSTDIR\locales\ca.pak"
  Delete "$INSTDIR\locales\cs.pak"
  Delete "$INSTDIR\locales\da.pak"
  Delete "$INSTDIR\locales\de.pak"
  Delete "$INSTDIR\locales\el.pak"
  Delete "$INSTDIR\locales\en-GB.pak"
  Delete "$INSTDIR\locales\en-US.pak"
  Delete "$INSTDIR\locales\es-419.pak"
  Delete "$INSTDIR\locales\es.pak"
  Delete "$INSTDIR\locales\et.pak"
  Delete "$INSTDIR\locales\fa.pak"
  Delete "$INSTDIR\locales\fi.pak"
  Delete "$INSTDIR\locales\fil.pak"
  Delete "$INSTDIR\locales\fr.pak"
  Delete "$INSTDIR\locales\gu.pak"
  Delete "$INSTDIR\locales\he.pak"
  Delete "$INSTDIR\locales\hi.pak"
  Delete "$INSTDIR\locales\hr.pak"
  Delete "$INSTDIR\locales\hu.pak"
  Delete "$INSTDIR\locales\id.pak"
  Delete "$INSTDIR\locales\it.pak"
  Delete "$INSTDIR\locales\ja.pak"
  Delete "$INSTDIR\locales\kn.pak"
  Delete "$INSTDIR\locales\ko.pak"
  Delete "$INSTDIR\locales\lt.pak"
  Delete "$INSTDIR\locales\lv.pak"
  Delete "$INSTDIR\locales\ml.pak"
  Delete "$INSTDIR\locales\mr.pak"
  Delete "$INSTDIR\locales\ms.pak"
  Delete "$INSTDIR\locales\nb.pak"
  Delete "$INSTDIR\locales\nl.pak"
  Delete "$INSTDIR\locales\pl.pak"
  Delete "$INSTDIR\locales\pt-BR.pak"
  Delete "$INSTDIR\locales\pt-PT.pak"
  Delete "$INSTDIR\locales\ro.pak"
  Delete "$INSTDIR\locales\ru.pak"
  Delete "$INSTDIR\locales\sk.pak"
  Delete "$INSTDIR\locales\sl.pak"
  Delete "$INSTDIR\locales\sr.pak"
  Delete "$INSTDIR\locales\sv.pak"
  Delete "$INSTDIR\locales\sw.pak"
  Delete "$INSTDIR\locales\ta.pak"
  Delete "$INSTDIR\locales\te.pak"
  Delete "$INSTDIR\locales\th.pak"
  Delete "$INSTDIR\locales\tr.pak"
  Delete "$INSTDIR\locales\uk.pak"
  Delete "$INSTDIR\locales\vi.pak"
  Delete "$INSTDIR\locales\zh-CN.pak"
  Delete "$INSTDIR\locales\zh-TW.pak"
  Delete "$INSTDIR\Uninstall.exe"
  Delete "$COMMONFILES\Hope\Welcome Page\index.html"
  Delete "$COMMONFILES\Hope\Welcome Page\main.css"
  Delete "$COMMONFILES\Hope\Welcome Page\main.js"
  Delete "$COMMONFILES\Hope\Welcome Page\Images\Icon.svg"
  Delete "$COMMONFILES\Hope\Welcome Page\Images\ProjectNew.png"
  Delete "$COMMONFILES\Hope\Welcome Page\Images\ProjectOpen.png"
  Delete "$COMMONFILES\Hope\Welcome Page\Images\ProjectClose.png"
  Delete "$DOCUMENTS\Hope\Test\Test.hproj"

  !insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP
    
  Delete "$SMPROGRAMS\$MUI_TEMP\HOPE.lnk"
  Delete "$SMPROGRAMS\$MUI_TEMP\Uninstall.lnk"
  
  ;Delete empty start menu parent diretories
  StrCpy $MUI_TEMP "$SMPROGRAMS\$MUI_TEMP"
 
  startMenuDeleteLoop:
    RMDir $MUI_TEMP
    GetFullPathName $MUI_TEMP "$MUI_TEMP\.."
    
    IfErrors startMenuDeleteLoopDone
  
    StrCmp $MUI_TEMP $SMPROGRAMS startMenuDeleteLoopDone startMenuDeleteLoop
  startMenuDeleteLoopDone:

  DeleteRegKey /ifempty HKCU "Software\HOPE"

SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit

;  !insertmacro MUI_UNGETLANGUAGE
  
FunctionEnd