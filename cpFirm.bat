@ECHO OFF

::Examples:
::cpFirm
::cpFirm  msp403a_MR
::cpFirm  grs10403a_MR   00   p5_shine_v6 
::cpFirm  rspe3s_BR       2   p5_shine      

SETLOCAL

call getTime.bat

set path_bin_folder=D:\versiuni\bogmart_builds
set hac_sw_ver=p5_shine


set dst_file=firmware.bin

IF     .%1. == ..   GOTO HELP
IF     .%1. == .-h. GOTO HELP
IF     .%1. == ./?. GOTO HELP

rem ToDo: ver_1
rem   wmic LOGICALDISK where driveType=2 get deviceID > wmic.txt
rem   for /f "skip=1" %%b IN ('type wmic.txt') DO (echo %%b & pause & Dir %%b)
rem ToDo: ver_2
rem   http://www.uwe-sieber.de/usbdlm_e.html

set dst_media=F:
IF NOT EXIST %dst_media%\ (
    set dst_media=J:
    )
IF NOT EXIST %dst_media%\ (
    set dst_media=I:
    )
IF NOT EXIST %dst_media%\ (
    GOTO NO_USB
    )



IF     .%2. == ..   GOTO HAC_HW
IF NOT .%3. == ..   GOTO HAC_SW_VER
IF NOT .%2. == ..   GOTO HAC_SW_DBG

:HAC_SW_VER
    set hac_sw_ver=%3

:HAC_SW_DBG
    set hac_sw_dbg=_dbg_%2

:HAC_HW
	set hac_sw=%1
	::parse image name, e.g: rsp-PRP_FACTORY
    for /f "delims=-" %%a in ("%1") do set hac_hw=%%a
	for /f "delims=_ tokens=1,2" %%a in ("%hac_hw%") do set hac_hw=%%a_%%b

:SET_PATH_BIN_FILE
    set path_bin_file=%path_bin_folder%\%hac_sw_ver%\%hac_hw%%hac_sw_dbg%\images\%hac_sw%.bin
    IF NOT EXIST %path_bin_file% GOTO ERR_IN_FILE

:CP_FIRMWARE
    echo copy  \%hac_sw_ver%\%hac_hw%%hac_sw_dbg%\images\%hac_sw%.bin  to  %dst_media%\%dst_file%
    cp  --preserve %path_bin_file%   %dst_media%/%dst_file%
    call stat %dst_media%/%dst_file%  | grep "Modify:"
	
:CHECK_FIRMWARE
	diff %path_bin_file%  %dst_media%/%dst_file%
	IF %ERRORLEVEL% NEQ 0  (
		echo BAD copy! Try again...
		GOTO CP_FIRMWARE
	)

:EJECT_MEDIA
    sleep 1
	call "C:\Program Files (x86)\USBDiskEjector\USB_Disk_Eject.exe" /CLOSEAPPSFORCE /REMOVELETTER  %dst_media% 

:GET_TIME
    call getTimeEnd.bat
    call getTimeDiff.bat
    
    echo update time  %minDif% mins   %secDif% secs
    echo.
    GOTO END

    
:ERR_IN_FILE
    echo.
    ECHO Source file not found:  %path_bin_file%
    @ECHO OFF
    GOTO END

:HELP
    echo.
    ECHO usage:  %0  [HAC_HW] [HAC_SW_DBG] [HAC_SW_VER]
    ECHO    ( default:    %hac_sw%        latest_link  %hac_sw_ver% )
    ECHO     HAC_HW:     mach4k3a_MR ^| grs10403a_MR ^| msp403a_MR
    ECHO     HAC_SW_DBG: 0 ^| 2 ^| 6 ^| 00 ^|  0_old ^| 2_old ^| 6_old
    ECHO     HAC_SW_VER: p5_shine   ^|  p5_shine_v5
    echo.
    ECHO    example:
    ECHO       %0  mach4k3a_MR  2_old  p5_shine_v5
    @ECHO OFF
    GOTO END
  
:NO_USB
    ECHO NO USB device detected !
    @ECHO OFF
    GOTO END

:END

ENDLOCAL