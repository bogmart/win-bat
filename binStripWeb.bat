@ECHO OFF

IF     .%1. == ..   GOTO HELP

set build=%1
set outFolder=%tmp%\%build%_NO_WEB

set tempFileBins=%tmp%\%build%_bins.txt
set tempFileDbg=%tmp%\%build%_dbg.txt
set tempBinCopyFile=%tmp%\tmp.bin
set deviceId=0
set outDrive=C:


IF EXIST %outFolder% rmdir /S /Q %outFolder%
mkdir %outFolder%

FOR /F "tokens=1 delims=:" %%i in ("%outFolder%") do set outDrive=%%i
%outDrive%:
cd %outFolder%


dir /b  /s \\10.115.43.16\K-Stufen\PlattformV\v07200\%build%\*.bin | grep -v "BOOT\|MRP\|PRP\|HSR\|DLR\|NAT" > %tempFileBins%

for /f  "eol=; delims=;" %%b in (%tempFileBins%) do (
    rem echo %%b
	echo %%~nxb
	cp %%b %outFolder%\%%~nxb
	::get device id
	FOR /F "tokens=3" %%d in ('call hmImgTool -l -i %outFolder%\%%~nxb ^| grep -m 1 Device-Id') do set deviceId=%%d
	::extract the WEB container
	call hmImgTool -e -i %outFolder%\%%~nxb  -o container.zip  --md5 --finalize
	::remove folders "web\content" and "web\Generic"
	call 7z d container.zip   web\content  web\Generic
	::add the new WEB container
	call hmImgTool -a -i container.zip -o %outFolder%\%%~nxb -d %deviceId% -f 5 --md5 -p bogmart -v CONTAIN -s 1 -r 1
	echo.
)

start.


GOTO END


:HELP
    echo.
    ECHO usage:  %0  [build]
    echo.
    ECHO    example:
    ECHO       %0  NTLY122
    @ECHO OFF
    GOTO END

:END