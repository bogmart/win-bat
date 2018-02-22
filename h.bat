@echo off
set hac_user=mxb11081

if     .%1. == .. GOTO HELP
if not .%2. == .. set hac_user=%2


net use h:  \\10.115.210.7\DENEC1-Workgroups\Luxoft /USER:eu.gad.local\%hac_user% /PERSISTENT:YES %1
goto END

:HELP
   echo.
   ECHO usage:      %0  {password} [user] 
   ECHO       ( default user: %hac_user% )
   echo.

   GOTO END

:END