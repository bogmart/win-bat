@ECHO OFF

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

IF     .%1. == .-h. GOTO HELP
IF     .%1. == ./?. GOTO HELP

:: SET Globals
set MY_WB_PATH=%1
set MY_VX_PATH=%2

if .%MY_WB_PATH%. == .. GOTO HELP
if .%MY_VX_PATH%. == .. GOTO SHOW_HARDLINKS

set pathToTestOld="%MY_WB_PATH%\components"
set linkToTestNew="%MY_VX_PATH%\components"

set linkToTestOld=
IF exist %pathToTestOld% (
   ::echo pathToTestOld !pathToTestOld!
   for /f %%a in ('linkd.exe %pathToTestOld% ^| grep -v Source') DO  set linkToTestOld="%%a"
   ::echo linkToTestOld !linkToTestOld!
   IF NOT .!linkToTestOld!. == .!linkToTestNew!. (
      goto REMOVE_HARDLINKS
      )
   )
GOTO END

:REMOVE_HARDLINKS
    :: remove old hardlinks
    linkd.exe %MY_WB_PATH%\components    /D   2>&0 1>&0
    linkd.exe %MY_WB_PATH%\vxworks-6.4   /D   2>&0 1>&0
    linkd.exe %MY_WB_PATH%\vxworks-6.8   /D   2>&0 1>&0
    linkd.exe %MY_WB_PATH%\vxworks-6.9   /D   2>&0 1>&0
    linkd.exe %MY_WB_PATH%\utilities-1.0 /D   2>&0 1>&0

:SET_HARDLINKS
    :: set new hardlinks
    IF exist %MY_VX_PATH%\components      linkd.exe %MY_WB_PATH%\components    %MY_VX_PATH%\components      2>&0 1>&0
    IF exist %MY_VX_PATH%\vxworks-6.4     linkd.exe %MY_WB_PATH%\vxworks-6.4   %MY_VX_PATH%\vxworks-6.4     2>&0 1>&0
    IF exist %MY_VX_PATH%\vxworks-6.8     linkd.exe %MY_WB_PATH%\vxworks-6.8   %MY_VX_PATH%\vxworks-6.8     2>&0 1>&0
    IF exist %MY_VX_PATH%\vxworks-6.9     linkd.exe %MY_WB_PATH%\vxworks-6.9   %MY_VX_PATH%\vxworks-6.9     2>&0 1>&0
    IF exist %MY_VX_PATH%\utilities-1.0   linkd.exe %MY_WB_PATH%\utilities-1.0 %MY_VX_PATH%\utilities-1.0   2>&0 1>&0
    GOTO SHOW_HARDLINKS
    
:SHOW_HARDLINKS
    echo.
    dir %MY_WB_PATH% | grep "JUNCTION"
    GOTO END

:HELP
   echo.
   ECHO usage:     %0  [windRiver path] [vxWorks path]
   echo.
   echo example    %0  S:\WindRiver32
   echo            %0  S:\WindRiver32   S:\bogmart_workbench\vxWorks_PNE
   echo            %0  S:\WindRiver32   S:\bogmart_workbench\vxWorks6
   echo            %0  S:\WindRiver32   S:\bogmart_workbench\vxWorks_2010_v5.0
   echo.
   @ECHO OFF
   GOTO END


:END
ENDLOCAL