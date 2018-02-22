@echo off

call getDate.bat
call getTime.bat


IF .%1. == .b. IF .%2. == ..  GOTO BOGDAN
IF .%1. == .b. IF .%2. == .p. GOTO BOGDAN_PIM
IF .%1. == .b. IF .%2. == .m. GOTO BOGDAN_MRTM




:BOGDAN
call arh "C:\Documents and Settings\bogmart\Desktop\flash\ces\%year%-%month%-%day%--%hour%-%min%_pim_bogdan" s:\Engine\pim

call arh "C:\Documents and Settings\bogmart\Desktop\flash\ces\%year%-%month%-%day%--%hour%-%min%_mrtm_bogdan" s:\Engine\mrtm
GOTO END


:BOGDAN_PIM
call arh "C:\Documents and Settings\bogmart\Desktop\flash\ces\%year%-%month%-%day%--%hour%-%min%_pim_bogdan" s:\Engine\pim
GOTO END

:BOGDAN_MRTM
call arh "C:\Documents and Settings\bogmart\Desktop\flash\ces\%year%-%month%-%day%--%hour%-%min%_mrtm_bogdan" s:\Engine\mrtm
GOTO END


:END