@ECHO OFF
::Examples:
::cpHac
::cpHac 10.20.10.3
::cpHac 10.20.10.3 m1000ge L3P

SETLOCAL

call getTime.bat

set tftp_serv_ip=10.0.0.1
set tftp_serv_test_file=content.romfs

set hac_ip=10.20.10.3
set hac_dir=m1000ge
set hac_hw=m1000ge
set hac_sw=L3P

set script_shell=script_%hac_ip%.cli


:: from "hac_ip", get destination network: ATTENTION network is always /16 (eg x.y.0.0)
::for /f "tokens=1,2 delims=." %%a in ("%hac_ip%") DO  set destNet=%%a.%%b.0.0
:: from "destNet", get local interface toward nexthop
::for /f "tokens=4" %%a in ('route print %destNet% ^| grep -E "Network Destination +Netmask +Gateway +Interface" -A 1 ^| grep %destNet%') DO  set tftp_serv_ip=%%a
for /f "tokens=2,3,4,5 delims=. " %%a in ('pathping -w 1 -q 1 -p 1 -h 1 -n -4 %hac_ip% ^| grep -m 1 -E "^ +0 +"') DO  set tftp_serv_ip=%%a.%%b.%%c.%%d


::TFTP server must have the home directory configured to 'abs_path'
::TFTP server must be local
set tftp_path=tftp://%tftp_serv_ip%

set abs_path=S:\bogmart_workbench\p4_shine\bsp


::hmFSUpdFileName
set oid_bin=.1.3.6.1.4.1.248.14.2.4.1.0

::hmFSConfFileName
set oid_config=.1.3.6.1.4.1.248.14.2.4.2.0

::hmFSAction
set oid_action=.1.3.6.1.4.1.248.14.2.4.6.0

::hmAction
set oid_reboot=.1.3.6.1.4.1.248.14.2.1.0

::hmFSActionResult
set oid_result=.1.3.6.1.4.1.248.14.2.4.8.0

::hmFSLastMessage
set oid_result_text=.1.3.6.1.4.1.248.14.2.4.11.0


IF     .%1. == ..   GOTO UPDATE_Q
IF     .%1. == .-h. GOTO HELP
IF     .%1. == ./?. GOTO HELP
IF     .%2. == ..   GOTO HAC_IP
IF NOT .%2. == ..   GOTO HAC_HW




:HAC_HW
   IF .%2. == ..        GOTO TFTP_SERVER_TEST
   set hac_hw=%2
   IF .%2. == .m4002.   set hac_dir=mach4
   IF .%2. == .m4002xg. set hac_dir=mach4xg
   IF .%2. == .pm.      set hac_dir=powermice
   IF .%2. == .m1000ge. set hac_dir=m1000ge
   IF .%2. == .m100.    set hac_dir=micers2ng
   IF .%2. == .rs.      set hac_dir=micers2ng
   IF .%2. == .mice.    set hac_dir=micers2ng

:HAC_SW
   IF .%3. == .. GOTO TFTP_SERVER_TEST
   set hac_sw=%3

:HAC_IP
   set hac_ip=%1
   :: get destination network: ATTENTION network is always /24 (eg x.y.z.0)
   ::for /f "tokens=1,2,3 delims=." %%a in ("%hac_ip%") DO  set destNet=%%a.%%b.%%c.0
   :: from "destNet", get local interface toward nexthop
   ::for /f "tokens=4" %%a in ('route print %destNet% ^| grep -E "Network Destination +Netmask +Gateway +Interface" -A 1 ^| grep %destNet%') DO  set tftp_serv_ip=%%a
   for /f "tokens=2,3,4,5 delims=. " %%a in ('pathping -w 1 -q 1 -p 1 -h 1 -n -4 %hac_ip% ^| grep -m 1 -E "^ +0 +"') DO  set tftp_serv_ip=%%a.%%b.%%c.%%d

:SET_PATH_BIN_FILE
   ::TFTP server must have the home directory configured to 'abs_path'
  ::TFTP server must be local
  set tftp_path=tftp://%tftp_serv_ip%

:SCRIPT_NAME   
   set script_shell=script_%hac_ip%.cli

GOTO TFTP_SERVER_TEST


:UPDATE_Q
   echo.
   set /p override=  Do you want override software on %hac_ip%  [y] ?
   if "%override%" == "y" GOTO CODE_LIMIT
   if "%override%" == "Y" GOTO CODE_LIMIT
   GOTO HELP


:TFTP_SERVER_TEST
   IF EXIST %TEMP%\%tftp_serv_test_file%    del /f %TEMP%\%tftp_serv_test_file%
   tftp -i %tftp_serv_ip% GET %hac_dir%/%tftp_serv_test_file%   %TEMP%\%tftp_serv_test_file% 2>&0 1>&0
   if NOT %ERRORLEVEL% == 0    GOTO ERROR_TFTP
   IF EXIST %TEMP%\%tftp_serv_test_file%    del /f %TEMP%\%tftp_serv_test_file%
   GOTO CODE_LIMIT


:CODE_LIMIT
   IF .%hac_hw%. == .m1000ge.  GOTO  CODE_LIMIT_m1000ge
   IF .%hac_hw%. == .m4002.    GOTO  CODE_LIMIT_m4002
   IF .%hac_hw%. == .m4002xg.  GOTO  CODE_LIMIT_m4002
   IF .%hac_hw%. == .pm.       GOTO  CODE_LIMIT_powerMice
   GOTO LOAD_BIN


:CODE_LIMIT_m1000ge
   :: create"script.cli" with the needed 'serviceshell'
   @ECHO OFF
   echo serviceshell hapiDebugInitCpuCodeLimiter(1) > %abs_path%\%script_shell%
   GOTO LOAD_SCRIPT


:CODE_LIMIT_m4002
   :: create"script.cli" with the needed 'serviceshell'
   @ECHO OFF
   echo serviceshell hmFlashInvalidateFile('/flash/os.bin') > %abs_path%\%script_shell%
   sleep 10
   GOTO LOAD_SCRIPT

:CODE_LIMIT_powerMice
   :: create"script.cli" with the needed 'serviceshell'
   @ECHO OFF
   echo serviceshell hmFlashInvalidateFile('/flash/powermice.bin') > %abs_path%\%script_shell%
   sleep 10
   GOTO LOAD_SCRIPT


:LOAD_SCRIPT
   IF EXIST %abs_path%\%script_shell% (
     snmpset -v 2c -c private  %hac_ip%  %oid_config% s %tftp_path%/%script_shell%      >nul 2>nul
     snmpset -v 2c -c private  %hac_ip%  %oid_action% i 5        >nul 2>nul
   )
   GOTO LOAD_BIN


:LOAD_BIN
   echo start update from  %tftp_path%/%hac_dir%/%hac_hw%%hac_sw%.bin
   snmpset -v 2c -c private  %hac_ip%  %oid_bin%    s %tftp_path%/%hac_dir%/%hac_hw%%hac_sw%.bin      >nul 2>nul
   snmpset -v 2c -c private  %hac_ip%  %oid_action% i 2       >nul 2>nul

   set start_update=0
   GOTO TEST_UPDATE


:TEST_UPDATE
    set result=0
    for /f "tokens=*" %%e in (
        'snmpget -c private -v 2c -O vq -t 10 %hac_ip% %oid_result%'
    ) do (
        set result=%%e
        )

    :: 1 -> other  ||  2 --> pending
	if %result% EQU 2 ( 
        sleep 5
        set start_update=1
        GOTO TEST_UPDATE
    ) else (
        :: bin update not started
	   	IF %start_update% NEQ 1 (
          sleep 1
          GOTO LOAD_BIN
        )
        ::  3 --> ok   || 4 --> failed
        GOTO GET_RESULT
	)

:GET_RESULT
    for /f "tokens=*" %%d in (
        'snmpget -c private -v 2c -O vq %hac_ip% %oid_result_text%'
    ) do (
        set result_text=%%d
        )
    echo.
    echo result_text %result_text%

:TEST_REBOOT
    if %result% EQU 3 (
        echo.
        echo  rebooting...
        snmpset -v 2c -c private  %hac_ip%  %oid_reboot% i 2    >nul 2>nul
        GOTO GET_TIME
    ) else (
	    echo.
	    echo re-transfer file...
	    GOTO LOAD_SCRIPT
	)



:GET_TIME
    call getTimeEnd.bat

    echo.
    echo  update start time    %hour%:%min%:%sec%
    echo  update end time      %hourEnd%:%minEnd%:%secEnd%

    @echo off
    call getTimeDiff.bat

    echo  ~ %hac_hw%%hac_sw% ~  update time  %hourDif% hours  %minDif% mins   %secDif% secs
    echo.
    GOTO END


:HELP
   echo.
   ECHO usage:     %0  [HAC_IP_Address] [HAC_HW] [HAC_SW]
   ECHO       ( default:   IP: %hac_ip%   %hac_hw%  %hac_sw%)
   echo.
   @ECHO OFF
   GOTO END

:ERROR_TFTP
  echo ERROR: TFTP server not available!
  GOTO END

:END
  IF EXIST %abs_path%\%script_shell% (
	::clean script file
    del %abs_path%\%script_shell%
  )

ENDLOCAL