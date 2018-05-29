@echo off

::Examples:
:: makeH
:: makeH m1000geL3P
:: makeH m1000geL3P DEBUG=2


SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

call getTime.bat

set hw=m1000geL3P
set target=BIN
set  debug=2
set /a log=1
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
			::update LOG_CONSOLE variable
			IF "!token:~0,11!" == "LOG_CONSOLE" (
                set /a log = !token:~12,2! 
                rem echo speed_0 %log%
            )
			::update VERSION variable
			IF "!token:~0,7!" == "VERSION" (
                set versionName=!token:~8,6! 
                rem echo version %versionName%
            ) else (
                set target_option=%target_option% %%i
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
::echo log %log%
::echo versionName %versionName%
::echo target_option "%target_option%"


IF .%target:~0,10%. == .copytoaca_. goto COPY

:STOP_WINDOWS_DEFENDER
  ::service: svchost.exe -k secsvcs
  ::sc stop WinDefend 1>&0

:MAKE
  echo.
  echo  compile start time    %hour%:%min%:%sec%
  echo.
  set output_file="%output_dir%\%hw%_dbg_%debug%.txt"
  @echo on
  ::BIN == FP HC BSP
  ::start tail -f c:\work_make\%hw%_dbg_%debug%.txt
  make TARGET=%hw% %target% DEBUG=%debug% VERSION=%versionName% LOG_CONSOLE=%log% FAST_FIND=1 %target_option% > %output_file% 2>&1
  @echo off
  echo.
  goto GET_ERROR

:COPY
  make TARGET=%hw% %target% DEBUG=%debug% %target_option%
  goto END


:GET_ERROR
  IF %ERRORLEVEL% NEQ 0  (
     sc start WinDefend 1>&0

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
  ECHO usage: %0  [hw]          [target]    [options]
  ECHO        %0  m100L2P
  ECHO        %0  m100L2P       HC          DEBUG=0
  ECHO        %0  m100L2P       copytoaca_f 
  ECHO        %0  m100L2P       copytoaca_f DEBUG=1
  ECHO   ( default:  %hw%    %target%         DEBUG=%debug%  VERSION=%versionName%  LOG_CONSOLE=%log%  FAST_FIND=1)
  echo.
  @ECHO OFF
  GOTO END

:END
  ::sc start WinDefend 1>&0

ENDLOCAL

