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
MessageBox MB_OKCANCEL "���ο� ������ �߰ߵǾ����ϴ�!$\n���۱� ������ ���� ���� ������Ʈ�� �����մϴ�." IDCANCEL GOQUIT
ExecShell "open" "$1"
Quit
GOQUIT:
MessageBox MB_OK "������Ʈ�� ��ҵǾ����ϴ�!$\n��ġ�⸦ �����մϴ�."
Quit

Client:
StrCmp $0 ${INST_VERSION} NONEWER CLIENTNEW
CLIENTNEW:
MessageBox MB_YESNO "���ο� ������ �߰ߵǾ����ϴ�!$\n���ο� ������ �ٿ�ε� �Ͻðڽ��ϱ�?" IDNO NONEWER
ExecShell "open" "$1"
Quit

NONEWER:
FunctionEnd