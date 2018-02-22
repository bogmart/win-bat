@echo off

SETLOCAL  ENABLEDELAYEDEXPANSION

set pathBaseFrom=v:\target_p5
set pathBaseTo=d:\RAM_drive_temp

call getTime.bat

::@echo on
::cp  -u  -r  --preserve=timestamps  %pathBaseFrom%  %pathBaseTo%\

for /d %%A in (%pathBaseFrom%\*) do (
  for /d %%B in ("%%A\*") do (
    for /d %%C in ("%%B\*") do (
      set pathCopySrc=%%C
      set pathCopyDst=!pathCopySrc:~3!
      echo copy  !pathCopySrc!  to   %pathBaseTo%\!pathCopyDst!
      call robocopy !pathCopySrc!  %pathBaseTo%\!pathCopyDst! /W:1 /R:3 /DCOPY:DT /COPY:DT /S /MT:16 /NFL /NDL /NJH /NJS /XO /PURGE
      )
    )
  )
  
for %%A in (%pathBaseFrom%\web\*) do (
  set pathCopySrc=%%A
  set pathCopyDst=!pathCopySrc:~3!
  FOR %%i IN ("%pathBaseTo%\!pathCopyDst!") DO (
    set webDir=%%~di%%~pi
    if not exist !webDir! (
      mkdir !webDir!
    )
  )
  echo copy  !pathCopySrc!  to   %pathBaseTo%\!pathCopyDst!
  cp  -u  -r  --preserve=timestamps !pathCopySrc!  %pathBaseTo%\!pathCopyDst!
  )


  
@echo off
call getTimeEnd.bat
call getTimeDiff.bat

echo.
echo save time:   %hourDif% hours  %minDif% mins   %secDif% secs

timeout /t 7200


:END
  ENDLOCAL