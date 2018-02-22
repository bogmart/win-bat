@echo off

SETLOCAL

::cleanup some variables
set USERDNSDOMAIN=
set USERDOMAIN=
set LOGONSERVER=
set PSModulePath=

set windRiver_path=S:\WindRiver32
set shine_path=S:\bogmart_workbench\p5_smart_shine_v5.0
set hac_shared_path=S:\bogmart_workbench\p5_hac_shared_v5.0
set vxWorks_path=S:\bogmart_workbench\vxWorks_2010_v5.0

::call wrLinks.bat %windRiver_path% %vxWorks_path%

::call title p5_v5

FOR /F "tokens=1 delims=:" %%i in ("%shine_path%") do set shinePathDrive=%%i
%shinePathDrive%:
cd %shine_path%


if .%*. == .. goto DEFAULT

goto CUSTOM


::WinXP only (it has limited space for variables)
::call %windRiver_path%\wrenv.exe -p vxworks-6.9 PATH=C:\WINDOWS\system32;c:\windows\bat;c:\windows\bat\exe

:DEFAULT
call %windRiver_path%\wrenv.exe -p vxworks-6.9  SHINE_SHARED_DIR=%hac_shared_path%
goto END


:CUSTOM
echo custom
call %windRiver_path%\wrenv.exe -p vxworks-6.9  SHINE_SHARED_DIR=%hac_shared_path% cmd /K"%*"
goto END



:END
ENDLOCAL

