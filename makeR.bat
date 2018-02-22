@echo off

::Examples:
:: makeR rsp
:: makeR rsp HC
:: makeR rsp BIN DEBUG=00
:: makeR copytoaca_f 
:: makeR copytoaca_f DEBUG=0



SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION


call getTime.bat

set hw=ees
set target=BIN
set    debug=2
set /a speed=4
set /a webBuild=1
set /a logConsole=2
set versionName=B.Mar

set output_dir=V:\work_make
set output_file=%output_dir%\%hw%_dbg_%debug%.txt

IF     .%1. == .-h. GOTO HELP
IF     .%1. == ./?. GOTO HELP

IF NOT .%1. == .. set hw=%1
IF NOT .%2. == .. set target=%2


set /a token_start = 3
:GET_TARGET_OPTION
    FOR /f "tokens=%token_start%" %%i IN ("%*") DO  (
        set token=%%i
        ::echo token !token!
        IF NOT .. == .!token!. (
            ::update DEBUG variable
            IF "!token:~0,5!" == "DEBUG" (
                set  debug=!token:~6,2!
                rem echo debug_0 %debug%
            ) else (
            ::update SPEED variable
            IF "!token:~0,5!" == "SPEED" (
                set /a speed = !token:~6,2! 
                rem echo speed_0 %speed%
            ) else (
            ::update VERSION variable
            IF "!token:~0,7!" == "VERSION" (
                set versionName=!token:~8,6! 
                rem echo version %versionName%
            ) else (
            ::update WEB_BUILD variable
            IF "!token:~0,9!" == "WEB_BUILD" (
                set /a webBuild=!token:~10,1! 
                rem echo web %webBuild%
            ) else (
            ::update LOG_CONSOLE variable
            IF "!token:~0,11!" == "LOG_CONSOLE" (
                set /a logConsole=!token:~12,1! 
                rem echo log_0 %logConsole%
            ) else (
                set target_option=%target_option% %%i
            )
            )
            )
			)
            )

            set /a token_start = %token_start% + 1
            goto GET_TARGET_OPTION
        )
    )
::delete variables
set token=
set token_start=

::echo debug %debug%
::echo speed %speed%
::echo versionName %versionName%
::echo target_option "%target_option%"



IF .%target:~0,10%. == .copytoaca_. goto COPY

:STOP_WINDOWS_DEFENDER_WIN7
  ::service: svchost.exe -k secsvcs
  ::sc stop WinDefend 1>&0
  
:STOP_WINDOWS_COMPATIBILITY_WIN8
  ::net stop PcaSvc
  
::UNLOCK_FILES
  call LockHunter.exe /unlock /silent   D:\versiuni\bogmart_builds\p5_shine\%hw%\
  call LockHunter.exe /unlock /silent   D:\versiuni\bogmart_builds\p5_shine\%hw%\images\
  call LockHunter.exe /unlock /silent   D:\versiuni\bogmart_builds\p5_shine\%hw%_dbg_%debug%\
  call LockHunter.exe /unlock /silent   D:\versiuni\bogmart_builds\p5_shine\%hw%_dbg_%debug%\images\
  call LockHunter.exe /unlock /silent   D:\versiuni\bogmart_builds\p5_shine\%hw%_dbg_%debug%\images\%hw%.corefile.dump.txt
  call LockHunter.exe /unlock /silent   D:\versiuni\bogmart_builds\p5_shine\%hw%_dbg_%debug%\images\%hw%_corefile

:MAKE
  echo.
  echo  compile start time    %hour%:%min%:%sec%
  echo.
  set output_file="%output_dir%\%hw%_dbg_%debug%.txt"
  @echo on
  ::BIN == FP HC BSP
  ::start tail -f c:\work_make\%hw%_dbg_%debug%.txt
  make TARGET=%hw% %target% LOG_CONSOLE=%logConsole% SPEED=%speed% DEBUG=%debug% VERSION=%versionName% WEB_BUILD=%webBuild% %target_option% > %output_file% 2>&1
  @echo off
  echo.
  goto GET_ERROR

:COPY
  make TARGET=%hw% %target% DEBUG=%debug% %target_option%
  goto END


:GET_ERROR
  IF %ERRORLEVEL% NEQ 0  (
     rem sc start WinDefend 1>&0

     call getTimeEnd.bat
     echo.
	 echo !! ERROR !!
     ::tail -n 20 %output_file%
	 call makeColor.bat %output_file%
     echo.
	 echo !! ERROR !!
	 echo.
  ) else (
     :: BUILD OK
	 call getTimeEnd.bat
     echo.
     tail -n 70 %output_file%
     echo.
  )
  goto GET_TIME


:GET_TIME
  echo.
  echo  compile start time    %hour%:%min%:%sec%
  echo  compile end time      %hourEnd%:%minEnd%:%secEnd%

  @echo off
  call getTimeDiff.bat
  echo  compile time          %hourDif% hours  %minDif% mins   %secDif% secs
  echo.
  GOTO END
  
:HELP
  echo.
  ECHO usage: %0  [hw]  [target]    [options]
  ECHO        %0  rsp
  ECHO        %0  rsp    HC          DEBUG=0 SPEED=1
  ECHO        %0  rsp    copytoaca_f 
  ECHO        %0  rsp    copytoaca_f DEBUG=0
  ECHO   ( default:  %hw%    %target%         LOG_CONSOLE=%logConsole% SPEED=%speed% DEBUG=%debug% VERSION=%versionName%)
  ECHO     Note: 
  ECHO       Bitwise debug flags:  1: -DDEBUG
  ECHO                             2: -g -ggdb
  ECHO                             4: -O0
  ECHO                             8: no -Werror
  ECHO                             16: cUnit framework included  
  echo.
  @ECHO OFF
  GOTO END

:END
  ::sc start WinDefend 1>&0
  ::net start PcaSvc

ENDLOCAL

