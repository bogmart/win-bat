@ECHO OFF


SETLOCAL

::hmAction
set oid_reboot=.1.3.6.1.4.1.248.14.2.1.0

:HAC_IP
   set hac_ip=%1
   
IF .%hac_ip%.==.. GOTO HELP

:REBOOT
   echo  rebooting...
   snmpset -v 2c -c private  %hac_ip%  %oid_reboot% i 2    >nul 2>nul
   GOTO END

:HELP
   echo.
   ECHO usage:     %0  [HAC_IP (Platform4)]
   echo.
   @ECHO OFF
   GOTO END

:END
ENDLOCAL
