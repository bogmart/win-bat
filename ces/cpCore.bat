@ECHO OFF

set sterg_core=

set ces_ip=10.20.30.25
set ces_user=a
set ces_pass=a


set dst_core=S:\malibu\server\kernel\target\config\pc486

:SET_DRIVE
   FOR /F "eol=. tokens=1 delims=\" %%i in ("%dst_core%") do  set serv_drive=%%i


IF     .%1. == ..   GOTO SIGUR_VREI
IF     .%1. == .-h. GOTO HELP
IF     .%2. == ..   GOTO CES_IP
IF     .%3. == ..   GOTO IP_VERSION
IF NOT .%4. == ..   GOTO CES_IP_USER_VERSION
IF NOT .%2. == ..   GOTO CES_IP_USER_OR_VERSION


:CES_IP_USER_OR_VERSION
   IF .%3. == .. GOTO IP_VERSION

:CES_USER
   set ces_ip=%1
   set ces_user=%2
   set ces_pass=%3
   GOTO CREATE_GET_FILE


:CES_IP
   set ces_ip=%1
   GOTO CREATE_GET_FILE


:CES_IP_USER_VERSION
   set ces_ip=%1
   set ces_user=%2
   set ces_pass=%3
   set serv_ver=%4
   GOTO CREATE_GET_FILE


:IP_VERSION
   set ces_ip=%1
   set serv_ver=%2
   GOTO CREATE_GET_FILE


:SIGUR_VREI
   echo.
   set /p suprascriu=  Sigur vrei sa iei core-ul de pe %ces_ip%  [y] ?
   if "%suprascriu%" == "y" GOTO CREATE_GET_FILE
   if "%suprascriu%" == "Y" GOTO CREATE_GET_FILE

   GOTO HELP


:CREATE_GET_FILE
   :: creez fiserul "cpCore.txt" cu comenzile necesare pt a lua lista de core-uri de pe CES
   @ECHO OFF
   echo user %ces_user%>c:\cpCore.txt
   echo %ces_pass%>>c:\cpCore.txt
   echo bin>>c:\cpCore.txt
   echo cd SYSTEM/core>>c:\cpCore.txt
   echo ls *.* c:\core_ls.txt>>c:\cpCore.txt
   echo close>>c:\cpCore.txt
   echo bye>>c:\cpCore.txt


:GET_CORE_LIST
   ::obtin lista de coredump-uri de pe ces in fisierul "core_ls.txt"
   ftp -n -s:C:\cpCore.txt %ces_ip%

   del c:\cpCore.txt


 
:: initializez contorul "crt_core"
:: parsez fisierul "core_ls.txt" si salvez in voua variabile "core0" si "core1" versiunile existente
set /A crt_core=0
FOR /F "eol=. tokens=2 delims=E." %%i in (c:\core_ls.txt) do   call cpCore_set.bat %%i




:: determin care este ultimul core (cel mai mare numar)
IF %crt_core% EQU 1      goto CORE_UNIC
IF %crt_core% EQU 2      goto CORE_MULTIPLE

:NICI_UN_CORE
   ECHO.
   ECHO Nu exista nici un core in %ces_ip%  \System\core
   goto END


:CORE_UNIC
   set core=CORE%core0%
   goto GET_CORE

:CORE_MULTIPLE
   IF %core0% LSS %core1%   set core=CORE%core1%
   IF %core0% GTR %core1%   set core=CORE%core0%
   goto GET_CORE


:GET_CORE
   :: creez fiserul "core_get.txt" cu comenzile necesare pt a downloada core-ul
   @ECHO OFF
   echo %ces_user%>c:\core_get.txt
   echo %ces_pass%>>c:\core_get.txt
   echo bin>>c:\core_get.txt
   echo cd SYSTEM/core>>c:\core_get.txt
   echo lcd %dst_core%>>c:\core_get.txt
   echo get %core%.GZ>>c:\core_get.txt
   echo close>>c:\core_get.txt
   echo bye>>c:\core_get.txt



:: download-ez core-ul de pe CES si-l pun in calea potrivita (S:\malibu\server\kernel\target\config\pc486)
ftp -s:c:\core_get.txt %ces_ip%




:: dezarhivez core-ul
   %serv_drive%
   cd %dst_core%
   7z.exe e %core%.GZ


:ERASE
   del c:\core_ls.txt
   del c:\core_get.txt
   del %core%.GZ



:GDB
   ::daca nu este deja o versiune setata
   if .%serv_ver%. == ..  set /p serv_ver= Insert server version= 

   ::validez versiunea introdusa
   call serverVer.bat %serv_ver%

   ::apelez gdb-ul daca versiunea este valida
   IF not .%serv_ver_eroare%. == .-1.    call gdbb %serv_ver%



:TEST_DEL_CORE
   set /p sterg_core=  Sterg core-ul dezarhivat [y] ? 
   if "%sterg_core%" == "y" del %core%
   if "%sterg_core%" == "Y" del %core%

   GOTO END




:HELP
   ECHO utilizare:   
   ECHO    cpCore
   ECHO    cpCore  IP_Address
   ECHO    cpCore  IP_Address  user  pass
   ECHO    cpCore  IP_Address  user  pass  Versiune_Soft
   ECHO    cpCore  IP_Address              Versiune_Soft
   ECHO.
   ECHO (default:  IP: %ces_ip%   user: %ces_user%     pass: %ces_pass%   ver: %serv_ver%)
   ECHO.
   @ECHO OFF
   GOTO END


:END