@ECHO OFF

set cp_dyn_to_static=


:SET_DYN_DRIVE
   FOR /F "eol=. tokens=1 delims=\" %%i in ("%cd%") do  set dyn_drive=%%i


:SIGUR_VREI
   echo.
   set /p cp_dyn_to_static=  Sigur vrei sa copiezi obiectele IGMP din "%dyn_drive%" pe "s:\" [y] ?
   if "%cp_dyn_to_static%" == "y" GOTO COPY_FILES
   if "%cp_dyn_to_static%" == "Y" GOTO COPY_FILES

goto END


:COPY_FILES
   @echo on
   cp %dyn_drive%\malibu\server\Engine\Multicast\Igmp\utils\O\IgmpUtils.o  s:\malibu\server\Engine\Multicast\Igmp\utils\O\IgmpUtils.o
   cp %dyn_drive%\malibu\server\Engine\Multicast\Igmp\O\IgmpCore.o         s:\malibu\server\Engine\Multicast\Igmp\O\IgmpCore.o
   cp %dyn_drive%\malibu\server\Engine\Multicast\Mtrace\O\mtrace.o         s:\malibu\server\Engine\Multicast\Mtrace\O\mtrace.o
   @echo off


:END