@ECHO OFF

IF     .%1. == ..   GOTO HELP

set build=%1
set tempFileBins=%tmp%\%build%_bins.txt
set tempFileDbg=%tmp%\%build%_dbg.txt
set tempBinCopyFile=%tmp%\tmp.bin

rem dir /b  /s \\10.115.43.16\K-Stufen\PlattformV\v07200\%build%\*.bin | grep -v "BOOT\|MRP\|PRP\|HSR\|DLR\|NAT" > %tempFileBins%

if .%build%. == .all. (
rem    dir /b  /s \\10.115.43.16\K-Stufen\PlattformV\v07200\*corefile | grep -v "boot"  | grep  "MACH" > %tempFileDbg%
) else (
rem    dir /b  /s \\10.115.43.16\K-Stufen\PlattformV\v07200\%build%\*corefile  | grep -v "boot"  | grep  "MACH" > %tempFileDbg%
)	

for /f  "eol=; delims=;" %%i in (%tempFileBins%) do (
    ::echo %%i
	cp %%i %tempBinCopyFile%
	call hmImgTool -l -i %tempBinCopyFile%  | grep -m 4 -i "Base\|Size" | tr "\n" "  "
	echo.
)

for /f  "eol=; delims=;" %%i in (%tempFileDbg%) do (
    echo %%i
	call objdump -h %%i | grep "vfp11_veneer"
	echo.
)


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