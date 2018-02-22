@ECHO OFF

set sursa_jar=s:\malibu\java\bin

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
   set /p suprascriu=  Sigur vrei sa suprascrii JAR-urile de pe %ces_ip%  [y] ?
   if "%suprascriu%" == "y" GOTO SET_PUT_TXT
   if "%suprascriu%" == "Y" GOTO SET_PUT_TXT

   GOTO HELP




:SET_PUT_TXT
   :: creez fiserul "cpJar.txt" cu comenzile necesare pt a pune JAR-urile pe CES
   @ECHO OFF
   echo user %ces_user%>c:\cpJar.txt
   echo %ces_pass%>>c:\cpJar.txt
   echo bin>>c:\cpJar.txt

   echo cd /SYSTEM/manage/java/CSIF/>>c:\cpJar.txt
   echo put %sursa_jar%\csf.jar csf.jar>>c:\cpJar.txt

   echo cd ..>>c:\cpJar.txt
   echo put %sursa_jar%\JChart\graph.jar   graph.jar>>c:\cpJar.txt
   echo put %sursa_jar%\JChart\jcchart.jar jcchart.jar>>c:\cpJar.txt

   echo close>>c:\cpJar.txt
   echo bye>>c:\cpJar.txt

   GOTO PUT_JAR



:PUT_JAR
   ftp -n -s:C:\cpJar.txt %ces_ip%

   del c:\cpJar.txt
   GOTO END



:HELP
   echo.
   ECHO utilizare:   cpJar  [CES_IP_Address]  [CES_user]  [CES_pass]
   ECHO           ( default:   IP: %ces_ip%   user: %ces_user%     pass: %ces_pass% )
   echo.
   @ECHO OFF
   GOTO END


:END