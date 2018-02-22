@echo off

::
:: lines containing strings "error:" or "java.lang.RuntimeException:" are highlighted
:: color is dependent on ANSI character support
::
:: note: escape character is \x1b
:: usage: makeColor [log_file]


::SETLOCAL
SETLOCAL EnableDelayedExpansion

if .%1. == ..          GOTO ALL_LOGS
if .%1. == .TAIL_ONLY. GOTO ALL_LOGS


:INPUT_LOGS
set logs=%1
GOTO FILTER_SET_for_LESS

:ALL_LOGS
set logs=

set logs=%logs% V:\work_make\msp3a_MR_dbg_00.txt
set logs=%logs% V:\work_make\msp3a_MR_dbg_0.txt
set logs=%logs% V:\work_make\msp3a_MR_dbg_2.txt
set logs=%logs% V:\work_make\msp3a_MR_dbg_6.txt

set logs=%logs% V:\work_make\rsp3s_BR_dbg_00.txt
set logs=%logs% V:\work_make\rsp3s_BR_dbg_0.txt
set logs=%logs% V:\work_make\rsp3s_BR_dbg_2.txt
set logs=%logs% V:\work_make\rsp3s_BR_dbg_6.txt

set logs=%logs% V:\work_make\os23s_BR_dbg_00.txt
set logs=%logs% V:\work_make\os23s_BR_dbg_0.txt
set logs=%logs% V:\work_make\os23s_BR_dbg_2.txt
set logs=%logs% V:\work_make\os23s_BR_dbg_6.txt

set logs=%logs% V:\work_make\rspe3s_BR_dbg_00.txt
set logs=%logs% V:\work_make\rspe3s_BR_dbg_0.txt
set logs=%logs% V:\work_make\rspe3s_BR_dbg_2.txt
set logs=%logs% V:\work_make\rspe3s_BR_dbg_6.txt

set logs=%logs% V:\work_make\ees_dbg_00.txt
set logs=%logs% V:\work_make\ees_dbg_0.txt
set logs=%logs% V:\work_make\ees_dbg_2.txt
set logs=%logs% V:\work_make\ees_dbg_6.txt

GOTO FILTER_SET_for_SED

:FILTER_SET_for_SED
:: filter syntax for 'sed' is:   .*error:.*\|.*RuntimeException.*
set filter=.*error:.*
set filter=!filter!^^^\^^^|.*make.*Error.*
set filter=!filter!^^^\^^^|.*undefined reference to.*
set filter=!filter!^^^\^^^|.*unknown type:.*
set filter=!filter!^^^\^^^|.*RuntimeException.*
set filter=!filter!^^^\^^^|.*Caused by:.*
set filter=!filter!^^^\^^^|.*MIBLoader.*
set filter=!filter!^^^\^^^|.*MibDefGenerator.*
::echo filter_sed !filter!
GOTO TAIL

:FILTER_SET_for_LESS
:: filter syntax for 'less' is:   .*error:.*^|.*RuntimeException.*
set filter=.*error:.*
set filter=!filter!^^^^^|.*make.*Err.*
set filter=!filter!^^^^^|.*"reference to".*
set filter=!filter!^^^^^|.*ntimeExc.*
set filter=!filter!^^^^^|.*"sed by:".*
set filter=!filter!^^^^^|.*IBLoa.*
set filter=!filter!^^^^^|.*bDefGe.*
set filter=.*error:.*^|.*make.*Err.*^|.*"reference to".*^|.*ntimeExc.*^|.*"sed by:".*^|.*IBLoa.*^|.*bDefGe.*
::echo filter_less !filter!
GOTO LESS


:TAIL
if .%1. == .TAIL_ONLY. (
      tail -F %logs% 
  ) else (
      tail -F %logs% | sed "s/\(!filter!\)/\x1b[1;41m\1\x1b[0m/"
  )
goto END

:LESS
::Console2 has a bug, the solution is using the option "-X"
less +F -X +/!filter! %logs%
goto END


:END
ENDLOCAL