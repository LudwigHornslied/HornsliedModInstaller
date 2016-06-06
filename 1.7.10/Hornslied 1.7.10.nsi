SetCompressor lzma

; 인스톨러 기본 정보 설정
!define PRODUCT_NAME "Hornslied ${MCVER}"
!define PRODUCT_VERSION "${MCVER} v1"
!define PRODUCT_PUBLISHER "Ludwig Hornslied"
!define PRODUCT_WEB_SITE "http://hornslied.tistory.com/"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header.bmp"
!define MUI_HEADERIMAGE_LEFT
!define MUI_HEADERIMAGE_BITMAP_RTL_NOSTRETCH
!define MUI_ICON "hornsliedic.ico"
!define VERDIR "$INSTDIR\versions\${MCVER}\${MCVER}.jar"
!define LIBDIR "$INSTDIR\libraries\*"
!define MCVER "1.7.10"
!define VERSION_URL "http://cfs.tistory.com/custom/blog/203/2032529/skin/images/version1710.ini"
!define INST_VERSION "1"
!define INTERNET_FILE "http://hornslied.tistory.com/attachment/cfile2.uf@2231A2395710F687033C0D.txt"
!define COLOR_WINDOW 5
BrandingText "Ludwig's Minecraft Mod Installer"
Setfont 나눔고딕 10
AutoCloseWindow true
Caption "${MCVER} 마인크래프트 모드 간편설치기 v1"
RequestExecutionLevel user

; 헤더 파일
!include "MUI.nsh"
!include "Update.nsh"
!include "HornsliedLibrary.nsh"
!include "nsDialogs.nsh"
!include "nsDialogs_createTextMultiline.nsh"
!include "LogicLib.nsh"

; 변수 선언
Var 'ISO'
Var 'TMPINSTDIR'
Var 'Dlg'
Var 'Setup'
Var 'SetupBg'
Var 'LicenseBox'
Var 'DirBox'
Var 'LicenseChk'
Var 'LicenseLstner'
Var 'DirReq'
Var 'DirButton'
Var 'DirIcon'
Var 'License'
Var 'DirDsNtExst'

; 함수
Function MyInit
Aero::Apply ; Aero 플러그인 활성화
SetOutPath $TEMP ; 다운로드 경로를 $TEMP로 지정한다.
SetOverWrite on ; 덮어쓰기 허용
call InternetCheck ; InternetCheck 함수 호출(HornsliedLibrary 헤더 파일)
File "splash.bmp" ; splash.bmp 다운로드
newadvsplash::show /NOUNLOAD 1000 500 500 0xe236d6 "$TEMP\splash.bmp" ; splash.bmp 파일로 스플래시 화면
delete "splash.bmp" ; splash.bmp 삭제
call Update ; Update 함수 호출(Update 헤더 파일)
; 커스텀 페이지 압축 해제
!insertmacro MUI_INSTALLOPTIONS_EXTRACT "InstallOption1.ini"
!insertmacro MUI_INSTALLOPTIONS_EXTRACT "InstallOption2.ini"
!insertmacro MUI_INSTALLOPTIONS_EXTRACT "InstallOption3.ini"
!insertmacro MUI_INSTALLOPTIONS_EXTRACT "FinishPage.ini"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 4" "State" "http://hornslied.tistory.com/"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 5" "State" "$DOCUMENTS\HornsliedInstaller\Modbackup\1.7.10"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 6" "State" "http://hornslied.tistory.com/23"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 7" "State" "https://github.com/LudwigHornslied"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 8" "State" "http://hornslied.tistory.com/guestbook"
!insertmacro MUI_INSTALLOPTIONS_WRITE "FinishPage.ini" "Field 10" "Text" "$PLUGINSDIR\doge.ico"
InitPluginsDir
SetOutPath $PLUGINSDIR
NSISdl::download "http://hornslied.tistory.com/attachment/cfile9.uf@2379063C574B17D61A9B16.ico" "folder.ico"
File "License.txt"
File "doge.ico"
FunctionEnd

Function Setup
!insertmacro MUI_HEADER_TEXT "환영합니다" "모드 설치를 위해 약관 동의 및 마인크래프트 경로를 지정해 주십시오."
nsDialogs::Create 1018
Pop $Setup

${If} $Setup == error
Abort
${EndIf}
${NSD_CreateGroupBox} 0 0 600 263 ""
Pop $SetupBg
${NSD_CreateGroupBox} 10 8 580 132 "라이센스 약관"
Pop $LicenseBox
${NSD_CreateGroupBox} 10 150 580 60 "마인크래프트 경로(.minecraft)"
Pop $DirBox
${NSD_CreateCheckBox} 20 223 240 20 "이용 약관을 읽었으며 이에 동의합니다."
Pop $LicenseChk
${NSD_OnClick} $LicenseChk "LicenseLstner"
${NSD_CreateIcon} 20 170 32 32
${NSD_CreateLabel} 300 225 290 20 "해당 경로에는 마인크래프트가 설치되지 않았습니다."
Pop $DirDsNtExst
Pop $DirIcon
${NSD_SetIcon} $DirIcon "$PLUGINSDIR\folder.ico" $6
${NSD_CreateDirRequest} 60 175 435 25 $INSTDIR
Pop $DirReq
${NSD_OnChange} $DirReq "DirReq"
${NSD_CreateBrowseButton} 500 175 80 25 "찾아보기..."
Pop $DirButton
${NSD_OnClick} $DirButton "DirButton"
nsDialogs::CreateControl RichEdit20A ${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_READONLY}|${ES_MULTILINE}|${ES_WANTRETURN} ${__NSD_Text_EXSTYLE} 20 28 560 102 ""
Pop $License
nsRichEdit::Load $License "$PLUGINSDIR\License.txt"
GetDlgItem $Dlg $HWNDPARENT 1
EnableWindow $Dlg 0
call MinecraftExist
nsDialogs::Show
FunctionEnd

Function LicenseLstner
${NSD_GetState} $LicenseChk $LicenseLstner ; 라이센스 동의 체크박스의 상태를 LicenseLstner 변수에 불러온다.
IfFileExists "$INSTDIR\logs\latest.log" NextCheck NextDisable ; 사용자가 지정한 경로에 logs/lastest.log 경로가 있는지 확인한다. 있으면 NextCheck 없으면 NextDisable로 분기한다.
NextCheck:
StrCmp $LicenseLstner '1' NextEnable NextDisable ; LicenseLstner에 불러온 체크박스의 상태를 1과 비교하여 체크되어 있는지 확인한다. 있으면 NextEnable 없으면 NextDisable로 분기한다.
NextEnable:
GetDlgItem $Dlg $HWNDPARENT 1 ; 화면 창의 '다음' 버튼을 변수 Dlg에 불러온다.
EnableWindow $Dlg 1 ; Dlg 변수에 불러온 '다음' 버튼을 활성화한다.
goto NextEnd ; NextEnd 레이블로 건너뛴다.
NextDisable:
GetDlgItem $Dlg $HWNDPARENT 1 ; 화면 창의 '다음' 버튼을 변수 Dlg에 불러온다.
EnableWindow $Dlg 0 ; Dlg 변수에 불러온 '다음' 버튼을 비활성화한다.
NextEnd:
FunctionEnd

Function DirButton
nsDialogs::SelectFolderDialog "경로 지정" ; 경로 지정이라는 제목의 폴더 선택 화면을 띄운다.
Pop $TMPINSTDIR ; 폴더 선택 화면에서 선택한 경로를 TMPINSTDIR 변수에 불러온다.
${IfNot} $TMPINSTDIR == "error" ; TMPINSTDIR에 불러온 경로가 'error'가 아닐 경우에
StrCpy $INSTDIR $TMPINSTDIR ; TMPINSTDIR에 불러온 경로를 다시 INSTDIR로 집어넣는다.
${EndIf}
${NSD_SetText} $DirReq $INSTDIR ; 경로 표시 컨트롤의 내용을 변수 INSTDIR의 내용으로 바꾼다.
call MinecraftExist ; MinecraftExist 함수 호출
FunctionEnd

Function DirReq
${NSD_GetText} $DirReq $INSTDIR
call LicenseLstner
FunctionEnd

Function MinecraftExist
IfFileExists "$INSTDIR\logs\latest.log" MCExists NoMCExists ; 사용자가 지정한 경로에 logs/lastest.log 경로가 있는지 확인한다. 있으면 MCExists 없으면 NoMCExists로 분기한다.
MCExists:
ShowWindow $DirDsNtExst ${SW_HIDE} ; DirDsExst 변수에 지정된 컨트롤(해당 경로에 마인크래프트가 없을시 뜨는 경고 문구)을 숨긴다.
call LicenseLstner ; LicenseLstner 함수 호출
goto MCExEnd ; MCExEnd 레이블로 건너뛴다.
NoMCExists:
ShowWindow $DirDsNtExst ${SW_SHOW} ; DirDsExst 변수에 지정된 컨트롤(해당 경로에 마인크래프트가 없을시 뜨는 경고 문구)을 표시한다.
SetCtlColors $DirDsNtExst 0xff0000 transparent ; DirDsExst 변수에 지정된 컨트롤의 색상을 텍스트 ff0000(빨강), 배경 투명으로 설정한다.
call LicenseLstner ; LicenseLstner 함수 호출
MCExEnd:
FunctionEnd

Function InstallOption1
!insertmacro MUI_HEADER_TEXT "설치할 모드들을 선택해 주십시오." "(L)이 붙어있는 모드는 라이트로더 설치를 필요로 합니다."
!insertmacro MUI_INSTALLOPTIONS_DISPLAY_RETURN "InstallOption1.ini"
FunctionEnd

Function InstallOption2
!insertmacro MUI_HEADER_TEXT "설치할 모드들을 선택해 주십시오." "(L)이 붙어있는 모드는 라이트로더 설치를 필요로 합니다."
!insertmacro MUI_INSTALLOPTIONS_DISPLAY_RETURN "InstallOption2.ini"
FunctionEnd

Function InstallOption3
!insertmacro MUI_HEADER_TEXT "설치할 모드들을 선택해 주십시오." "(L)이 붙어있는 모드는 라이트로더 설치를 필요로 합니다."
!insertmacro MUI_INSTALLOPTIONS_DISPLAY_RETURN "InstallOption3.ini"
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
!insertmacro MUI_HEADER_TEXT "모드 설치를 완료했습니다." "이용해 주셔서 감사합니다."
GetDlgItem $Dlg $HWNDPARENT 1
ShowWindow $Dlg ${SW_SHOW}
SendMessage $Dlg ${WM_SETTEXT} 0 "STR:마침"
GetDlgItem $Dlg $HWNDPARENT 2
ShowWindow $Dlg ${SW_SHOW}
GetDlgItem $Dlg $HWNDPARENT 3
ShowWindow $Dlg ${SW_HIDE}
!insertmacro MUI_INSTALLOPTIONS_DISPLAY_RETURN "FinishPage.ini"
FunctionEnd

; .onGUIInit의 함수를 MyInit으로 대체한다.
!define MUI_CUSTOMFUNCTION_GUIINIT MyInit
; Setup page
Page custom Setup
; InstallOption Page
Page custom InstallOption1
Page custom InstallOption2
Page custom InstallOption3
; Instfiles page
!define MUI_TEXT_INSTALLING_TITLE "모드 설치중"
!define MUI_TEXT_INSTALLING_SUBTITLE "1.7.10 버전 모드들을 설치하고 있습니다."
!define MUI_PAGE_CUSTOMFUNCTION_PRE Instfiles_Pre
!insertmacro MUI_PAGE_INSTFILES
; Finish page
Page custom FinishPage
; Language files
!insertmacro MUI_LANGUAGE "Korean"

; Reserve files
ReserveFile "InstallOption1.ini"
ReserveFile "InstallOption2.ini"
ReserveFile "InstallOption3.ini"
ReserveFile "FinishPage.ini"
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Hornslied 1.7.10.exe"
InstallDir "$APPDATA\.minecraft"
ShowInstDetails show

; Sections
Section "MainSection" SEC01
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
nsexec::exec '7za.exe x "$PLUGINSDIR\Forge.7z.001"'
Copyfiles "$PLUGINSDIR\Forge\typesafe" "$INSTDIR\libraries\com"
Copyfiles "$PLUGINSDIR\Forge\minecraftforge" "$INSTDIR\libraries\net"
Copyfiles "$PLUGINSDIR\Forge\scala-lang" "$INSTDIR\libraries\org"
delete "$INSTDIR\versions\1.7.10 Hornslied\*"
CreateDirectory "$INSTDIR\versions\1.7.10 Hornslied"
Copyfiles "$PLUGINSDIR\Forge\1.7.10 Hornslied\1.7.10 Hornslied.json" "$INSTDIR\versions\1.7.10 Hornslied"
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
NSISdl::download "http://hornslied.tistory.com/attachment/cfile30.uf@2112CF3E57125E2111F845.jar" "Arrow-Camera-Mod-1.8.jar"
Copyfiles "$PLUGINSDIR\Arrow-Camera-Mod-1.8.jar" "$INSTDIR\mods"
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
NSISdl::download "http://hornslied.tistory.com/attachment/cfile8.uf@21147C3E57125E4D10A583.jar" "industrialcraft-2-2.2.820-experimental.jar"
Copyfiles "$PLUGINSDIR\industrialcraft-2-2.2.820-experimental.jar" "$INSTDIR\mods"
NoIC2Install:

ExecShell "open" "http://hornslied.tistory.com/"
SectionEnd