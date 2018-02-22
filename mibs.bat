@ECHO OFF

::updates HM MIBS used by Wireshark



SETLOCAL

call getDate.bat

set shineP4=S:\bogmart_workbench\p4_shine
set hacShared=S:\bogmart_workbench\p5_hirschmann_shared
set wiresharkMibs=%ProgramFiles%\Wireshark\snmp\mibs
set wiresharkMibsOld=%ProgramFiles%\Wireshark\snmp\mibs_old_%year%.%month%.%day%
set perlScript=%ProgramFiles(x86)%\BAT\mib.pl
set safeMibs=%ProgramFiles(x86)%\BAT\mib

set tmpDir=%temp%\MIBS_TMP

::set short names
for %%I in ("%shineP4%")          do set shineP4=%%~sI
for %%I in ("%hacShared%")        do set hacShared=%%~sI
for %%I in ("%wiresharkMibs%")    do set wiresharkMibs=%%~sI
for %%I in ("%wiresharkMibsOld%") do set wiresharkMibsOld=%%~sI
for %%I in ("%perlScript%")       do set perlScript=%%~sI
for %%I in ("%safeMibs%")         do set safeMibs=%%~sI
for %%I in ("%tmpDir%")           do set tmpDir=%%~sI


IF EXIST %tmpDir% rmdir /S /Q %tmpDir%
mkdir %tmpDir%

::test backup folder
IF EXIST %wiresharkMibsOld% (
  echo err: backup MIBs folder already exist  !!!
  echo    %wiresharkMibsOld%
  goto END
  )

::copy P5  HM MIBS
copy %hacShared%\mibs\hirschmann %tmpDir%
::copy P5  STD MIBS
copy %hacShared%\mibs\std-mibs   %tmpDir%

::copy P4  HM MIBS
copy %shineP4%\fastpath\src\mgmt\snmp\packages\hirschmann\released_mibs\hmpriv.mib   %tmpDir%
copy %shineP4%\fastpath\src\mgmt\snmp\packages\hirschmann\released_mibs\usrgrp.mib   %tmpDir%

cd /D %tmpDir%
call perlInit.bat
perl %perlScript%


::over-write some strange MIBS
copy /Y %safeMibs%  %tmpDir%

::backup MIBs
IF EXIST %wiresharkMibs% (
  mkdir %wiresharkMibsOld%
  copy %wiresharkMibs% %wiresharkMibsOld%
  )
  
::create folder
IF NOT EXIST %wiresharkMibs% (
  mkdir %wiresharkMibs%
  )

::copy new MIBs
copy /Y %tmpDir% %wiresharkMibs%

cd ..
rmdir /S /Q %tmpDir%

:END
ENDLOCAL