@echo off
SETLOCAL

set ip=%1

for /f "tokens=*" %%A in ('ping -n 1  %ip% ^|find "Pinging %ip%"') Do echo %%A 

:START
::FOR /f "tokens=3 delims= " %%A IN ('ping -n 1 -w 1000 %ip% ^|find "Reply from" ^| find /V "%ip%"') DO  echo %date% %time% - recv resp from %%A
FOR /f "tokens=3 delims= " %%A IN ('ping -n 1 -w 1000 %ip% ^|find "Request timed out"') DO  echo %date% %time% - timeout

sleep 1
::choice /c x /t 1 /d x >nul

goto START 

:END
ENDLOCAL