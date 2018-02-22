::usage
::call getTime.bat
:: ...
::call getTimeEnd.bat
:: ...
::call getTimeDiff.bat
::echo total_time      %hourDif% hours  %minDif% mins   %secDif% secs

@ECHO OFF

::strip first "0" if it exists
IF "%hour:~0,1%"    == "0"  SET /a hour    = %hour:~1%
IF "%min:~0,1%"     == "0"  SET /a min     = %min:~1%
IF "%sec:~0,1%"     == "0"  SET /a sec     = %sec:~1%
IF "%hourEnd:~0,1%" == "0"  SET /a hourEnd = %hourEnd:~1%
IF "%minEnd:~0,1%"  == "0"  SET /a minEnd  = %minEnd:~1%
IF "%secEnd:~0,1%"  == "0"  SET /a secEnd  = %secEnd:~1%


set /a start_time_secs = 3600*%hour%    + 60*%min%    + %sec%
set /a end_time_secs   = 3600*%hourEnd% + 60*%minEnd% + %secEnd%
set /a diff_time       = end_time_secs - start_time_secs

set /a hourDif =  %diff_time% / 3600
set /a minDif  = (%diff_time% - 3600*%hourDif%) / 60
set /a secDif  =  %diff_time% - 3600*%hourDif% - 60*%minDif%

::daca valorile < 10 atunci le adug un "0" ca prefix [setez de forma "05" (si nu "5")]
IF %hourDif% lss 10   set hourDif=0%hourDif%
IF %minDif%  lss 10   set minDif=0%minDif%
IF %secDif%  lss 10   set secDif=0%secDif%

:END
