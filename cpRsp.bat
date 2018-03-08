@ECHO OFF

::Examples:
::cpRsp
::cpRsp 10.0.0.1
::cpRsp 10.0.0.1 ees
::cpRsp 10.0.0.2 rsp
::cpRsp 10.0.0.4 msp3a_MR   p5_shine_v6 
::cpRsp 10.0.0.5 rspe3s_BR  p5_shine      00

SETLOCAL

set /a sleep_time = 0

call getTime.bat

set hac_ip=10.0.0.1
:: from "hac_ip", get destination network: ATTENTION network is always /16 (eg x.y.0.0)
::for /f "tokens=1,2 delims=." %%a in ("%hac_ip%") DO  set destNet=%%a.%%b.0.0
:: from "destNet", get local interface toward nexthop
::for /f "tokens=4" %%a in ('route print %destNet% ^| grep -E "Network Destination +Netmask +Gateway +Interface" -A 1 ^| grep %destNet%') DO  set serv_ip=%%a
for /f "tokens=2,3,4,5 delims=. " %%a in ('pathping -w 1 -q 1 -p 1 -h 1 -n -4 %hac_ip% ^| grep -m 1 -E "^ +0 +"') DO  set serv_ip=%%a.%%b.%%c.%%d

::set serv_ip=10.0.0.7
::set serv_ip=11.126.26.7
set user_name=user
set user_pass=pass

::default EES
set hac_hw=ees
set hac_sw=ees

::default HEAD
set hac_sw_ver=bogmart_builds/p5_shine

::FTP/TFTP/SFTP server must have the home directory configured to shine's parent
set path_bin_file=ftp://%serv_ip%/%hac_sw_ver%/%hac_hw%/images/%hac_hw%.bin



::hm2FMServerUserName
set oid_user_name=.1.3.6.1.4.1.248.11.21.1.4.2.1.0

::hm2FMServerPassword
set oid_user_pass=.1.3.6.1.4.1.248.11.21.1.4.2.2.0

::hm2FMActionSourceData
set oid_bin_source=.1.3.6.1.4.1.248.11.21.1.2.10.0

::hm2FMActionActivateKey
set oid_activate_key=.1.3.6.1.4.1.248.11.21.1.2.18.0

::hm2FMActionActivate
set oid_action_activate=.1.3.6.1.4.1.248.11.21.1.2.1.1.5

::hm2FMActionActivate.copy.firmware.server.system
set oid_action_activate_with_key=%oid_action_activate%.2.30.20.11

::hm2DevMgmtActionReset (1= other, 2 = reset)
set oid_reboot=.1.3.6.1.4.1.248.11.10.1.2.1.0

::hm2FMActionStatus (1 = idle, 2 = running)
set oid_action_status=.1.3.6.1.4.1.248.11.21.1.2.14.0

::hm2FMActionPercentReady
set oid_percent_ready=.1.3.6.1.4.1.248.11.21.1.2.15.0

::hm2FMActionResult (1 = ok)
set oid_result=.1.3.6.1.4.1.248.11.21.1.2.16.0

::hm2FMActionResultText
set oid_result_text=.1.3.6.1.4.1.248.11.21.1.2.17.0


IF     .%1. == ..   GOTO UPDATE_Q
IF     .%1. == .-h. GOTO HELP
IF     .%1. == ./?. GOTO HELP
IF     .%2. == ..   GOTO HAC_IP
IF     .%3. == ..   GOTO HAC_HW
IF NOT .%4. == ..   GOTO HAC_SW_DBG
IF NOT .%3. == ..   GOTO HAC_SW_VER


:HAC_SW_DBG
    set hac_sw_dbg=_dbg_%4

:HAC_SW_VER
    set hac_sw_ver=bogmart_builds/%3

:HAC_HW
	set hac_sw=%2
	
	::parse image name, e.g: rsp-PRP
    for /f "delims=-" %%a in ("%2") do set hac_hw=%%a
	
:HAC_IP
    set hac_ip=%1
	:: get destination network: ATTENTION network is always /16 (eg x.y.0.0)
	::for /f "tokens=1,2 delims=." %%a in ("%hac_ip%") DO  set destNet=%%a.%%b.0.0
	:: from "destNet", get local interface toward nexthop
	::for /f "tokens=4" %%a in ('route print %destNet% ^| grep -E "Network Destination +Netmask +Gateway +Interface" -A 1 ^| grep %destNet%') DO  set serv_ip=%%a
    for /f "tokens=2,3,4,5 delims=. " %%a in ('pathping -w 1 -q 1 -p 1 -h 1 -n -4 %hac_ip% ^| grep -m 1 -E "^ +0 +"') DO  set serv_ip=%%a.%%b.%%c.%%d

:SET_PATH_BIN_FILE
    set path_bin_file=ftp://%serv_ip%/%hac_sw_ver%/%hac_hw%%hac_sw_dbg%/images/%hac_sw%.bin

GOTO START_UPDATE


:UPDATE_Q
    echo.
    set /p override=  Do you want override software on %hac_ip%  [y] ?
    if "%override%" == "y" GOTO START_UPDATE
    if "%override%" == "Y" GOTO START_UPDATE
    GOTO HELP


:START_UPDATE

:SET_GLOBAL_PARAMS
    snmpset -v 2c -c private  %hac_ip%  %oid_user_name% s %user_name%
    snmpset -v 2c -c private  %hac_ip%  %oid_user_pass% s %user_pass%
    snmpset -v 2c -c private  %hac_ip%  %oid_bin_source% s %path_bin_file%
  
:GET_ACTION_KEY_NUM
    for /f "tokens=*" %%a in (
        'snmpget -c public -v 2c -O vq %hac_ip% %oid_activate_key%'
    ) do (
        set /a key_number = %%a
        )
    GOTO LOAD_BIN

:LOAD_BIN
    snmpset -t 40 -v 2c -c private  %hac_ip%  %oid_action_activate_with_key%  i %key_number%


:GET_STATUS
    for /f "tokens=*" %%b in (
     'snmpget -t 10 -c public -v 2c -O vq %hac_ip% %oid_action_status%'
    ) do (
        set /a is_running = %%b
        )
    ::echo is_running %is_running%
    ::if  %is_running% == 2  echo is_running %is_running%
  
:GET_PERCENT_READY
    if  %is_running% == 2 (
	    for /f "tokens=*" %%c in (
            'snmpget -t 5 -c public -v 2c -O vq %hac_ip% %oid_percent_ready%'
	    ) do (
		    if NOT .%percent_ready_old%. == .%%c.    echo percent_ready %%c
		    set /a percent_ready_old = %%c
			
			if %%c LSS 40 (
		         set /a sleep_time = "(100 - %%c) / 10"
			  ) else (
			     set /a sleep_time = "(100 - %%c) / 25 + 1"
			  )
            )
  
	    sleep %sleep_time%
	    GOTO GET_STATUS
    )
  
:GET_RESULT
    for /f "tokens=*" %%d in (
        'snmpget -t 5 -c public -v 2c -O vq %hac_ip% %oid_result_text%'
    ) do (
        set result_text=%%d
        )
    echo.
    echo result_text %result_text%
  
:TEST_REBOOT
    for /f "tokens=*" %%e in (
        'snmpget -t 5 -c public -v 2c -O vq %hac_ip% %oid_result%'
    ) do (
        set result=%%e
        )
    :: result = 1 -> ok
    if %result% EQU 0 (
        :: result not ready
	    sleep 1
        GOTO TEST_REBOOT
    ) else (
        if %result% EQU 1 (
            GOTO REBOOT
        ) else (
            GOTO GET_TIME
        )

  
:REBOOT
    :: reboot after upgrade
    echo.
    echo  rebooting...
    snmpset -v 2c -c private  %hac_ip%  %oid_reboot% i 2
    GOTO GET_TIME


:GET_TIME
    call getTimeEnd.bat

    echo.
    echo  update start time    %hour%:%min%:%sec%
    echo  update end time      %hourEnd%:%minEnd%:%secEnd%

    @echo off
    call getTimeDiff.bat

    echo  ~ %hac_sw% ~  update time  %hourDif% hours  %minDif% mins   %secDif% secs
    echo.
    GOTO END


:HELP
    echo.
    ECHO usage:     %0  [HAC_IP_Address]  [HAC_HW]  [HAC_SW_VER]               [HAC_SW_DBG]
    ECHO       ( default:   IP: %hac_ip%      %hac_sw%       %hac_sw_ver%   "linkd" )
	ECHO        HAC_SW_VER: p5_shine   ^|  p5_shine_v5
	ECHO        HAC_SW_DBG: 0 ^| 2 ^| 6 ^| 00
    echo.
    @ECHO OFF
    GOTO END
  

:END

ENDLOCAL
  
