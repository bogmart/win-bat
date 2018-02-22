@echo OFF
setlocal ENABLEDELAYEDEXPANSION

set projPath="D:\bogmart_workbench\shine"

set fileIn=%~f1
set fileOut=%~f2

if .%3%. == .. GOTO PARSE_LOG_CVS_DIFF

set filePath=%3%

IF .%fileIn%.   == .. GOTO HELP
IF .%fileOut%.  == .. GOTO HELP
IF .%filePath%. == .. GOTO HELP

::     pimsmsgtree.c (1.21 -> 1.22)
:PARSE_LOG_E_MAIL
FOR /F "usebackq tokens=1,2,4 delims=^(^) " %%A IN ("%fileIn%") DO (
  pushd
  cd %projPath%
  echo "cvs diff -u -r %%B -r %%C %filePath%\%%A >> %fileOut%"
  cvs diff -u -r %%B -r %%C %filePath%\%%A >> %fileOut%
  popd
)
GOTO END

::     fastpath/src/application/ip_mcast/vendor/pimsm/pimsmsgtree.c 1.22
:PARSE_LOG_CVS_DIFF
pushd
cd %projPath%
FOR /F "usebackq tokens=1,2 delims= " %%A IN ("%fileIn%") DO (
  set rev=%%B
  rem ::echo "cvs diff -u -r !rev! -r !revPrev! %%A >> %fileOut%"
  rem ::cvs diff -u -r !rev! -r !revPrev! %%A >> %fileOut%

  rem ::get prev CVS revision: 1.5.2.22 --> 1.5.2.21
  FOR /F %%V IN ('echo !rev! ^| grep  -o "\(.*\.\)"') DO set revPrev0=%%V
  FOR /F %%W IN ('echo !rev! ^| awk -F "." "{print $NF - 1;}"') DO set revPrev1=%%W
  set revPrev=!revPrev0!!revPrev1!
  echo revPrev !revPrev!
  
  echo "cvs diff -u -r !revPrev! -r !rev! %%A >> %fileOut%"
  cvs diff -u -r !revPrev! -r !rev! %%A >> %fileOut%
)
popd
GOTO END


:HELP
   ECHO.
   ECHO Usage:    %0  [list_of_files] [out_CVS_diff] [path_relative]
   ECHO Example:  %0  in_list.txt     out_patch.txt  fastpath\src\application\ip_mcast\vendor\pimsm
   ECHO.
   ECHO Help:     Creates a 'patch' file starting from commit's details (commit e-mail).
   ECHO           This 'patch' is compatible with Workbench application.
   ECHO Note:     Configured base path is  %projPath%
   ECHO Example_1 for input file's content (from e-mail):
   ECHO       pimsmsgtree.c (1.21 -^> 1.22)
   ECHO       pimsmstargtree.c (1.14 -^> 1.15)
   ECHO.
   ECHO Example_2 for input file's content (from CVS diff log):
   ECHO       fastpath/src/application/ip_mcast/vendor/pimsm/pimsmsgtree.c 1.22
   ECHO       fastpath/src/application/ip_mcast/vendor/pimsm/pimsmstargtree.c 1.15
   @ECHO OFF
   GOTO END
  
:END

ENDLOCAL