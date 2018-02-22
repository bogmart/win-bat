@echo off

SETLOCAL

::cleanup some variables
set USERDNSDOMAIN=
set USERDOMAIN=
set LOGONSERVER=
set PSModulePath=

set windRiver_path=S:\WindRiver32
::IF NOT EXIST "W:\" subst W: %windRiver_path%

set shine_path=S:\bogmart_workbench\p5_smart_shine
set vxWorks_path=S:\bogmart_workbench\vxWorks6

::call wrLinks.bat %windRiver_path% %vxWorks_path%

call title p5

FOR /F "tokens=1 delims=:" %%i in ("%shine_path%") do set shinePathDrive=%%i
%shinePathDrive%:
cd %shine_path%


echo set COMP_IPNET2_SUBCOMP=  
echo set WIND_RSS_CHANNELS=


if .%*. == .. goto DEFAULT

goto CUSTOM



:DEFAULT
::call %windRiver_path%\wrenv.exe -p vxworks-6.9 PATH=C:\WINDOWS\system32;c:\windows\bat;c:\windows\bat\exe
call %windRiver_path%\wrenv.exe -p vxworks-6.9
goto END


:CUSTOM
echo custom
call W:\wrenv.exe -p vxworks-6.9 PATH=C:\WINDOWS\system32;c:\windows\bat;c:\windows\bat\exe cmd /K"%*"
goto END



:END
ENDLOCAL


