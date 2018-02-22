@echo off


SETLOCAL 

set destIP=%1
set regIpExpr=[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+


for /f "tokens=1,2 delims=." %%a in ("%destIP%") DO  set destNet=%%a.%%b.0.0
echo destNet=%destNet%

::route print %destNet% | awk "/%regIpExpr% +%regIpExpr%/ {ip=$4 }; END { print ip }"

::for /f "tokens=*" %%a in ('route print %destNet% ^| awk "/%regIpExpr% +%regIpExpr%/ {ip=$4 }; END { print ip }"') do set ifNext=%%a
for /f "tokens=4" %%a in ('route print %destNet% ^|find "%destNet%"') DO  set localIp=%%a
   
echo ifNext=%ifNext%

ENDLOCAL
