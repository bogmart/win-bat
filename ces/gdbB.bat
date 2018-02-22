@ECHO OFF

call ccenv.bat %1


IF     %serv_ver_eroare% EQU -1  GOTO END
IF NOT %serv_ver_eroare% EQU -1  GOTO TEST_COPY


:TEST_COPY
IF .%2. == ..   GOTO GDB
IF .%2. == .c.  GOTO COPY
GOTO INVALID

:COPY
copy E:\coredump\core*.* /B %serv_ver_util%\kernel\target\config\pc486\core.mem /B
move E:\coredump\core*.* E:\coredump\arhiva\
GOTO GDB

:GDB
::explorer.exe E:\coredump
::explorer.exe %serv_ver_util%\malibu\server\kernel\target\config\pc486
%serv_ver_drive%
cd %serv_ver_util%\malibu\server\kernel\target\config\pc486\
call gdb vxworks
@ECHO OFF
GOTO END




:INVALID
ECHO  optinue "%2" invalida (posibilitati: "c" sau "")
@ECHO OFF
GOTO END

:END