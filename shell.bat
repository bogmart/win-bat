@ECHO OFF

IF .%1.          == ./?.  GOTO HELP
IF .%1.          == .-h.  GOTO HELP
IF .%WIND_HOME%. == ..    GOTO HELP_ENV

SETLOCAL

set hac_ip=10.20.10.3
set symb_path=D:/bogmart_workbench/shine/bsp/m1000ge
set my_workspace=C:/WindRiver32/workspace

IF .%1. == ..   GOTO INIT


:HAC_IP
   set hac_ip=%1


:INIT
  call tasklist 2>null   | grep -i "wtxregd.exe\|wtxregds.exe" -s -q
  IF %ERRORLEVEL% EQU 1  (
     echo init Wind River Registry
     start wtxregd -i -s
     sleep 4
  )

  call tasklist /FI "IMAGENAME eq tgtsvr.exe" 2>null   | grep -i "tgtsvr.exe" -s -q
  IF %ERRORLEVEL% EQU 1  (
     echo init Wind River Target Server
     start tgtsvr.exe -n VxWorks6x_%hac_ip% -B wdbrpc -V -R %my_workspace% -RW -Bt 3 -c %symb_path%/vxWorks.st -A %hac_ip%
     sleep 1
  )

  

:START
   call  windsh %hac_ip%



GOTO END

:HELP
   echo.
   ECHO usage:     %0  [HAC_IP_Address]
   ECHO       ( default:   IP: %hac_ip% )
   echo.
   echo       Note: Configure the environment (wrenv.bat), before using it.
   @ECHO OFF
   GOTO END

:HELP_ENV
   echo.
   echo Please configure the environment (wrenv.bat)
   echo.

:END
ENDLOCAL


