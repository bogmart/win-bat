@ECHO OFF

set destinatie_cap=D:\OpenPcap
set cale_ethereal=c:\Progra~1\wireshark\wireshark.exe

set ces_ip=10.20.30.25
set ces_user=a
set ces_pass=a

set explorer=

IF     .%1. == .. GOTO ERROR
IF     .%2. == .. GOTO CES_USER
IF NOT .%2. == .. GOTO CES_IP



:CES_IP
set ces_ip=%2

:CES_USER
IF .%3. == .. GOTO CES_PASS
set ces_user=%3

:CES_PASS
IF .%4. == .. GOTO SET_PCAP
set ces_pass=%4


:SET_PCAP
set capura_ces=%1


::------------------------------------------------------------------------------------
:: creez fiserul "pcap_get.txt" cu comenzile necesare pt a downloada captura
@ECHO OFF
echo %ces_user%>c:\pcap_get.txt
echo %ces_pass%>>c:\pcap_get.txt
echo bin>>c:\pcap_get.txt
echo lcd %destinatie_cap%>>c:\pcap_get.txt
echo get %capura_ces%>>c:\pcap_get.txt
echo close>>c:\pcap_get.txt
echo bye>>c:\pcap_get.txt


::------------------------------------------------------------------------------------
:: download-ez captura de pe CES si o pun in calea "destinatie_cap"
ftp -s:c:\pcap_get.txt %ces_ip%

del c:\pcap_get.txt

::------------------------------------------------------------------------------------
:: testez daca fisierul luat are dimensiunea de 0 octeti
:: (in cazul in care fisierul nu exista pe CES, se creaza un fisier gol!!!)
for /F %%A in ("%destinatie_cap%\%capura_ces%")   DO IF %%~zA equ 0    del %destinatie_cap%\%capura_ces%

IF NOT EXIST "%destinatie_cap%\%capura_ces%"      GOTO  FISIER_INEXISTENT



::------------------------------------------------------------------------------------
@echo.
@echo  !! Introduceti parola pentru captura "%capura_ces%" !!
call   %destinatie_cap%\openpcap.exe    %destinatie_cap%\%capura_ces%      %destinatie_cap%\%capura_ces%.cap
@echo.


IF %ERRORLEVEL%==-1  GOTO END


del    %destinatie_cap%\%capura_ces%

start  %cale_ethereal%  %destinatie_cap%\%capura_ces%.cap



::------------------------------------------------------------------------------------
echo.
set /p explorer=  Deschid directorul destinatie [y] ? 
if "%explorer%" == "y" explorer %destinatie_cap%
if "%explorer%" == "Y" explorer %destinatie_cap%

GOTO END


::------------------------------------------------------------------------------------
:FISIER_INEXISTENT
echo.
ECHO  !! Fisierul "%capura_ces%" nu exista pe CES !!
echo.
GOTO END

::------------------------------------------------------------------------------------
:ERROR
echo.
ECHO utilizare:   pcap  nume_captura  [CES_IP_Address]  [CES_user]  [CES_pass]
ECHO                     ( default:   IP: %ces_ip%   user: %ces_user%     pass: %ces_pass% )
echo.
@ECHO OFF
GOTO END


::------------------------------------------------------------------------------------
:END

