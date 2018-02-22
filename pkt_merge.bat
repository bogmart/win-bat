@echo off

set nr_merge=5
set pkt_temp=pkt_temp.cap


IF .%1. == .. GOTO HELP
IF .%2. == .. GOTO HELP

IF NOT .%1. == .. set file_in=%1
IF NOT .%2. == .. set file_out=%2
IF NOT .%3. == .. set nr_merge=%3


copy  %file_in%   %pkt_temp%


for /l %%i in (1,1,%nr_merge%) do (
C:\"Program Files"\Wireshark\mergecap.exe -F libpcap  -w %file_out%.cap   %pkt_temp%  %pkt_temp%
copy  %file_out%.cap  %pkt_temp%
)

del %pkt_temp%
goto END


:HELP
   echo.
   echo utilizare:   %0  pkt_in  pkt_out [count_merge=%nr_merge%]
   echo.
   @ECHO OFF
   GOTO END



:END

