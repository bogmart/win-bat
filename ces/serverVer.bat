@ECHO OFF

set /a serv_ver_eroare = 0
set serv_ver=
set serv_ver_util=
set serv_ver_drive=


IF .%1. == ..   GOTO ERR
IF .%1. == .7.  GOTO v7_05
IF .%1. == .8.  GOTO v8_05
IF .%1. == .8_2.  GOTO v8_20


::testez daca s-a introdus o litera corespunzatoare unui drive
FOR /F "tokens=1 delims=:" %%i in ("%1") do  set serv_ver_drive=%%i
IF EXIST "%serv_ver_drive%:\"   GOTO  DYNAMIC_VIEW



GOTO ERR


:v7_05
set serv_ver=%1
set serv_ver_util=D:\bogmart_view\v7_05
title v7_05
GOTO SET_SERVER_DRIVE

:v7_10_IGMP
set serv_ver=%1
set serv_ver_util=D:\bogmart_view\v7_10_IGMP
title v7_10_igmp
GOTO SET_SERVER_DRIVE

:v8_05
set serv_ver=%1
set serv_ver_util=D:\bogmart_view\v8_05
title v8_05
GOTO SET_SERVER_DRIVE

:v8_20
set serv_ver=%1
set serv_ver_util=D:\bogmart_view\v8_20
title v8_20
GOTO SET_SERVER_DRIVE


:DYNAMIC_VIEW
set serv_ver=%serv_ver_drive%
set serv_ver_drive=%serv_ver_drive%:
set serv_ver_util=%serv_ver_drive%\
title %serv_ver_drive%
GOTO END



:ERR
echo.
ECHO  versiune inexistenta !!!
ECHO  (v7_05 = "7", v8_05 = "8", v8_20 = "8_2" , dyn_view = "litera:")
echo.
set /a serv_ver_eroare = -1
set serv_ver=
set serv_ver_drive=
GOTO END


:SET_SERVER_DRIVE
   FOR /F "eol=. tokens=1 delims=\" %%i in ("%serv_ver_util%") do  set serv_ver_drive=%%i
   

:END