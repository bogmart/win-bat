@ECHO OFF

::set cale_modul=S:\malibu\server\Security\O
set cale_modul=S:\malibu\server\engine
set nume_modul=load.o


set ces_ip=10.20.30.25
set ces_user=a
set ces_pass=a


IF     .%1. == ..   GOTO HELP
IF     .%1. == .-h. GOTO HELP
IF     .%2. == ..   GOTO MODUL
IF     .%3. == ..   GOTO CES_IP
IF NOT .%3. == ..   GOTO CES_USER



:CES_USER
   IF .%3. == .. GOTO SET_PUT_TXT
   set ces_user=%3

:CES_PASS
   IF .%4. == .. GOTO SET_PUT_TXT
   set ces_pass=%4

:CES_IP
   set ces_ip=%2

:MODUL
   set nume_modul=%1

:MODUL_TEST
   IF NOT EXIST %cale_modul%\%nume_modul% GOTO MODUL_HELP

GOTO SET_PUT_TXT



:SET_PUT_TXT
   :: creez fiserul "cpLoad.txt" cu comenzile necesare pt a pune "modulul" pe NVR
   @ECHO OFF
   echo user %ces_user%>c:\cpLoad.txt
   echo %ces_pass%>>c:\cpLoad.txt
   echo bin>>c:\cpLoad.txt
   echo put %cale_modul%\%nume_modul% %nume_modul%>>c:\cpLoad.txt
   echo close>>c:\cpLoad.txt
   echo bye>>c:\cpLoad.txt

   GOTO PUT_MODUL



:PUT_MODUL
   ftp -n -s:C:\cpLoad.txt %ces_ip%

   del c:\cpLoad.txt

   GOTO SHOW_TIME


:SHOW_TIME
   echo.
   echo  transferat la ora  %time%
   GOTO END


:HELP
   echo.
   ECHO utilizare:   cpLoad  [modul]  [CES_IP_Address]  [CES_user]  [CES_pass]
   ECHO           ( default:            IP: %ces_ip%   user: %ces_user%     pass: %ces_pass% )
   echo.
   @ECHO OFF
   GOTO END


:MODUL_HELP
   echo.
   ECHO  Nu exista modulul "%cale_modul%\%nume_modul%" !!!
   echo.
   @ECHO OFF
   GOTO END


:END