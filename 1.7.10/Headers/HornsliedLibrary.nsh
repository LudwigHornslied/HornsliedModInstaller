Function InternetCheck
SetOutPath $TEMP
SetOverWrite on
NSISdl::download "${INTERNET_FILE}" "$PLUGINSDIR\InternetCheck.txt"
IfFileExists "$PLUGINSDIR\InternetCheck.txt" Internet NoInternet
Internet:
goto InternetEnd
NoInternet:
MessageBox MB_ICONEXCLAMATION "���ͳݿ� ����Ǿ� ���� �ʽ��ϴ�" IDOK NoInternetQuit
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
MessageBox MB_ICONEXCLAMATION "����ũ����Ʈ�� ����Ǿ� �ֽ��ϴ�.$\n ����ũ����Ʈ�� ���� �� �ٽ� �õ��� �ֽʽÿ�." IDOK Process
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
MessageBox MB_ICONEXCLAMATION "${MCVER} ������ ����ũ����Ʈ�� �ѹ� ������ �Ŀ� �ٽ� �õ��� �ֽʽÿ�." IDOK MCCheckFail
MCCheckEnd:
FunctionEnd