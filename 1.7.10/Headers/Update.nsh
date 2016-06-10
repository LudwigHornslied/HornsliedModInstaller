Function Update
NSISdl::download "${VERSION_URL}" "$PLUGINSDIR\version.ini"

ReadINIStr $0 "$PLUGINSDIR\version.ini" "Field 1" "State"
ReadINIStr $1 "$PLUGINSDIR\version.ini" "Field 2" "State"
ReadINIStr $2 "$PLUGINSDIR\version.ini" "Field 3" "State"
ReadINIStr $3 "$PLUGINSDIR\version.ini" "Field 4" "State"

StrCmp $2 "Force" Force Client

Force:
StrCmp $0 ${INST_VERSION} NoNewer ForceNew
ForceNew:
MessageBox MB_OK "$3"
ExecShell "open" "$1"
Quit

Client:
StrCmp $0 ${INST_VERSION} NoNewer ClientNew
ClientNew:
MessageBox MB_YESNO "$3" IDNO NONEWER
ExecShell "open" "$1"
Quit

NoNewer:
FunctionEnd