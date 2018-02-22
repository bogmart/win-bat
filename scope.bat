@echo off

if .%1. == ./d. goto DEL


::test daca deja s-a pus calea dorita prima in "path"
IF .%BAT_PATH%. == .1.  goto RUN_TAG


set BAT_PATH=1
set PATH=C:\WINDOWS\BAT\exe;%PATH%


:RUN_TAG
  if exist cscope.out    del cscope.out
  if exist cscope.in.out del cscope.in.out
  if exist cscope.po.out del cscope.po.out
  if exist tagFiles.txt  del tagFiles.txt

  echo Building files list...
  ::python.exe C:\WINDOWS\BAT\tagFiles.py > tagFiles.txt
  ::dir /S /b *.c *.cpp *.h *.hpp *.py *.java > tagFiles.txt    :: merge mult mai rapid dar pune cale absoluta
  find1.exe  -name *.c -o -name *.cpp -o -name *.h -o -name *.hpp -o -name *.py -o -name *.java > tagFiles.txt

  echo Building cscope...
  cscope.exe -b -i tagFiles.txt

  del tagFiles.txt

  echo Finished building cscope
  echo.
  echo run ":cs add cscope.out" from VIM
  
  goto END


:DEL
  del /s cscope.out cscope.in.out cscope.po.out


:END