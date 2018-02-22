@ECHO OFF

call ccenv.bat %1


IF NOT %serv_ver_eroare% EQU -1 (
cd management\cli
call %serv_ver_util%\tools\nncli\xclive\xclive.bat
@ECHO OFF
GOTO END
)


:END