call ccenv.bat %1

@echo off

if .%2. == .. goto V3
if .%2. == .1. goto V1
if .%2. == .2. goto V2
if .%2. == .3. goto V3


::visual Slick v13.0.1
:V1
start C:\"Program Files"\"SlickEdit v13.0.1"\win\vs.exe +new
PING 1.1.1.1 -n 1 -w 3000 >NUL
goto END


::visual Slick v13.0.2
:V2
start C:\"Program Files"\"SlickEdit v13.0.2"\win\vs.exe +new
PING 1.1.1.1 -n 1 -w 3000 >NUL
goto END


::visual Slick v14.0.1
:V3
start C:\"Program Files"\"SlickEdit v14.0.1"\win\vs.exe +new
PING 1.1.1.1 -n 1 -w 3000 >NUL
goto END



:END