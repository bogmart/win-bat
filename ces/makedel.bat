@ECHO OFF
IF     .%1.==..  GOTO ERR
IF     .%1.==.y. GOTO DELL
IF NOT .%1.==..  GOTO CD_DIR

:CD_DIR
pushd %1
IF ERRORLEVEL 1 GOTO ERR_CD
GOTO DELL

:DELL
del /s *.o *.d *depend* *.contrib *.pch* *.pyc *.a
popd
attrib -r %serv_ver_util%\malibu\server\kernel\target\config\pc486cmp\bootInit_st.c
attrib -r %serv_ver_util%\malibu\server\kernel\target\config\ckernel\usrConfig_vxcore.c
attrib -r %serv_ver_util%\malibu\server\kernel\target\config\pc486\usrConfig_st.c
attrib -r %serv_ver_util%\malibu\server\kernel\target\lib\libI80486gnunoc.a
del       %serv_ver_util%\malibu\server\kernel\target\config\pc486cmp\bootInit_st.c
del       %serv_ver_util%\malibu\server\kernel\target\config\pc486cmp\bootInit_st.o
del       %serv_ver_util%\malibu\server\kernel\target\config\ckernel\usrConfig_vxcore.c
del       %serv_ver_util%\malibu\server\kernel\target\config\ckernel\usrConfig_vxcore.o
del       %serv_ver_util%\malibu\server\kernel\target\config\pc486\usrConfig_st.c
del       %serv_ver_util%\malibu\server\kernel\target\config\pc486\usrConfig_st.o
del       %serv_ver_util%\malibu\server\kernel\target\lib\libI80486gnunoc.a
GOTO END

:ERR
ECHO  trebuie introdusa calea
GOTO END

:ERR_CD
ECHO  director inexistent
GOTO END

:END