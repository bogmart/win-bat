@ECHO OFF

set sursa_nm=S:\malibu\server\kernel\target\config\pc486

set ces_ip=10.20.30.25
set ces_user=a
set ces_pass=a


IF     .%1. == ..   GOTO SIGUR_VREI
IF     .%1. == .-h. GOTO HELP
IF     .%2. == ..   GOTO CES_IP
IF NOT .%2. == ..   GOTO CES_USER




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
   set /p suprascriu=  Sigur vrei sa suprascrii Kernelul de pe %ces_ip%  [y] ?
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
   echo put %sursa_nm%\vxWorks.nm vxWorks.nm>>c:\cpVxNm.txt
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
   ECHO utilizare:   cpVxNm   [CES_IP_Address]  [CES_user]  [CES_pass]
   ECHO           ( default:   IP: %ces_ip%   user: %ces_user%     pass: %ces_pass% )
   echo.
   @ECHO OFF
   GOTO END


:END