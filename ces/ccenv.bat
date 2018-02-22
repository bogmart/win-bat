@ECHO OFF

call serverVer.bat %1

IF NOT %serv_ver_eroare% EQU -1 (
%serv_ver_drive%
cd %serv_ver_util%\malibu\server
call ccenv.bat
@ECHO OFF
GOTO END
)



:END