@ECHO OFF

::rezultatele sunt variabilele:   hourEnd   minEnd  secEnd
::NOTA: variabila %time% este definita de sistem

set /a hourEnd = %TIME:~0,2%
set /a minEnd  = %TIME:~3,1% * 10 +  %TIME:~4,1%
set /a secEnd  = %TIME:~6,1% * 10 +  %TIME:~7,1%

::daca valorile < 10 atunci le adug un "0" ca prefix [setez de forma "05" (si nu "5")]
IF %hourEnd% lss 10   set hourEnd=0%hourEnd%
IF %minEnd%  lss 10   set minEnd=0%minEnd%
IF %secEnd%  lss 10   set secEnd=0%secEnd%

:: nu am putut lua tot numarul dintr-o miscare (de ex set /a hour = %TIME:~0,2%)
:: deoarece ai eroarea ca numerel ce incep cu 0 (zero) sunt tratate ca nr in baza 8


::sol 2
::FOR /F "tokens=1,2,3 delims=:. " %%i in ("%time%") do (
::                                                        set /a hour=%%i
::                                                        set /a min=%%j
::                                                        set /a sec=%%k
::                                                       )
