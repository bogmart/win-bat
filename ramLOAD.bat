@echo off

SETLOCAL

set pathBaseFrom=d:\RAM_drive_temp
set pathBaseTo=v:

::CLS

:MENU
ECHO.
ECHO ...............................................
ECHO PRESS m,i,a.. to select your task, or q to EXIT.
ECHO ...............................................
ECHO.
ECHO 0   - all
ECHO m   - mpc8314 - all
ECHO ma  - mpc8314 - hurricane_a
ECHO mh  - mpc8314 - hurricane
ECHO ms  - mpc8314 - stardust
ECHO i   - imx25   - all
ECHO il  - imx25   - lotus
ECHO it  - imx25   - thunderbolt
ECHO a   - am57xx  - all
ECHO ae  - am57xx  - enduro
ECHO ah  - am57xx  - helix4
ECHO q - EXIT
ECHO.

SET /P M=Type 0,m,i,.. or q then press ENTER:

IF .%M%.==.0. (
  set pathCopySrc=target_p5
  set pathCopyDst=
  )
IF .%M%.==.m. (
  set pathCopySrc=target_p5\mpc8314
  set pathCopyDst=target_p5
  )
IF .%M%.==.ma. (
  set pathCopySrc=target_p5\mpc8314\hurricane_a
  set pathCopyDst=target_p5\mpc8314
  )
IF .%M%.==.mh. (
  set pathCopySrc=target_p5\mpc8314\hurricane
  set pathCopyDst=target_p5\mpc8314
  )
IF .%M%.==.ms. (
  set pathCopySrc=target_p5\mpc8314\stardust
  set pathCopyDst=target_p5\mpc8314
  )
IF .%M%.==.i. (
  set pathCopySrc=target_p5\imx25
  set pathCopyDst=target_p5
  )
IF .%M%.==.il. (
  set pathCopySrc=target_p5\imx25\lotus
  set pathCopyDst=target_p5\imx25
  )
IF .%M%.==.it. (
  set pathCopySrc=target_p5\imx25\thunderbolt
  set pathCopyDst=target_p5\imx25
  )
IF .%M%.==.a. (
  set pathCopySrc=target_p5\am57xx
  set pathCopyDst=target_p5
  )
IF .%M%.==.ae. (
  set pathCopySrc=target_p5\am57xx\enduro
  set pathCopyDst=target_p5\am57xx
  )
IF .%M%.==.ah. (
  set pathCopySrc=target_p5\am57xx\helix4
  set pathCopyDst=target_p5\am57xx
  )

IF .%M%.==.q.   GOTO END

:START
call getTime.bat

@echo on
::mkdir %pathBaseTo%\%pathCopySrc%
::cp -u  -r  --preserve=timestamps  %pathBaseFrom%\%pathCopySrc%  %pathBaseTo%\%pathCopyDst%
robocopy %pathBaseFrom%\%pathCopySrc%  %pathBaseTo%\%pathCopySrc% /W:1 /R:3 /DCOPY:DT /COPY:DT /S /MT:16 /NFL /NDL /NJH /XO 
::copy web HTML5
robocopy %pathBaseFrom%\target_p5\web  %pathBaseTo%\target_p5\web /W:1 /R:3 /DCOPY:DT /COPY:DT /S /MT:16 /NFL /NDL /NJH /XO


@echo off
call getTimeEnd.bat
call getTimeDiff.bat

echo.
echo LOAD time:   %hourDif% hours  %minDif% mins   %secDif% secs

:STOP
GOTO MENU
sleep 6000


:END
  ENDLOCAL