@echo off
SETLOCAL

:: example
::
:: cleanPPC
:: cleanPPC m100geL3P
:: cleanPPC m1000geL2P  y


set clean_start=%time%

set temp_file=c:\obj_clean.txt
set target=m1000geL3P
set obj_dir=*PPC603_


IF NOT .%1. == ..  set target=%1
IF NOT .%2. == ..  set cleanYN=%2

set obj_dir=%obj_dir%%target%
set obj_dir_SNMP=vxworks_nt_%target%.???

:TEST
   if "%cleanYN%" == "y" GOTO CLEAN
   if "%cleanYN%" == "Y" GOTO CLEAN
   echo.
   set /p cleanYN=  Are you sure you want to delete  %target%  [y/n] ?
   echo.
   if "%cleanYN%" == "y" GOTO CLEAN
   if "%cleanYN%" == "Y" GOTO CLEAN
   GOTO END

:CLEAN
   @echo on
   make TARGET=%target% clean_bsp

   dir /S /A:D /B "%obj_dir%"      >  %temp_file%
   dir /S /A:D /B "%obj_dir_SNMP%" >> %temp_file%
   FOR /F "tokens=1" %%D IN (%temp_file%) DO rmdir /S /Q %%D

:STATISTIC
   @echo off
   echo.
   echo  clean start time    %clean_start%
   echo  clean end time      %time%
   echo.

:END
   if exist %temp_file% rm %temp_file%

ENDLOCAL