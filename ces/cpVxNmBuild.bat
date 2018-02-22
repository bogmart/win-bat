@ECHO OFF

set sursa_nm=\\k2\ftpzorg\ITC\files_from_nt_users\128bitcd

set ces_ip=10.20.30.25
set ces_user=a
set ces_pass=a
set ces_ver=V08_00.050


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


GOTO SET_PUT_TXT





:SIGUR_VREI
   echo.
   set /p suprascriu=  Sigur vrei sa incarci nm-ul pe %ces_ip% cu versiunea %ces_ver%  [y]  ?
   if "%suprascriu%" == "y" GOTO SET_PUT_TXT
   if "%suprascriu%" == "Y" GOTO SET_PUT_TXT

   GOTO HELP




:SET_PUT_TXT
   :: creez fiserul "cpVxNm.txt" cu comenzile necesare pt a pune vxworks pe CES
   @ECHO OFF
   echo user %ces_user%>c:\cpVxNm.txt
   echo %ces_pass%>>c:\cpVxNm.txt
   echo bin>>c:\cpVxNm.txt
   echo cd SYSTEM/bin>>c:\cpVxNm.txt
   echo put %sursa_nm%\%ces_ver%_vxWorks.nm vxWorks.nm>>c:\cpVxNm.txt
   echo close>>c:\cpVxNm.txt
   echo bye>>c:\cpVxNm.txt

   GOTO PUT_VX_NM



:PUT_VX_NM
   ftp -n -s:C:\cpVxNm.txt %ces_ip%

   del c:\cpVxNm.txt

   GOTO SHOW_TIME


:SHOW_TIME
   echo.
   echo  transferat la ora  %time%
   GOTO END


:HELP
   echo.
   ECHO utilizare:   cpVxNm   [CES_IP_Address]  [CES_user]  [CES_pass] [CES_ver]
   ECHO           ( default:   IP: %ces_ip%   user: %ces_user%     pass: %ces_pass%    ver: %ces_ver%)
   echo.
   @ECHO OFF
   GOTO END


:END