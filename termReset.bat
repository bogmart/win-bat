@ECHO OFF
::Examples:
::termReset 10.2.36.243  1
::termReset HAC_04
::termReset all

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

IF     .%1. == .-h. GOTO HELP
IF     .%1. == ./?. GOTO HELP
IF     .%1. == ..   GOTO HELP

set target=%1
call :toupper target


IF     .%target%. == .ALL. (
                       set isAll=1
					   GOTO   RESET_ALL
					  )
IF     .%target%. == .HAC_04.   GOTO   RESET_HAC_04
IF     .%target%. == .HAC_05.   GOTO   RESET_HAC_05
IF     .%target%. == .HAC_06.   GOTO   RESET_HAC_06
IF     .%target%. == .HAC_07.   GOTO   RESET_HAC_07
IF     .%target%. == .HAC_25.   GOTO   RESET_HAC_25
IF     .%target%. == .MSP_20.   GOTO   RESET_MSP_20
IF     .%target%. == .MSP_21.   GOTO   RESET_MSP_21
IF     .%target%. == .MSP_22.   GOTO   RESET_MSP_22
IF     .%target%. == .RSPE_23.  GOTO   RESET_RSPE_23
IF     .%target%. == .RSP_25.   GOTO   RESET_RSP_25
IF NOT .%2.       == ..         GOTO   RESET_TERMINAL_IP_PORT

:RESET_ALL

:RESET_HAC_04
  set term_ip=10.2.36.241
  set term_port=9
  call :RESET_PORT
  if NOT .%isAll%. == .1. GOTO END
  
:RESET_HAC_05
  set term_ip=10.2.36.241
  set term_port=1
  call :RESET_PORT
  if NOT .%isAll%. == .1. GOTO END
  
:RESET_HAC_06
  set term_ip=10.2.36.241
  set term_port=14
  call :RESET_PORT
  if NOT .%isAll%. == .1. GOTO END
  
:RESET_HAC_07
  set term_ip=10.2.36.241
  set term_port=8
  call :RESET_PORT
  if NOT .%isAll%. == .1. GOTO END
  
:RESET_HAC_13
  set term_ip=10.2.36.243
  set term_port=12
  call :RESET_PORT
  if NOT .%isAll%. == .1. GOTO END

:RESET_HAC_25
  set term_ip=10.2.36.241
  set term_port=12
  call :RESET_PORT
  if NOT .%isAll%. == .1. GOTO END

:RESET_MSP_20
:RESET_RSP_25
  set term_ip=10.2.36.238
  set term_port=14
  call :RESET_PORT
  if NOT .%isAll%. == .1. GOTO END
  
:RESET_MSP_21
  set term_ip=10.2.36.238
  set term_port=15
  call :RESET_PORT
  if NOT .%isAll%. == .1. GOTO END
  
:RESET_MSP_22
:RESET_RSPE_23
  set term_ip=10.2.36.238
  set term_port=16
  call :RESET_PORT

::goto END after last port !
GOTO END

:RESET_TERMINAL_IP_PORT
  set term_ip=%1
  set term_port=%2
  GOTO RESET_PORT
   
:RESET_PORT
  python D:\Hirschmann\_mele\scripts\terminalReset.py %term_ip% %term_port%
  GOTO END

:HELP
   echo.
   ECHO usage:     %0  [terminal_server_IP_Address] [port]
   ECHO example:
   ECHO            %0   10.2.36.243                1
   ECHO            %0   HAC_04 
   ECHO            %0   MSP_22
   ECHO            %0   all
   echo.
   @ECHO OFF
   GOTO END

:toupper
   for %%L IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO SET %1=!%1:%%L=%%L!
   goto :EOF

:tolower
   for %%L IN (a b c d e f g h i j k l m n o p q r s t u v w x y z) DO SET %1=!%1:%%L=%%L!
   goto :EOF

:END


ENDLOCAL