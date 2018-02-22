@ECHO OFF

::rezultatele sunt variabilele:   day   month   year
::NOTA: variabila %date% este definita de sistem



FOR /F "tokens=1,2,3 delims=/neduitn\. " %%i in ("%date%") do (
  set day=%%i
  set month=%%j
  set /a year = %%k%%100
)


::anul este obtinut mai sus prin modulo 100 (2005 % 100 = 5)
::daca anul < 10 atunci setez anul de forma "05" (si nu "5")
IF %year% lss 10   set year=0%year%

