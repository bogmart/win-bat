@ECHO OFF

::rezultatele sunt variabilele:   hour   min  sec
::NOTA: variabila %time% este definita de sistem

set /a hour = %TIME:~0,2%
set /a min  = %TIME:~3,1% * 10 +  %TIME:~4,1%
set /a sec  = %TIME:~6,1% * 10 +  %TIME:~7,1%


::daca valorile < 10 atunci le adug un "0" ca prefix [setez de forma "05" (si nu "5")]
IF %hour% lss 10   set hour=0%hour%
IF %min%  lss 10   set min=0%min%
IF %sec%  lss 10   set sec=0%sec%


:: nu am putut lua tot numarul dintr-o miscare (de ex set /a hour = %TIME:~0,2%)
:: deoarece ai eroarea ca numerel ce incep cu 0 (zero) sunt tratate ca nr in baza 8


::sol 2
::FOR /F "tokens=1,2,3 delims=:. " %%i in ("%time%") do (
::                                                        set /a hour=%%i
::                                                        set /a min=%%j
::                                                        set /a sec=%%k
::                                                       )
