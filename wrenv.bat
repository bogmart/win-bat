@echo off

SETLOCAL

::fix P4 issue with long user names
set USERNAME=BMartin

set windRiver_path=S:\WindRiver32
set shine_path=S:\bogmart_workbench\p4_shine
set vxWorks_path=S:\bogmart_workbench\vxWorks_PNE

::call wrLinks.bat %windRiver_path% %vxWorks_path%

call title p4_shine

FOR /F "tokens=1 delims=:" %%i in ("%shine_path%") do set shinePathDrive=%%i
%shinePathDrive%:
cd %shine_path%

if .%*. == .. goto DEFAULT

goto CUSTOM



:DEFAULT
call %windRiver_path%\wrenv.exe -I -e -f bat -p vxworks-6.4 -i S:\WindRiver32\install.properties
goto end



:CUSTOM
echo custom
call %windRiver_path%\wrenv.exe -I -e -f bat -p vxworks-6.4 -i S:\WindRiver32\install.properties cmd /K"%*"
goto end



:END
ENDLOCAL

