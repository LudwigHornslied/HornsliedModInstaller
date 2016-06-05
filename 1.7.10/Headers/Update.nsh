Function Update
NSISdl::download "${VERSION_URL}" "$PLUGINSDIR\version.ini"

ReadINIStr $0 "$PLUGINSDIR\version.ini" "Field 1" "State"
ReadINIStr $1 "$PLUGINSDIR\version.ini" "Field 2" "State"
ReadINIStr $2 "$PLUGINSDIR\version.ini" "Field 3" "State"

${If} $2 == "Force"
	Goto Force
${Else}
	Goto Client
${EndIf}

Force:
StrCmp $0 ${INST_VERSION} NONEWER FORCENEW
FORCENEW:
MessageBox MB_OKCANCEL "새로운 버젼이 발견되었습니다!$\n저작권 문제로 인해 강제 업데이트를 실행합니다." IDCANCEL GOQUIT
ExecShell "open" "$1"
Quit
GOQUIT:
MessageBox MB_OK "업데이트가 취소되었습니다!$\n설치기를 종료합니다."
Quit

Client:
StrCmp $0 ${INST_VERSION} NONEWER CLIENTNEW
CLIENTNEW:
MessageBox MB_YESNO "새로운 버젼이 발견되었습니다!$\n새로운 버젼을 다운로드 하시겠습니까?" IDNO NONEWER
ExecShell "open" "$1"
Quit

NONEWER:
FunctionEnd