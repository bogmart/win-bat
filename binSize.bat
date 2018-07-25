@ECHO OFF

IF     .%1.    == ..   GOTO HELP

set build=%1
set device=%2
IF .%device%.  == ..  set device=.*
set release=%3
IF .%release%. == ..  set release=v99999


set tempFileBins=%tmp%\%build%_bins.txt
set tempFileDbg=%tmp%\%build%_dbg.txt
set tempBinCopyFile=%tmp%\tmp.bin




if .%build%. == .all. (
    dir /b  /s \\10.115.43.16\K-Stufen\PlattformV\%release%\*.bin | grep -i "%device%-" | grep -v "BOOT\|MRP\|PRP\|HSR\|DLR\|NAT\|_VL\|_ABB" > %tempFileBins%
    dir /b  /s \\10.115.43.16\K-Stufen\PlattformV\%release%\*corefile | grep -i "%device%" | grep -v "boot\|_VL\|_ABB"  | grep  "%device%_" > %tempFileDbg%
) else (
    dir /b  /s \\10.115.43.16\K-Stufen\PlattformV\%release%\%build%\*.bin | grep -i "%device%-" | grep -v "BOOT\|MRP\|PRP\|HSR\|DLR\|NAT\|_VL\|_ABB" > %tempFileBins%
    dir /b  /s \\10.115.43.16\K-Stufen\PlattformV\%release%\%build%\*corefile  | grep -i "%device%" | grep -v "boot\|_VL\|_ABB"  | grep  "%device%_" > %tempFileDbg%
)	

for /f  "eol=; delims=;" %%i in (%tempFileBins%) do (
    ::echo %%i
	cp %%i %tempBinCopyFile%
	call hmImgTool -l -i %tempBinCopyFile%  | grep -i "Name\|Size" | sed "s/.*: *$//" | sed "s/ *: */:/" | sed "s/ /_/" | tr "\n\r" " "
	echo.
)

for /f  "eol=; delims=; " %%i in (%tempFileDbg%) do (
	echo.
    echo %%i
	call objdump -h %%i | grep " [0-9]* \." | sed "s/ *[0-9]* *\(\.[^ ]* *[0-9a-f$]*\) .*/\1/" 
)
::| tr [:lower:] [:upper:] | bc


GOTO END


:HELP
    echo.
    ECHO usage:  %0  [build]  [device]  [release]
    echo.
    ECHO    example:
    ECHO       %0  NTLY122  ees  v99999
    @ECHO OFF
    GOTO END

:END