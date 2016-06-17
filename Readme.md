Ludwig's Minecraft Mod Installer
===================

이 소스는 **NSIS**를 공부하시는 분들께 도움을 드리기 위해 배포되고 있습니다.
이 소스를 절대 악용해서는 안되며 2차 컴파일을 금지합니다.

----------
파일 구성
-------------

제 소스는 여러 가지 부가 파일을 포함하고 있습니다.

#### Headers
nsi 본 소스에서 !include 로 포함하게 되는 헤더 파일입니다.
nsh 형식이며 헤더 파일의 경로는 NSIS경로\Include에 넣도록 되어 있습니다.
#### Plugins
NSIS에 부가 기능을 포함시켜주는 플러그인들입니다.
dll 형식이며 플러그인의 경로는 NSIS경로\Plugins에 넣도록 되어 있습니다.
제가 첨부한 플러그인들은 왠만하면 다 Ansi 용입니다.
#### UIs
소스를 컴파일할때 참조하는 exe 형식의 파일입니다.
기본 UI를 제가 리소스 해커로 다시 컴파일 한 것입니다. 
경로는 NSIS경로\Contrib\UIS에 넣도록 되어 있습니다.
#### Source
말할것도 없습니다. nsi 형식의 NSIS 소스입니다. 
#### Images
설치기 폼을 구성할때 쓰이는 이미지 파일입니다.
대부분 bmp 형식이며 경로는 nsi 소스 파일과 같은 경로에 있어야 합니다.
#### Forms
InstallOptions를 이용하여 설치기 폼을 구성할때 쓰이는 ini 형식의 파일입니다.
version버전.ini 파일은 업데이트 체크용 파일입니다.
#### Texts
라이센스 약관 파일입니다. txt나 rtf 형식입니다.

----------
재 컴파일 금지
-------------------

이 소스를 재 컴파일하시면 절대로 안됩니다!
누가 소스를 수정해서 악의적인 소스로 재 컴파일할것을 우려해 제 통합설치기도 정해진 곳에 한해 배포하고 있습니다.
물론 이 소스를 연구하기 위해서나 피드백을 주시기 위해 열어보시는것은 환영입니다.
여러분이 진행하시고 있는 프로젝트에 도움이 되었으면 합니다, 이만.

