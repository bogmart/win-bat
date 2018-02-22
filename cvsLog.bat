::@echo off

SETLOCAL

set cvsOutDir=D:\cvs_p4
set shinePath=S:\bogmart_workbench\p4_shine
set cvsStartDate=20160101
::set cvsBranch=-F BRANCH_REL06000

set cvsFile=%cvsOutDir%\cvsLog_%cvsBranch%%cvsStartDate%
set cvsLog=%cvsFile%.log
set cvsXml=%cvsFile%.xml
set cvsHtml=%cvsFile%.html

::set filterIN=-C -R spanning_tree  -R dot1s[0-9a-zA-z_]*\.[ch]+
::set filterOUT=-P -I drstp  -I cli[0-9a-zA-z_]*dot1s[0-9a-zA-z_]*\.[ch]+ -M Branch  -M "Build Fix"  -M _BUGFIX_  -M "(FP|FASTPATH) (checkin|Micro|Release)" -M Merge  -M migrate  -M "msgQSend und osapiMessageSend"  -M P4.SNMP.012  -M web-content


SETLOCAL EnableDelayedExpansion
WHERE /Q perl
IF !ERRORLEVEL! NEQ 0 (
    WHERE /Q perlInit
    IF !ERRORLEVEL! NEQ 0 (
      ECHO "Err: perl is not available!"
      ENDLOCAL
      goto END
    ) else (
      ENDLOCAL
      call perlInit.bat
    )
  )

IF NOT EXIST %cvsOutDir% (
    mkdir %cvsOutDir%
  )

IF NOT EXIST %cvsLog% (
    cvs -z 9 log -SN -d ">=%cvsStartDate%" > %cvsLog%
  )


perl %shinePath%\cvslog\cvs2cl.pl  --stdin -T -r --xml --xml-encoding ISO-8859-1 %cvsBranch%  %filterIN%  %filterOUT%  -f %cvsXml%  < %cvsLog%
perl %shinePath%\cvslog\cl2html.pl --entries 0 < %cvsXml% > %cvsHtml%

IF EXIST %cvsXml% (
    del %cvsXml%
  )


:END
ENDLOCAL
