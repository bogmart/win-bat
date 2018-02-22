@ECHO OFF

set sursa_vxWorks=E:\Versiuni\128bitcd

set ces_ip=10.20.30.50
set ces_user=a
set ces_pass=a

IF     .%1. == ..   GOTO SIGUR_VREI
IF     .%1. == .-h. GOTO HELP
IF     .%2. == ..   GOTO CES_IP
IF NOT .%2. == ..   GOTO CES_USER




:CES_USER
   IF .%2. == .. GOTO RESTART_TXT
   set ces_user=%2

:CES_PASS
   IF .%3. == .. GOTO RESTART_TXT
   set ces_pass=%3

:CES_IP
   set ces_ip=%1

GOTO RESTART_TXT





:SIGUR_VREI
   echo.
   set /p suprascriu=  Sigur vrei sa restartezi CES-ul %ces_ip%  [y] ?
   if "%suprascriu%" == "y" GOTO RESTART_TXT
   if "%suprascriu%" == "Y" GOTO RESTART_TXT

   GOTO HELP



:RESTART_TXT
   :: creez fiserul "restart.txt" cu comenzile necesare pt a pune "restart.cli" pe CES
   @ECHO OFF
   echo user %ces_user%>c:\restart.txt
   echo %ces_pass%>>c:\restart.txt
   echo bin>>c:\restart.txt
   echo cd SYSTEM/prov>>c:\restart.txt
   echo put c:\restart.cli>>c:\restart.txt
   echo close>>c:\restart.txt
   echo bye>>c:\restart.txt

   GOTO RESTART_CLI

:RESTART_CLI
   :: creez fiserul "restart.cli" cu comenzile necesare pt a restarta CES-ul
   @ECHO OFF
   echo enable>c:\restart.cli
   echo %ces_pass%>>c:\restart.cli
   echo reload restart boot-normal>>c:\restart.cli
   echo y>>c:\restart.cli


   GOTO PUT_RESTART_STR



:PUT_RESTART_STR
   ftp -n -s:C:\restart.txt %ces_ip%

   del c:\restart.txt
   del c:\restart.cli

   GOTO SHOW_TIME


:SHOW_TIME
   echo.
   echo  transferat la ora  %time%
   GOTO END


:HELP
   echo.
   ECHO utilizare:   %0  [CES_IP_Address]  [CES_user]  [CES_pass]
   ECHO           ( default:   IP: %ces_ip%   user: %ces_user%     pass: %ces_pass% )
   echo.
   @ECHO OFF
   GOTO END


:END