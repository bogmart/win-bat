@ECHO OFF

SETLOCAL 

set MIBDIRS=%MIBDIRS%;S:\bogmart_workbench\p4_shine\fastpath\src\mgmt\snmp\packages\hirschmann\released_mibs
set MIBS=%MIBS%;HMPRIV-MGMT-SNMP-MIB

set hac_ip=10.20.10.105

::clean up
FOR /L %%i IN (1,1,16) DO (
	snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%%i i 6   2>&0 1>&0
	)

set /a srvId = 1
snmpset -v 2c -c private %hac_ip% hmRelayServerInterface.%srvId% i %srvId%  2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerInterface %srvId%
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%    2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerAddr %srvId%.%srvId%.%srvId%.%srvId%

snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 1   2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 2   2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 2
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 3   2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 3
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 4   2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 4
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 6   2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 6

snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 5  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 5



set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 5  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 5
snmpset -v 2c -c private %hac_ip% hmRelayServerInterface.%srvId% i %srvId%  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerInterface %srvId%



set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 5  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 5
snmpset -v 2c -c private %hac_ip% hmRelayServerInterface.%srvId% i %srvId%  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerInterface %srvId%
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%    2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerAddr %srvId%.%srvId%.%srvId%.%srvId%


set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 5  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 5
snmpset -v 2c -c private %hac_ip% hmRelayServerInterface.%srvId% i  1  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerInterface 1
snmpset -v 2c -c private %hac_ip% hmRelayServerInterface.%srvId% i %srvId%%srvId%  2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerInterface %srvId%%srvId%
snmpset -v 2c -c private %hac_ip% hmRelayServerInterface.%srvId% i %srvId%  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerInterface %srvId%
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a 1.1.1.1    2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerAddr 1.1.1.1
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a 333.333.333.333    2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerAddr 333.333.333.333
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a 255.255.255.255    2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerAddr 255.255.255.255
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%    2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerAddr %srvId%.%srvId%.%srvId%.%srvId%

set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 5  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 5
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a 0.0.0.0    2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerAddr 0.0.0.0

set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 5  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 5
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%    2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerAddr %srvId%.%srvId%.%srvId%.%srvId%
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 1   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 1
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a 0.0.0.0    2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerAddr 0.0.0.0
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 2     hmRelayServerAddr.%srvId% a 0.0.0.0     2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 2   hmRelayServerAddr.%srvId% a 0.0.0.0
snmpset -v 2c -c private %hac_ip% hmRelayServerAddr.%srvId% a 0.0.0.0    2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerAddr 0.0.0.0
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 1   2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 1

set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 5  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 5
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 5  2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 5
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 4  2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 4

snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 6   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 6
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 6   2>&0 1>&0
call:TEST_NEGATIVE %srvId%  hmRelayServerRowStatus 6

set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 4        hmRelayServerInterface.%srvId% i %srvId%   hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 4  hmRelayServerInterface %srvId%  hmRelayServerAddr %srvId%.%srvId%.%srvId%.%srvId%
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 1   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 2   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 2
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 1   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 1

set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip%  hmRelayServerInterface.%srvId% i %srvId%   hmRelayServerRowStatus.%srvId% i 4   hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 4  hmRelayServerInterface %srvId%  hmRelayServerAddr %srvId%.%srvId%.%srvId%.%srvId%
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 2   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 2

set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip%  hmRelayServerInterface.%srvId% i %srvId%   hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%   hmRelayServerRowStatus.%srvId% i 4  2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 4  hmRelayServerInterface %srvId%  hmRelayServerAddr %srvId%.%srvId%.%srvId%.%srvId%



set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip% hmRelayServerRowStatus.%srvId% i 4  hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%    2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerRowStatus 4  hmRelayServerAddr  %srvId%.%srvId%.%srvId%.%srvId%


set /a srvId = %srvId% + 1
snmpset -v 2c -c private %hac_ip%  hmRelayServerAddr.%srvId% a %srvId%.%srvId%.%srvId%.%srvId%   hmRelayServerRowStatus.%srvId% i 4   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerAddr  %srvId%.%srvId%.%srvId%.%srvId%  hmRelayServerRowStatus 4
snmpset -v 2c -c private %hac_ip%  hmRelayServerInterface.%srvId% i %srvId%   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerInterface %srvId%
snmpset -v 2c -c private %hac_ip%  hmRelayServerInterface.%srvId% i  0   2>&0 1>&0
call:TEST_POSITIVE %srvId%  hmRelayServerInterface 0


set /a srvId = %srvId% + 1
snmpset -v 2c -c private -I r %hac_ip%  hmRelayServerRowStatus.%srvId% i 5   2>&0 1>&0
call:TEST_POSITIVE %srvId%   hmRelayServerRowStatus 5

set /a srvId = %srvId% + 1
snmpset -v 2c -c private -I r %hac_ip%  hmRelayServerRowStatus.%srvId% i 5   2>&0 1>&0
call:TEST_POSITIVE %srvId%   hmRelayServerRowStatus 5

set /a srvId = %srvId% + 1
snmpset -v 2c -c private -I r %hac_ip%  hmRelayServerRowStatus.%srvId% i 5   2>&0 1>&0
call:TEST_POSITIVE %srvId%   hmRelayServerRowStatus 5

set /a srvId = %srvId% + 1
snmpset -v 2c -c private -I r %hac_ip%  hmRelayServerRowStatus.%srvId% i 5   2>&0 1>&0
call:TEST_POSITIVE %srvId%   hmRelayServerRowStatus 5



set /a srvId = 17
snmpset -v 2c -c private -I r %hac_ip%  hmRelayServerRowStatus.%srvId% i 5   2>&0 1>&0
call:TEST_NEGATIVE %srvId%   hmRelayServerRowStatus 5


GOTO :END

:TEST_NEGATIVE
    echo "id %~1   %~2 %~3   %~4 %~5   %~6 %~7  err %ERRORLEVEL%"
	if NOT %ERRORLEVEL% EQU 2 (
		echo "FAILDED: id %~1 (mib val) %~2 %~3   %~4 %~5   %~6 %~7"
	)
	exit /b
	
:TEST_POSITIVE
    echo "id %~1   %~2 %~3   %~4 %~5   %~6 %~7  err %ERRORLEVEL%"
	if NOT %ERRORLEVEL% EQU 0 (
		echo "FAILDED: id %~1 (mib val) %~2 %~3   %~4 %~5   %~6 %~7"
	)
	exit /b
	

:END
ENDLOCAL





