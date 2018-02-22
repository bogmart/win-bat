@echo off
SETLOCAL


set target=m1000geL3P
IF NOT .%1. == ..  set target=%1

:TEST
   echo.
   set /p cleanYN=  Are you sure you want to delete 'EtherIp + hiperring + IEC + Profinet + ptp + ptp2 + srm' for  %target%  [y] ?
   echo.
   if "%cleanYN%" == "y" GOTO CLEAN
   if "%cleanYN%" == "Y" GOTO CLEAN
   GOTO END

:CLEAN


:andl
   pushd .
   cd fastpath\andl
   if NOT %ERRORLEVEL% EQU 0 GOTO END
   echo "clean andl"
   call cleanPPC.bat %target% 
   popd

:EtherNet_IP
   pushd .
   cd hirschmann\EtherNet_IP
   if NOT %ERRORLEVEL% EQU 0 GOTO END
   echo "clean EtherNet_IP"
   call cleanPPC.bat %target%  y
   popd

:hiperring
   pushd .
   cd hirschmann\hiperring
   if NOT %ERRORLEVEL% EQU 0 GOTO END
   echo "clean hiperring"
   call cleanPPC.bat %target%  y
   popd

:iec61850
   pushd .
   cd hirschmann\iec61850
   if NOT %ERRORLEVEL% EQU 0 GOTO END
   echo "clean iec61850"
   call cleanPPC.bat %target%  y
   popd

:ProfinetIO
   pushd .
   cd hirschmann\ProfinetIO
   if NOT %ERRORLEVEL% EQU 0 GOTO END
   echo "clean ProfinetIO"
   call cleanPPC.bat %target%  y
   popd

:ptp
   pushd .
   cd hirschmann\ptp
   if NOT %ERRORLEVEL% EQU 0 GOTO END
   echo "clean ptp"
   call cleanPPC.bat %target%  y
   popd

:ptp2
   pushd .
   cd hirschmann\ptp2
   if NOT %ERRORLEVEL% EQU 0 GOTO END
   echo "clean ptp2"
   call cleanPPC.bat %target%  y
   popd

:srm
   pushd .
   cd hirschmann\srm
   if NOT %ERRORLEVEL% EQU 0 GOTO END
   echo "clean srm"
   call cleanPPC.bat %target%  y
   popd
   goto END

:END
ENDLOCAL