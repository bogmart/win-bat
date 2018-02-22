@ECHO OFF

IF .%1. == ./d.  GOTO DEL_S
IF .%1. == ./D.  GOTO DEL_S



call serverVer.bat %1

IF     %serv_ver_eroare% EQU -1 GOTO HELP

IF NOT %serv_ver_eroare% EQU -1 GOTO SET_S



:SET_S
SUBST S: %serv_ver_util%
GOTO END


:DEL_S
subst s: /D
GOTO END



:HELP
@echo.
@echo s {server_ver}      == add
@echo s /d                == delete
@echo.
GOTO END




:END