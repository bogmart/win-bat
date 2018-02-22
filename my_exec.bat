@echo off
::echo %* > c:\test.txt

for /f "tokens=*" %%a in (
'VER'
) do (
set myvar=%%a
)
echo/%%myvar%%=%myvar% 