Function InternetCheck
SetOutPath $TEMP
SetOverWrite on
NSISdl::download "${INTERNET_FILE}" "$PLUGINSDIR\InternetCheck.txt"
IfFileExists "$PLUGINSDIR\InternetCheck.txt" Internet NoInternet
Internet:
goto InternetEnd
NoInternet:
MessageBox MB_ICONEXCLAMATION "인터넷에 연결되어 있지 않습니다" IDOK NoInternetQuit
NoInternetQuit:
quit
InternetEnd:
FunctionEnd

Function ModFolder
IfFileExists "$INSTDIR\mods" NoCreateModFolder CreateModFolder
CreateModFolder:
CreateDirectory "$INSTDIR\mods"
NoCreateModFolder:
FunctionEnd

Function MineExeCheck
Process:
Processes::FindProcess "javaw"
StrCmp $R0 "1" MineExeCheck MineExeNone
MineExeCheck:
MessageBox MB_ICONEXCLAMATION "마인크래프트가 실행되어 있습니다. 마인크래프트를 종료 후 다시 시도해 주십시오." IDOK Process
MineExeNone:
FunctionEnd

Function MinecraftCheck
IfFileExists "${VERDIR}" Verexist Noneexist
Verexist:
IfFileExists "${LIBDIR}" Libexist Noneexist
MCCheckFail:
quit
Libexist:
goto MCCheckEnd
Noneexist:
MessageBox MB_ICONEXCLAMATION "${MCVER} 버전의 마인크래프트를 한번 실행한 후에 다시 시도해 주십시오." IDOK MCCheckFail
MCCheckEnd:
FunctionEnd