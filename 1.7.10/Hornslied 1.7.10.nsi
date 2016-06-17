; �ν��緯 �⺻ ���� ����
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header.bmp"
!define MUI_HEADERIMAGE_LEFT
!define MUI_HEADERIMAGE_BITMAP_RTL_NOSTRETCH
!define MUI_ICON "hornsliedic.ico"
!define VERDIR "$INSTDIR\versions\${MCVER}\${MCVER}.jar"
!define LIBDIR "$INSTDIR\libraries\*"
!define MCVER "1.7.10"
!define VERSION_URL "http://cfs.tistory.com/custom/blog/203/2032529/skin/images/version1710.ini"
!define INST_VERSION "B1"
!define INTERNET_FILE "http://hornslied.tistory.com/attachment/cfile2.uf@2231A2395710F687033C0D.txt"
!define COLOR_WINDOW 5
BrandingText "Ludwig's Minecraft Mod Installer" ; �ϴ� �귣�� �ؽ�Ʈ ����
Setfont ������� 10 ; ��ġ�� �⺻ ��Ʈ�� �������, 10pt�� ����
AutoCloseWindow true ; ��ġ �Ϸ� �� �ڵ����� ������ �ѱ�
Caption "${MCVER} ����ũ����Ʈ ��� ����ġ�� Beta-2" ; ��ġ���� Ÿ��Ʋ ����
OutFile "Hornslied 1.7.10.exe" ; �����Ͻ� ������ ���� �̸� ����
InstallDir "$APPDATA\.minecraft" ; ���� ��� INSTDIR�� ��� ����
ShowInstDetails show ; ��ġ ���������� ���λ��� ǥ��
SetCompressor zlib ; ���� �˰����� zlib���� ����
RequestExecutionLevel user

; ��� ����
!include "MUI.nsh"
!include "Update.nsh"
!include "HornsliedLibrary.nsh"
!include "nsDialogs.nsh"
!include "LogicLib.nsh"

; ���� ����
Var 'ISO'
Var 'TMPINSTDIR'
Var 'Dlg'
Var 'Welcome'
Var 'WelcomeImg1'
Var 'WelcomeImg2'
Var 'WelcomeImg3'
Var 'Desc'
Var 'Setup'
Var 'LicenseChk'
Var 'LicenseLstner'
Var 'DirReq'
Var 'DirButton'
Var 'DirIcon'
Var 'License'
Var 'DirDsNtExst'

; �Լ�
Function MyInit
Aero::Apply ; Aero �÷����� Ȱ��ȭ
SetOutPath $TEMP ; �ٿ�ε� ��θ� $TEMP�� �����Ѵ�.
SetOverWrite on ; ����� ���
call InternetCheck ; InternetCheck �Լ� ȣ��(HornsliedLibrary ��� ����)
File "splash.bmp" ; splash.bmp �ٿ�ε�
newadvsplash::show /NOUNLOAD 1000 500 500 0xe236d6 "$TEMP\splash.bmp" ; splash.bmp ���Ϸ� ���÷��� ȭ�� ���
delete "splash.bmp" ; splash.bmp ����
call Update ; Update �Լ� ȣ��(Update ��� ����)
; Ŀ���� ������ ���� ����
!insertmacro MUI_INSTALLOPTIONS_EXTRACT "InstallOption1.ini"
!insertmacro MUI_INSTALLOPTIONS_EXTRACT "InstallOption2.ini"
!insertmacro MUI_INSTALLOPTIONS_EXTRACT "InstallOption3.ini"
!insertmacro MUI_INSTALLOPTIONS_EXTRACT "FinishPage.ini"
; FinishPage ��ư ���� ����
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 4" "State" "http://hornslied.tistory.com/"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 5" "State" "$DOCUMENTS\HornsliedInstaller\Modbackup\1.7.10"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 6" "State" "http://hornslied.tistory.com/23"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 7" "State" "https://github.com/LudwigHornslied"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 8" "State" "http://hornslied.tistory.com/guestbook"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 9" "State" "http://hornslied.tistory.com/25"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 10" "Text" "$PLUGINSDIR\doge.ico"
InitPluginsDir
SetOutPath $PLUGINSDIR ; �ٿ�ε� ��θ� $PLUGINSDIR�� �����Ѵ�.
File "License.txt" ; License.txt(���̼��� ����) ���� �ٿ�ε�
File "doge.ico" ; doge.ico(LOL Doge) ���� �ٿ�ε�
File "folder.ico" ; folder.ico(���� ������) ���� �ٿ�ε�
File "welcome1.bmp" ; welcome1.bmp ���� �ٿ�ε�
File "welcome2.bmp" ; welcome2.bmp ���� �ٿ�ε�
File "welcome3.bmp" ; welcome3.bmp ���� �ٿ�ε�
File "Version.txt" ; Version.txt ���� �ٿ�ε�
FunctionEnd

Function Welcome
!insertmacro MUI_HEADER_TEXT "ȯ���մϴ�" "����ũ����Ʈ ��� ��ġ�� �����մϴ�."
nsDialogs::Create 1018
Pop $Welcome

${If} $Welcome == error
Abort
${EndIf}
${NSD_CreateGroupBox} 305 104 295 159 "�������� ��" ; �׷�ڽ� ��Ʈ�� ����
nsDialogs::CreateControl RichEdit20A ${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_READONLY}|${ES_MULTILINE}|${ES_WANTRETURN} ${__NSD_Text_EXSTYLE} 315 124 275 129 ""
Pop $Desc
nsRichEdit::Load $Desc "$PLUGINSDIR\Version.txt" ; nsRichEdit �÷������� �̿��� Desc�� ������ �ؽ�Ʈ ��Ʈ���� ������ Version.txt�� ���� �������� ��ü�Ѵ�.
${NSD_CreateBitmap} 0 0 600 94 ; ��Ʈ�� ��Ʈ�� ����
Pop $WelcomeImg1
${NSD_SetStretchedImage} $WelcomeImg1 "$PLUGINSDIR\welcome1.bmp" $0
${NSD_OnClick} $WelcomeImg1 FmForum
${NSD_CreateBitmap} 0 104 295 74
Pop $WelcomeImg2
${NSD_SetStretchedImage} $WelcomeImg2 "$PLUGINSDIR\welcome2.bmp" $0
${NSD_OnClick} $WelcomeImg2 Arka
${NSD_CreateBitmap} 0 188 295 74 ; ��Ʈ�� ��Ʈ�� ����
Pop $WelcomeImg3
${NSD_SetStretchedImage} $WelcomeImg3 "$PLUGINSDIR\welcome3.bmp" $0
${NSD_OnClick} $WelcomeImg3 GuestBook
nsDialogs::Show ; ȭ�� ǥ��
FunctionEnd

Function FmForum
ExecShell "open" "https://www.fmforum.net/"
FunctionEnd

Function Arka
ExecShell "open" "http://cafe.naver.com/arkaserver/"
FunctionEnd

Function GuestBook
ExecShell "open" "http://hornslied.tistory.com/guestbook/"
FunctionEnd

Function Setup
!insertmacro MUI_HEADER_TEXT "��� ���� �� ����ũ����Ʈ ��� ����" "��� ��ġ�� ���� ��� ���� �� ����ũ����Ʈ ��θ� ������ �ֽʽÿ�."
nsDialogs::Create 1018
Pop $Setup

${If} $Setup == error
Abort
${EndIf}
${NSD_CreateGroupBox} 0 0 600 263 ""
${NSD_CreateGroupBox} 10 8 580 132 "���̼��� ���"
${NSD_CreateGroupBox} 10 150 580 60 "����ũ����Ʈ ���(.minecraft)"
${NSD_CreateCheckBox} 20 223 240 20 "�̿� ����� �о����� �̿� �����մϴ�."
Pop $LicenseChk
${NSD_OnClick} $LicenseChk "LicenseLstner"
${NSD_CreateLabel} 300 225 290 20 "�ش� ��ο��� ����ũ����Ʈ�� �������� �ʽ��ϴ�."
Pop $DirDsNtExst
${NSD_CreateIcon} 20 170 32 32
Pop $DirIcon
${NSD_SetIcon} $DirIcon "$PLUGINSDIR\folder.ico" $6
${NSD_CreateDirRequest} 60 175 435 25 $INSTDIR
Pop $DirReq
${NSD_OnChange} $DirReq "DirReq"
${NSD_CreateBrowseButton} 500 175 80 25 "ã�ƺ���..."
Pop $DirButton
${NSD_OnClick} $DirButton "DirButton"
nsDialogs::CreateControl RichEdit20A ${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_READONLY}|${ES_MULTILINE}|${ES_WANTRETURN} ${__NSD_Text_EXSTYLE} 20 28 560 102 ""
Pop $License
nsRichEdit::Load $License "$PLUGINSDIR\License.txt" ; nsRichEdit �÷������� �̿��� License�� ������ �ؽ�Ʈ ��Ʈ���� ������ License.txt�� ���� �������� ��ü�Ѵ�.
GetDlgItem $Dlg $HWNDPARENT 1
EnableWindow $Dlg 0
call MinecraftExist ; MinecraftExist �Լ� ȣ��
nsDialogs::Show ; ȭ�� ǥ��
FunctionEnd

Function LicenseLstner
${NSD_GetState} $LicenseChk $LicenseLstner ; ���̼��� ���� üũ�ڽ��� ���¸� LicenseLstner ������ �ҷ��´�.
IfFileExists "$INSTDIR\logs\latest.log" NextCheck NextDisable ; ����ڰ� ������ ��ο� logs/lastest.log ��ΰ� �ִ��� Ȯ���Ѵ�. ������ NextCheck ������ NextDisable�� �б��Ѵ�.
NextCheck:
StrCmp $LicenseLstner '1' NextEnable NextDisable ; LicenseLstner�� �ҷ��� üũ�ڽ��� ���¸� 1�� ���Ͽ� üũ�Ǿ� �ִ��� Ȯ���Ѵ�. ������ NextEnable ������ NextDisable�� �б��Ѵ�.
NextEnable:
GetDlgItem $Dlg $HWNDPARENT 1 ; ȭ�� â�� '����' ��ư�� ���� Dlg�� �ҷ��´�.
EnableWindow $Dlg 1 ; Dlg ������ �ҷ��� '����' ��ư�� Ȱ��ȭ�Ѵ�.
goto NextEnd ; NextEnd ���̺�� �ǳʶڴ�.
NextDisable:
GetDlgItem $Dlg $HWNDPARENT 1 ; ȭ�� â�� '����' ��ư�� ���� Dlg�� �ҷ��´�.
EnableWindow $Dlg 0 ; Dlg ������ �ҷ��� '����' ��ư�� ��Ȱ��ȭ�Ѵ�.
NextEnd:
FunctionEnd

Function DirButton
nsDialogs::SelectFolderDialog "��� ����" ; ��� �����̶�� ������ ���� ���� ȭ���� ����.
Pop $TMPINSTDIR ; ���� ���� ȭ�鿡�� ������ ��θ� TMPINSTDIR ������ �ҷ��´�.
${IfNot} $TMPINSTDIR == "error" ; TMPINSTDIR�� �ҷ��� ��ΰ� 'error'�� �ƴ� ��쿡
StrCpy $INSTDIR $TMPINSTDIR ; TMPINSTDIR�� �ҷ��� ��θ� �ٽ� INSTDIR�� ����ִ´�.
${EndIf}
${NSD_SetText} $DirReq $INSTDIR ; ��� ǥ�� ��Ʈ���� ������ ���� INSTDIR�� �������� �ٲ۴�.
call MinecraftExist ; MinecraftExist �Լ� ȣ��
FunctionEnd

Function DirReq
${NSD_GetText} $DirReq $INSTDIR ; DirReq ������ ������ ��Ʈ���� �ؽ�Ʈ�� INSTDIR ���� ��η� �����Ѵ�.
call MinecraftExist ; MinecraftExist �Լ� ȣ��
FunctionEnd

Function MinecraftExist
IfFileExists "$INSTDIR\logs\latest.log" MCExists NoMCExists ; ����ڰ� ������ ��ο� logs/lastest.log ��ΰ� �ִ��� Ȯ���Ѵ�. ������ MCExists ������ NoMCExists�� �б��Ѵ�.
MCExists:
ShowWindow $DirDsNtExst ${SW_HIDE} ; DirDsExst ������ ������ ��Ʈ��(�ش� ��ο� ����ũ����Ʈ�� ������ �ߴ� ��� ����)�� �����.
call LicenseLstner ; LicenseLstner �Լ� ȣ��
goto MCExEnd ; MCExEnd ���̺�� �ǳʶڴ�.
NoMCExists:
ShowWindow $DirDsNtExst ${SW_SHOW} ; DirDsExst ������ ������ ��Ʈ��(�ش� ��ο� ����ũ����Ʈ�� ������ �ߴ� ��� ����)�� ǥ���Ѵ�.
SetCtlColors $DirDsNtExst 0xff0000 transparent ; DirDsExst ������ ������ ��Ʈ���� ������ �ؽ�Ʈ ff0000(����), ��� �������� �����Ѵ�.
call LicenseLstner ; LicenseLstner �Լ� ȣ��
MCExEnd:
FunctionEnd

Function InstallOption1
!insertmacro MUI_HEADER_TEXT "��ġ�� ������ ������ �ֽʽÿ�." "(L)�� �پ��ִ� ���� ����Ʈ�δ� ��ġ�� �ʿ�� �մϴ�." ; ��� �ؽ�Ʈ ����
!insertmacro MUI_INSTALLOPTIONS_DISPLAY_RETURN "InstallOption1.ini" ; Ŀ���� ������ ǥ��
FunctionEnd

Function InstallOption2
!insertmacro MUI_HEADER_TEXT "��ġ�� ������ ������ �ֽʽÿ�." "(L)�� �پ��ִ� ���� ����Ʈ�δ� ��ġ�� �ʿ�� �մϴ�." ; ��� �ؽ�Ʈ ����
!insertmacro MUI_INSTALLOPTIONS_DISPLAY_RETURN "InstallOption2.ini" ; Ŀ���� ������ ǥ��
FunctionEnd

Function InstallOption3
!insertmacro MUI_HEADER_TEXT "��ġ�� ������ ������ �ֽʽÿ�." "(L)�� �پ��ִ� ���� ����Ʈ�δ� ��ġ�� �ʿ�� �մϴ�." ; ��� �ؽ�Ʈ ����
!insertmacro MUI_INSTALLOPTIONS_DISPLAY_RETURN "InstallOption3.ini" ; Ŀ���� ������ ǥ��
FunctionEnd

Function Instfiles_Pre
GetDlgItem $Dlg $HWNDPARENT 1
ShowWindow $Dlg ${SW_HIDE}
GetDlgItem $Dlg $HWNDPARENT 2
ShowWindow $Dlg ${SW_HIDE}
GetDlgItem $Dlg $HWNDPARENT 3
ShowWindow $Dlg ${SW_HIDE}
FunctionEnd

Function FinishPage
!insertmacro MUI_HEADER_TEXT "��� ��ġ�� �Ϸ��߽��ϴ�." "�̿��� �ּż� �����մϴ�." ; ��� �ؽ�Ʈ ����
GetDlgItem $Dlg $HWNDPARENT 1 ; ȭ�� â�� '����' ��ư�� ���� Dlg�� �ҷ��´�.
ShowWindow $Dlg ${SW_SHOW} ; Dlg ������ �ҷ��� '����' ��ư�� ǥ���Ѵ�.
SendMessage $Dlg ${WM_SETTEXT} 0 "STR:��ħ" ; Dlg ������ �ҷ��� '����' ��ư�� �ؽ�Ʈ�� ���ڿ� '��ħ' ���� �ٲ۴�.
GetDlgItem $Dlg $HWNDPARENT 2
ShowWindow $Dlg ${SW_SHOW}
GetDlgItem $Dlg $HWNDPARENT 3 ; ȭ�� â�� '����' ��ư�� ���� Dlg�� �ҷ��´�.
ShowWindow $Dlg ${SW_HIDE} ; Dlg ������ �ҷ��� '����' ��ư�� �����.
!insertmacro MUI_INSTALLOPTIONS_DISPLAY_RETURN "FinishPage.ini" ; Ŀ���� ������ ǥ��
FunctionEnd

; .onGUIInit�� �Լ��� MyInit���� ��ü�Ѵ�.
!define MUI_CUSTOMFUNCTION_GUIINIT MyInit
; ������ �Լ� Welcome ȣ��
Page custom Welcome
; ������ �Լ� Setup ȣ��
Page custom Setup
; ��� ��ó ������ ����
!define MUI_TEXT_LICENSE_TITLE "��� ��ó"
!define MUI_TEXT_LICENSE_SUBTITLE "�� ��ġ�⿡ ���� ������ ������ �� ��ó�Դϴ�."
!define MUI_LICENSEPAGE_TEXT_TOP ""
!define MUI_LICENSEPAGE_TEXT_BOTTOM "��ó �� ������ ���翡 �߸��� �κ��� �ִٸ� �˷��ֽñ� �ٶ��ϴ�."
!define MUI_LICENSEPAGE_BUTTON "���� >"
!insertmacro MUI_PAGE_LICENSE "Authors.rtf"
; ������ �Լ� InstallOption1~3 ȣ��
Page custom InstallOption1
Page custom InstallOption2
Page custom InstallOption3
; Instfiles page
!define MUI_TEXT_INSTALLING_TITLE "��� ��ġ��" ; ��� �ؽ�Ʈ ����
!define MUI_TEXT_INSTALLING_SUBTITLE "1.7.10 ���� ������ ��ġ�ϰ� �ֽ��ϴ�." ; ��� �ؽ�Ʈ ���� 2
!define MUI_PAGE_CUSTOMFUNCTION_PRE Instfiles_Pre ; ������ ���� �� Instfiles_Pre �Լ� ȣ��
!insertmacro MUI_PAGE_INSTFILES
; ������ �Լ� FinishPage ȣ��
Page custom FinishPage

; ��� ����
!insertmacro MUI_LANGUAGE "Korean" ; ��ġ�� �⺻ �� �ѱ���� ����

; ini ���� ����
ReserveFile "InstallOption1.ini"
ReserveFile "InstallOption2.ini"
ReserveFile "InstallOption3.ini"
ReserveFile "FinishPage.ini"
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; ����(��ġ ����)
Section "Mods" SEC01
SetOutPath "$PLUGINSDIR"
SetOverWrite ifnewer
call MinecraftCheck
call MineExeCheck
File "7za.exe"

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 7" "State"
StrCmp $ISO "1" Backup NoBackup
Backup:
CreateDirectory "$DOCUMENTS\HornsliedInstaller\Modbackup\1.7.10"
Copyfiles "$INSTDIR\mods" "$DOCUMENTS\HornsliedInstaller\Modbackup\1.7.10"
NoBackup:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 6" "State"
StrCmp $ISO "1" Reset NoReset
Reset:
delete "$INSTDIR\mods\*"
NoReset:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 4" "State"
StrCmp $ISO "1" ForgeInstall NoForgeInstall
ForgeInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile21.uf@2675E64C571260E6119FAF.001" "Forge.7z.001"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile21.uf@2573964C571260EA131581.002" "Forge.7z.002"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile24.uf@2163004C571260F12156B0.003" "Forge.7z.003"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile5.uf@2250904C571260F4301E70.004" "Forge.7z.004"
nsexec::exec '$PLUGINSDIR\7za.exe x "$PLUGINSDIR\Forge.7z.001"'
Copyfiles "$PLUGINSDIR\Forge\typesafe" "$APPDATA\.minecraft\libraries\com"
Copyfiles "$PLUGINSDIR\Forge\minecraftforge" "$APPDATA\.minecraft\libraries\net"
Copyfiles "$PLUGINSDIR\Forge\scala-lang" "$APPDATA\.minecraft\libraries\org"
delete "$APPDATA\.minecraft\versions\1.7.10 Hornslied\*"
CreateDirectory "$APPDATA\.minecraft\versions\1.7.10 Hornslied"
Copyfiles "$PLUGINSDIR\Forge\1.7.10 Hornslied\1.7.10 Hornslied.json" "$APPDATA\.minecraft\versions\1.7.10 Hornslied"
call ModFolder
NoForgeInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 5" "State"
StrCmp $ISO "1" LiteloaderInstall NoLiteloaderInstall
LiteloaderInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile1.uf@260B8D3E57125E501971C0.jar" "liteloader-1.7.10.jar"
Copyfiles "$PLUGINSDIR\liteloader-1.7.10.jar" "$INSTDIR\mods"
NoLiteloaderInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 8" "State"
StrCmp $ISO "1" OptifineInstall NoOptifineInstall
OptifineInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile3.uf@2659EB3B573F35F328A089.jar" "OptiFine_1.7.10_HD_U_D3_MOD.jar"
Copyfiles "$PLUGINSDIR\OptiFine_1.7.10_HD_U_D3_MOD.jar" "$INSTDIR\mods"
NoOptifineInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 9" "State"
StrCmp $ISO "1" HPInstall NoHPInstall
HPInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile8.uf@2112EC3E57125E22111F5F.jar" "b78_1710f.jar"
Copyfiles "$PLUGINSDIR\b78_1710f.jar" "$INSTDIR\mods"
NoHPInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 10" "State"
StrCmp $ISO "1" TMIInstall NoTMIInstall
TMIInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@2379C23E57125E6224D807.jar" "TooManyItems2014_07_15_1.7.10_Forge.jar"
Copyfiles "$PLUGINSDIR\TooManyItems2014_07_15_1.7.10_Forge.jar" "$INSTDIR\mods"
NoTMIInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 11" "State"
StrCmp $ISO "1" NEIInstall NoNEIInstall
NEIInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile5.uf@2171673E57125E252C79C4.jar" "CodeChickenCore-1.7.10-1.0.4.29-universal.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile4.uf@2221963E57125E560779C4.jar" "NotEnoughItems-1.7.10-1.0.3.74-universal.jar"
Copyfiles "$PLUGINSDIR\CodeChickenCore-1.7.10-1.0.4.29-universal.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\NotEnoughItems-1.7.10-1.0.3.74-universal.jar" "$INSTDIR\mods"
NoNEIInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 12" "State"
StrCmp $ISO "1" ToggleInstall NoToggleInstall
ToggleInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile25.uf@227D753E57125E58235395.jar" "PlayerAPI-1.7.10-1.2.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@22188C3E57125E620D1A21.jar" "ToggleSneak-(1.7.2)-v3.0.jar"
Copyfiles "$PLUGINSDIR\PlayerAPI-1.7.10-1.2.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\ToggleSneak-(1.7.2)-v3.0.jar" "$INSTDIR\mods"
NoToggleInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 13" "State"
StrCmp $ISO "1" BSInstall NoBSInstall
BSInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile23.uf@22574D49573F39E32569F7.jar" "BetterSprinting.jar"
Copyfiles "$PLUGINSDIR\BetterSprinting.jar" "$INSTDIR\mods"
NoBSInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 14" "State"
StrCmp $ISO "1" SmartInstall NoSmartInstall
SmartInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile25.uf@227D753E57125E58235395.jar" "PlayerAPI-1.7.10-1.2.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile21.uf@236CFC3E57125E5B3139D4.jar" "RenderPlayerAPI-1.7.10-1.3.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile3.uf@241C743E57125E5E0999CE.jar" "SmartCore-1.7.10-1.0.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile22.uf@2424893E57125E5E03F393.jar" "SmartMoving-1.7.10-15.3.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile10.uf@230D643E57125E5F174C74.jar" "SmartRender-1.7.10-2.1.jar"
Copyfiles "$PLUGINSDIR\PlayerAPI-1.7.10-1.2.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\RenderPlayerAPI-1.7.10-1.3.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\SmartCore-1.7.10-1.0.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\SmartMoving-1.7.10-15.3.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\SmartRender-1.7.10-2.1.jar" "$INSTDIR\mods"
NoSmartInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 15" "State"
StrCmp $ISO "1" ReiInstall NoReiInstall
ReiInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile2.uf@2579A53E57125E5A250763.jar" "Reis-Minimap-Mod-1.7.10.jar"
Copyfiles "$PLUGINSDIR\Reis-Minimap-Mod-1.7.10.jar" "$INSTDIR\mods"
NoReiInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 16" "State"
StrCmp $ISO "1" VoxelInstall NoVoxelInstall
VoxelInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile30.uf@2212CF3E57125E5512740C.litemod" "mod_voxelMap_1.5.20_for_1.7.10.litemod"
Copyfiles "$PLUGINSDIR\mod_voxelMap_1.5.20_for_1.7.10.litemod" "$INSTDIR\mods"
NoVoxelInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption1.ini" "Field 17" "State"
StrCmp $ISO "1" JourneyInstall NoJourneyInstall
JourneyInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@2278953E57125E1D25A86C.jar" "_JourneyMap-Mod-1.7.10-FairPlay.jar"
Copyfiles "$PLUGINSDIR\_JourneyMap-Mod-1.7.10-FairPlay.jar" "$INSTDIR\mods"
NoJourneyInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 3" "State"
StrCmp $ISO "1" BCMInstall NoBCMInstall
BCMInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile3.uf@245CA03D573FB39D01B03C.jar" "Batty's Coordinates PLUS Mod for Forge-1.7.10_1.6.0.jar"
Copyfiles "$PLUGINSDIR\Batty's Coordinates PLUS Mod for Forge-1.7.10_1.6.0.jar" "$INSTDIR\mods"
NoBCMInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 4" "State"
StrCmp $ISO "1" XrayInstall NoXrayInstall
XrayInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile10.uf@244B7D45573FB3CB338A9D.jar" "XRay-15.jar"
Copyfiles "$PLUGINSDIR\XRay-15.jar" "$INSTDIR\mods"
NoXrayInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 5" "State"
StrCmp $ISO "1" AutoFishInstall NoAutoFishInstall
AutoFishInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile5.uf@220FE73E57125E21132A1E.litemod" "Autofish-Mod-1.7.10.litemod"
Copyfiles "$PLUGINSDIR\Autofish-Mod-1.7.10.litemod" "$INSTDIR\mods"
NoAutoFishInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 6" "State"
StrCmp $ISO "1" KeybindInstall NoKeybindInstall
KeybindInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@26195C3E57125E530CBD49.litemod" "mod_macros_0.10.12_for_1.7.10.litemod"
Copyfiles "$PLUGINSDIR\mod_macros_0.10.12_for_1.7.10.litemod" "$INSTDIR\mods"
NoKeybindInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 7" "State"
StrCmp $ISO "1" InvTwInstall NoInvTwInstall
InvTwInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile28.uf@2515D73E57125E4F0FC8D8.jar" "Inventory-Tweaks-Mod-1.7.10.jar"
Copyfiles "$PLUGINSDIR\Inventory-Tweaks-Mod-1.7.10.jar" "$INSTDIR\mods"
NoInvTwInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 8" "State"
StrCmp $ISO "1" ArmorHInstall NoArmorHInstall
ArmorHInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile3.uf@2276723E57125E1B27BA84.jar" "[1.7.10]bspkrsCore-universal-6.16.sincommand.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile23.uf@23184E3E57125E1B0C92AE.jar" "[1.7.10]ArmorStatusHUD-client-1.28.jar"
Copyfiles "$PLUGINSDIR\[1.7.10]bspkrsCore-universal-6.16.sincommand.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\[1.7.10]ArmorStatusHUD-client-1.28.jar" "$INSTDIR\mods"
NoArmorHInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 9" "State"
StrCmp $ISO "1" StatusHInstall NoStatusHInstall
StatusHInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile3.uf@2276723E57125E1B27BA84.jar" "[1.7.10]bspkrsCore-universal-6.16.sincommand.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile21.uf@2372363E57125E1C2B1513.jar" "[1.7.10]StatusEffectHUD-client-1.27.jar"
Copyfiles "$PLUGINSDIR\[1.7.10]bspkrsCore-universal-6.16.sincommand.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\[1.7.10]StatusEffectHUD-client-1.27.jar" "$INSTDIR\mods"
NoStatusHInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 10" "State"
StrCmp $ISO "1" DirectionHInstall NoDirectionHInstall
DirectionHInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile3.uf@2276723E57125E1B27BA84.jar" "[1.7.10]bspkrsCore-universal-6.16.sincommand.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile7.uf@260B8D3E57125E1C18229C.jar" "[1.7.10]DirectionHUD-client-1.24.jar"
Copyfiles "$PLUGINSDIR\[1.7.10]bspkrsCore-universal-6.16.sincommand.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\[1.7.10]DirectionHUD-client-1.24.jar" "$INSTDIR\mods"
NoDirectionHInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 11" "State"
StrCmp $ISO "1" VzigInstall NoVzigInstall
VzigInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile30.uf@262D9B3C57409A590D6613.jar" "The 5zig Mod v3.5.12 for Minecraft 1.7.10.jar"
Copyfiles "$PLUGINSDIR\The 5zig Mod v3.5.12 for Minecraft 1.7.10.jar" "$INSTDIR\mods"
NoVzigInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 12" "State"
StrCmp $ISO "1" BetterPInstall NoBetterPInstall
BetterPInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile25.uf@2520CF3C57409A65165453.jar" "BetterPvP_1.9.1_Forge_1.7.10.jar"
Copyfiles "$PLUGINSDIR\BetterPvP_1.9.1_Forge_1.7.10.jar" "$INSTDIR\mods"
NoBetterPInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 13" "State"
StrCmp $ISO "1" SaturationInstall NoSaturationInstall
SaturationInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile4.uf@231C7E3C57409A711978F4.jar" "SaturationDisplay-1.7.2-2.0.jar"
Copyfiles "$PLUGINSDIR\SaturationDisplay-1.7.2-2.0.jar" "$INSTDIR\mods"
NoSaturationInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 14" "State"
StrCmp $ISO "1" XaeroInstall NoXaeroInstall
XaeroInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile5.uf@253EEC3C57409A7A01EC4E.jar" "Xaeros_Minimap_1.9_Forge_1.7.10.jar"
Copyfiles "$PLUGINSDIR\Xaeros_Minimap_1.9_Forge_1.7.10.jar" "$INSTDIR\mods"
NoXaeroInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 15" "State"
StrCmp $ISO "1" MatmosInstall NoMatmosInstall
MatmosInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile2.uf@2504153E57125E51202EAA.litemod" "MAtmos_r28b__1.7.10.litemod"
Copyfiles "$PLUGINSDIR\MAtmos_r28b__1.7.10.litemod" "$INSTDIR\mods"
NoMatmosInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 16" "State"
StrCmp $ISO "1" ArrowCamInstall NoArrowCamInstall
ArrowCamInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile4.uf@21223739575D17840AEED7.jar" "1.7.2_arrowcam_v1.1.jar"
Copyfiles "$PLUGINSDIR\1.7.2_arrowcam_v1.1.jar" "$INSTDIR\mods"
NoArrowCamInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption2.ini" "Field 17" "State"
StrCmp $ISO "1" DLInstall NoDLInstall
DLInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile22.uf@2617813E57125E370DAAD5.jar" "DynamicLights-1.7.10.jar"
Copyfiles "$PLUGINSDIR\DynamicLights-1.7.10.jar" "$INSTDIR\mods"
NoDLInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 3" "State"
StrCmp $ISO "1" IC2Install NoIC2Install
IC2Install:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@250BDF385755A8C50BB212.jar" "industrialcraft-2-2.2.822-experimental.jar"
Copyfiles "$PLUGINSDIR\industrialcraft-2-2.2.822-experimental.jar" "$INSTDIR\mods"
NoIC2Install:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 4" "State"
StrCmp $ISO "1" TEInstall NoTEInstall
TEInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile25.uf@25672E3E57125E6038EB50.jar" "ThermalExpansion-[1.7.10]4.1.2-240.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile28.uf@216AFC4F5755A4841A42E1.jar" "ThermalFoundation-[1.7.10]1.2.4-114.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@277C834F5755A4A50D9C01.jar" "CoFHCore-[1.7.10]3.1.2-325.jar"
Copyfiles "$PLUGINSDIR\ThermalExpansion-[1.7.10]4.1.2-240.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\ThermalFoundation-[1.7.10]1.2.4-114.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\CoFHCore-[1.7.10]3.1.2-325.jar" "$INSTDIR\mods"
NoTEInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 5" "State"
StrCmp $ISO "1" DIInstall NoDIInstall
DIInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile8.uf@2672EA3E57125E352B438D.jar" "Damage-Indicators-Mod-1.7.10.jar"
Copyfiles "$PLUGINSDIR\Damage-Indicators-Mod-1.7.10.jar" "$INSTDIR\mods"
NoDIInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 6" "State"
StrCmp $ISO "1" ShaderInstall NoShaderInstall
ShaderInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile2.uf@2177263E57125E5C285538.jar" "ShadersModCore-v2.3.31-mc1.7.10-f.jar"
Copyfiles "$PLUGINSDIR\ShadersModCore-v2.3.31-mc1.7.10-f.jar" "$INSTDIR\mods"
NoShaderInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 7" "State"
StrCmp $ISO "1" SPCInstall NoSPCInstall
SPCInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile10.uf@217EF6445753047A02AE97.jar" "spc-5.4-1.7.10.jar"
Copyfiles "$PLUGINSDIR\spc-5.4-1.7.10.jar" "$INSTDIR\mods"
NoSPCInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 8" "State"
StrCmp $ISO "1" WorldEInstall NoWorldEInstall
WorldEInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@210C5D48575304A316914D.jar" "worldedit-forge-mc1.7.10-6.0-beta-01.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile26.uf@2479713E57125E67261DBF.litemod" "WorldEdit-CUI-Mod-1.7.10.litemod"
Copyfiles "$PLUGINSDIR\worldedit-forge-mc1.7.10-6.0-beta-01.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\WorldEdit-CUI-Mod-1.7.10.litemod" "$INSTDIR\mods"
NoWorldEInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 9" "State"
StrCmp $ISO "1" CraftGuideInstall NoCraftGuideInstall
CraftGuideInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile30.uf@261C743E57125E2608BBF0.jar" "CraftGuide-1.6.8.2-forge.jar"
Copyfiles "$PLUGINSDIR\CraftGuide-1.6.8.2-forge.jar" "$INSTDIR\mods"
NoCraftGuideInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 10" "State"
StrCmp $ISO "1" ChickenChunkInstall NoChickenChunkInstall
ChickenChunkInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile5.uf@2171673E57125E252C79C4.jar" "CodeChickenCore-1.7.10-1.0.4.29-universal.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@266CFC3E57125E24307674.jar" "ChickenChunks-1.7.10-1.3.4.19-universal.jar"
Copyfiles "$PLUGINSDIR\CodeChickenCore-1.7.10-1.0.4.29-universal.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\ChickenChunks-1.7.10-1.3.4.19-universal.jar" "$INSTDIR\mods"
NoChickenChunkInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 11" "State"
StrCmp $ISO "1" ForestryInstall NoForestryInstall
ForestryInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile10.uf@2669DD3E57125E3A340DD9.jar" "forestry_1.7.10-4.2.11.59.jar"
Copyfiles "$PLUGINSDIR\forestry_1.7.10-4.2.11.59.jar" "$INSTDIR\mods"
NoForestryInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 12" "State"
StrCmp $ISO "1" CustomNPCInstall NoCustomNPCInstall
CustomNPCInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile21.uf@21048C3E57125E2E1FFBCB.jar" "CustomNPCs_mod-1.7.10d.jar"
Copyfiles "$PLUGINSDIR\CustomNPCs_mod-1.7.10d.jar" "$INSTDIR\mods"
NoCustomNPCInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 13" "State"
StrCmp $ISO "1" AM2Install NoAM2Install
AM2Install:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile25.uf@2218E14C573F3BFF1EB844.001" "1.7.10_AM2-1.4.0.009.7z.001"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile29.uf@2233834C573F3BA007942B.002" "1.7.10_AM2-1.4.0.009.7z.002"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@2535F24C573F3BA306F259.003" "1.7.10_AM2-1.4.0.009.7z.003"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile21.uf@23575B49573F3BCF29EADD.jar" "AnimationAPI-1.7.10-1.2.4.jar"
nsexec::exec '$PLUGINSDIR\7za.exe x "$PLUGINSDIR\1.7.10_AM2-1.4.0.009.7z.001"'
Copyfiles "$PLUGINSDIR\1.7.10_AM2-1.4.0.009.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\AnimationAPI-1.7.10-1.2.4.jar" "$INSTDIR\mods"
NoAM2Install:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 14" "State"
StrCmp $ISO "1" ThaumInstall NoThaumInstall
ThaumInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile5.uf@253712445718DE4E031260.001" "Thaumcraft-1.7.10-4.2.3.5.7z.001"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile25.uf@24577D445718DE541560E1.002" "Thaumcraft-1.7.10-4.2.3.5.7z.002"
nsexec::exec '$PLUGINSDIR\7za.exe x "$PLUGINSDIR\Thaumcraft-1.7.10-4.2.3.5.7z.001"'
Copyfiles "$PLUGINSDIR\Thaumcraft-1.7.10-4.2.3.5.jar" "$INSTDIR\mods"
NoThaumInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 15" "State"
StrCmp $ISO "1" GalacticInstall NoGalacticInstall
GalacticInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile6.uf@241C283E57125E4209EEDB.jar" "Galacticraft-Planets-1.7-3.0.12.454.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile25.uf@216B643E57125E46320DFA.jar" "GalacticraftCore-1.7-3.0.12.454.jar"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile21.uf@2468E93E57125E52351C70.jar" "MicdoodleCore-1.7-3.0.12.454.jar"
Copyfiles "$PLUGINSDIR\Galacticraft-Planets-1.7-3.0.12.454.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\GalacticraftCore-1.7-3.0.12.454.jar" "$INSTDIR\mods"
Copyfiles "$PLUGINSDIR\MicdoodleCore-1.7-3.0.12.454.jar" "$INSTDIR\mods"
NoGalacticInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 16" "State"
StrCmp $ISO "1" MMNMInstall NoMMNMInstall
MMNMInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile30.uf@262C7C36575306AD258527.001" "Mine Mine no Mi-1.7.10-0.2.4.7z.001"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile21.uf@222A5636575306B2272B8F.002" "Mine Mine no Mi-1.7.10-0.2.4.7z.002"
NSISdl::download "http://hornslied.tistory.com/attachment/cfile8.uf@223FC036575306B61439C0.003" "Mine Mine no Mi-1.7.10-0.2.4.7z.003"
nsexec::exec '$PLUGINSDIR\7za.exe x "$PLUGINSDIR\Mine Mine no Mi-1.7.10-0.2.4.7z.001"'
Copyfiles "$PLUGINSDIR\Mine Mine no Mi-1.7.10-0.2.4.jar" "$INSTDIR\mods"
NoMMNMInstall:

!insertmacro MUI_INSTALLOPTIONS_READ $ISO "InstallOption3.ini" "Field 17" "State"
StrCmp $ISO "1" TwilightInstall NoTwilightInstall
TwilightInstall:
NSISdl::download "http://hornslied.tistory.com/attachment/cfile25.uf@216B823E57125E6432B24F.jar" "twilightforest-1.7.10-2.3.7.jar"
Copyfiles "$PLUGINSDIR\twilightforest-1.7.10-2.3.7.jar" "$INSTDIR\mods"
NoTwilightInstall:

ExecShell "open" "http://hornslied.tistory.com/"
SectionEnd