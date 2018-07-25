@ECHO OFF


SETLOCAL

::hmAction
set oid_reboot_P4=.1.3.6.1.4.1.248.14.2.1.0

::hm2DevMgmtActionReset (1= other, 2 = reset)
set oid_reboot_P5=.1.3.6.1.4.1.248.11.10.1.2.1.0

:HAC_IP
   set hac_ip=%1
   
IF .%hac_ip%.==.. GOTO HELP

:REBOOT
   echo  rebooting...
   snmpset -v 2c -c private -r 1 -t 1  %hac_ip%  %oid_reboot_P4% i 2    >nul 2>nul
   snmpset -v 2c -c private -r 1 -t 1  %hac_ip%  %oid_reboot_P5% i 2    >nul 2>nul
   GOTO END

:HELP
   echo.
   ECHO usage:     %0  [HAC_IP]
   echo.
   @ECHO OFF
   GOTO END

:END
ENDLOCAL
