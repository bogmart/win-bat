@ECHO OFF

IF .%1.          == ./?.  GOTO HELP
IF .%1.          == .-h.  GOTO HELP

SETLOCAL

call getTime.bat
call getDate.bat

set hac_ip=10.0.0.2
IF NOT .%1. == ..  set hac_ip=%1

set tmpFile=temp_%hac_ip%.html
set outFile=DevelLog_%hac_ip%-%year%.%month%.%day%-%hour%.%min%.%sec%.html
set outDir=%temp%

set user=admin
set pass=private


set unscramble_tool=C:\"Program File Portables"\net\hirschmann\unscramble.exe
::set browser="C:\Program Files\Internet Explorer\iexplore.exe"
set browser="C:\Program File Portables\FirefoxPortable\FirefoxPortable.exe"

for /f "tokens=2" %%a in ('base64 -e %user%:%pass%') DO  set base64auth=%%a

::call wget --http-user=%user% --http-password=%pass% http://%hac_ip%/download.html?filetype=supportinfo -O %outDir%\%tmpFile% 
call wget  --header="Authorization: Basic %base64auth%"  http://%hac_ip%/download.html?filetype=supportinfo -O %outDir%\%tmpFile% 

call %unscramble_tool%  %outDir%\%tmpFile%  %outDir%\%outFile%

IF EXIST %outDir%\%tmpFile% del %outDir%\%tmpFile%

%browser% file:///%outDir%\%outFile%


GOTO END

:HELP
   echo.
   ECHO usage:     %0  [HAC_IP_Address]
   ECHO       ( default:   IP: %hac_ip% )
   echo.
   @ECHO OFF
   GOTO END

:END
ENDLOCAL
