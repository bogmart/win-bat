@ECHO OFF

set sursa_vxWorks=\\k2\ftpzorg\ITC\files_from_nt_users\128bitcd

set ces_ip=10.20.30.25
set ces_user=a
set ces_pass=a
set ces_ver=V08_00.038


IF     .%1. == ..   GOTO SIGUR_VREI
IF     .%1. == .-h. GOTO HELP
IF     .%2. == ..   GOTO CES_IP
IF NOT .%4. == ..   GOTO CES_VER
IF NOT .%2. == ..   GOTO CES_USER



:CES_VER
   set ces_ver=%4

:CES_USER
   IF .%2. == .. GOTO SET_PUT_TXT
   set ces_user=%2

:CES_PASS
   IF .%3. == .. GOTO SET_PUT_TXT
   set ces_pass=%3

:CES_IP
   set ces_ip=%1

GOTO EXTRACT_TAR





:SIGUR_VREI
   echo.
   set /p suprascriu=  Sigur vrei sa suprascrii Kernelul de pe %ces_ip% cu versiunea %ces_ver%   [y] ?
   if "%suprascriu%" == "y" GOTO SET_PUT_TXT
   if "%suprascriu%" == "Y" GOTO SET_PUT_TXT

   GOTO HELP


:EXTRACT_TAR
   7z.exe e %sursa_vxWorks%\%ces_ver%.tar.gz  -o%temp%
   7z.exe e %temp%\%ces_ver%.tar              -o%temp% -i!bin\vxWorks
   del %temp%\%ces_ver%.tar


:SET_PUT_TXT
   :: creez fiserul "cpVxStr.txt" cu comenzile necesare pt a pune vxworks pe CES
   @ECHO OFF
   echo user %ces_user%>c:\cpVxStr.txt
   echo %ces_pass%>>c:\cpVxStr.txt
   echo bin>>c:\cpVxStr.txt
   echo cd SYSTEM/bin>>c:\cpVxStr.txt
   echo put %temp%\vxworks vxworks>>c:\cpVxStr.txt
   echo close>>c:\cpVxStr.txt
   echo bye>>c:\cpVxStr.txt

   GOTO PUT_VX_STR



:PUT_VX_STR
   ftp -n -s:C:\cpVxStr.txt %ces_ip%

   del c:\cpVxStr.txt
   del %temp%\vxWorks

   GOTO SHOW_TIME


:SHOW_TIME
   echo.
   echo  transferat la ora  %time%
   GOTO END


:HELP
   echo.
   ECHO utilizare:   cpVxStr  [CES_IP_Address]  [CES_user]  [CES_pass]
   ECHO           ( default:   IP: %ces_ip%   user: %ces_user%     pass: %ces_pass% )
   echo.
   @ECHO OFF
   GOTO END


:END