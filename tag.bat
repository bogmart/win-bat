@echo off

if .%1. == ./d. goto DEL


::test daca deja s-a pus calea dorita prima in "path"
IF .%BAT_PATH%. == .1.  goto RUN_TAG


set BAT_PATH=1
set PATH=C:\WINDOWS\BAT\exe;%PATH%


:RUN_TAG
  if exist tags del tags
  if exist tagFiles.txt del tagFiles.txt

  echo Building files list...
  ::python.exe C:\WINDOWS\BAT\tagFiles.py > tagFiles.txt
  ::dir /S /b *.c *.cpp *.h *.hpp *.py *.java > tagFiles.txt    :: merge mult mai rapid dar pune cale absoluta
  find1.exe  -name *.c -o -name *.cpp -o -name *.h -o -name *.hpp -o -name *.py -o -name *.java > tagFiles.txt

  echo Building ctags...
  ctags.exe -L tagFiles.txt

  del tagFiles.txt

  echo Finished building ctags

  goto END


:DEL
  del /s tags


:END