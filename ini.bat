title start

::set version

::set serv_ver=8
::set slick_ver=3


:: insert lab route 
call rute.bat


:: HDD S.M.A.R.T. status
cd C:\"HDD status"
call hdd_status.bat

::goto end



::start c:\Progra~1\FTPSer~1\ftpserv.exe
C:\"Program Files"\"FileZilla Server"\"FileZilla server.exe" /start

start C:\Progra~1\Tftpd32\tftpd32.exe


::  wait 8 sec for starting Outlook
start c:\Progra~1\Outloo~1\msimn.exe
PING 1.0.0.0 -n 1 -w 8000 >NUL



::call hac10_m4002.bat
::PING 1.0.0.0 -n 1 -w 1000 >NUL


::call hac9_m4002.bat
::PING 1.0.0.0 -n 1 -w 1000 >NUL


::call hac7_m4002_3x.bat
::PING 1.0.0.0 -n 1 -w 1000 >NUL


::call hac8_m4002_24g.bat
::PING 1.0.0.0 -n 1 -w 1000 >NUL


::call hac3_m1000ge.bat
::PING 1.0.0.0 -n 1 -w 1000 >NUL

::call hac12_m1000ge.bat
::PING 1.0.0.0 -n 1 -w 1000 >NUL

::call hac24_m1000ge.bat
::PING 1.0.0.0 -n 1 -w 1000 >NUL


::start call telnet 10.20.10.3


start C:\PROGRA~1\FIREFO~1\Firefo~1.exe

::start C:\WindRiver32\workbench-3.2\wrwb\platform\x86-win32\eclipse\wrwb-x86-win32.exe -vmargs -Xmx1g
::start C:\WindRiver32_rsp\workbench-3.2\wrwb\platform\x86-win32\eclipse\wrwb-x86-win32.exe -vmargs -Xmx1g


:: set env
::start ccenv  %serv_ver%
::PING 1.0.0.0 -n 1 -w 1000 >NUL


::gVim
::start C:\Progra~1\"Vim_v7.0"\vim70\gvim.exe


::Slick
::call vs.bat  %serv_ver%  %slick_ver%


:: atrib S:
::call s.bat  %serv_ver%
::PING 1.0.0.0 -n 1 -w 2000 >NUL


:: Pidgin
start C:\Progra~1\PidginPortable\PidginPortable.exe



:: start Internet Explorer
::start c:\Progra~1\Intern~1\iexplore.exe 10.20.30.25
::PING 1.0.0.0 -n 1 -w 2000 >NUL




:END
exit