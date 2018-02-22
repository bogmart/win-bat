@ECHO OFF

::Examples:
::natCfg add
::natCfg del
::natCfg add  10.20.10.23   10  200


SETLOCAL  EnableDelayedExpansion

set MIBS=%MIBS%;HM2-NAT-MIB

::please update the path
set MIBDIRS=%MIBDIRS%;S:\bogmart_workbench\p5_hac_shared\mibs\hirschmann

if NOT .. == .%1.  set action=%1
call :toupper action

::DUT's IP default
set hac_ip=10.20.20.23
::DUT's IP
IF NOT .. == .%2.  set hac_ip=%2

::mask len
set /a maskLenMin = 24
set /a maskLenMax = 32

::start and end indexes
set /a rowIndex=1
set /a rowIndexMax=256
IF NOT .. == .%3.  set rowIndex=%3
IF NOT .. == .%4.  set rowIndexMax=%4


if .!action!. == .ADD.       GOTO   ROW_ADD
if .!action!. == .DEL.       GOTO   ROW_DEL
if .!action!. == .ENA.       GOTO   ROW_ENABLE
if .!action!. == .DIS.       GOTO   ROW_DISABLE
if .!action!. == .ALG_ENA.   GOTO   ALG_ENABLE
if .!action!. == .ALG_DIS.   GOTO   ALG_DISABLE
if .!action!. == .DESCR.     GOTO   ROW_DESCRIPTION
GOTO HELP


:ALG_ENABLE
::enable ICMP + FTP ALGs
snmpset -v 2c -c private  %hac_ip%  hm21to1Alg.0 b ftp,icmp
GOTO END

:ALG_DISABLE
::disable  FTP ALGs
snmpset -v 2c -c private  %hac_ip%  hm21to1Alg.0 b icmp
::reset public interface
::snmpset -v 2c -c private  %hac_ip% hm21to1PublicIntf.0  i 0
GOTO END


:ROW_ADD
::interface (first vlan routing)
set rowIntf=91
snmpset -v 2c -c private  %hac_ip% hm21to1PublicIntf.0  i !rowIntf!


:ROW_SET_ADD
set /a subNet  = 64 * (!rowIndex! / 256)
set /a bit25   = (!subNet! ^& 128) / 128
set /a bit26   = (!subNet! ^& 64)  / 64
set /a bit25_26= !bit25! + !bit26!*(2 - !bit25!)
set /a maskLen = !maskLenMin! + !bit25_26! + !rowIndex! %% (!maskLenMax! - !maskLenMin! + 1 - !bit25_26!)
set /a net     = !rowIndex! %% 256
::echo maskLen: !maskLen!   net: !net!   subNet: !subNet!   bit25: !bit25!   bit26: !bit26!   bit25_26: !bit25_26!

::source net
set rowTargetAddress=192.168.!net!.!subNet!/!maskLen!
::destination net
set rowNewTargetAddress=10.100.!net!.!subNet!/!maskLen!
::description
set rowDescription=rule_!rowIndex!

set /a rowIndexModulo20 = !rowIndex! %% 20
set /a rowIndexModulo10 = !rowIndex! %% 10
if !rowIndexModulo20! EQU 0 (
	::create row
	snmpset -v 2c -c private  %hac_ip% hm21to1RowStatus.!rowIndex!        i 5  
	::update fields
	snmpset -v 2c -c private  %hac_ip% hm21to1TargetAddress.!rowIndex!    s !rowTargetAddress!
	snmpset -v 2c -c private  %hac_ip% hm21to1NewTargetAddress.!rowIndex! s !rowNewTargetAddress!
	snmpset -v 2c -c private  %hac_ip% hm21to1Description.!rowIndex!      s !rowDescription!
	::activate row
	snmpset -v 2c -c private  %hac_ip% hm21to1RowStatus.!rowIndex!        i 1
  ) else (
		if !rowIndexModulo10! EQU 0 (
			::create row
			snmpset -v 2c -c private  %hac_ip% hm21to1RowStatus.!rowIndex! i 5  
			::update fields
			snmpset -v 2c -c private  %hac_ip% hm21to1TargetAddress.!rowIndex! s !rowTargetAddress!   hm21to1NewTargetAddress.!rowIndex! s !rowNewTargetAddress!    hm21to1Description.!rowIndex!      s !rowDescription!
			::activate row
			snmpset -v 2c -c private  %hac_ip% hm21to1RowStatus.!rowIndex! i 1
		) else (
			snmpset  -v 2c -c private %hac_ip%  hm21to1RowStatus.!rowIndex! i 4   hm21to1TargetAddress.!rowIndex! s !rowTargetAddress!  hm21to1NewTargetAddress.!rowIndex! s !rowNewTargetAddress!
		)
  )

set /a rowIndex = !rowIndex! + 1
if !rowIndex! LEQ !rowIndexMax!  (
    GOTO ROW_SET_ADD
  ) else (
    GOTO END
  )


:ROW_DEL
:ROW_SET_DEL
::destroy row
snmpset -v 2c -c private  %hac_ip% hm21to1RowStatus.!rowIndex!        i 6  

set /a rowIndex = !rowIndex! + 1
if !rowIndex! LEQ %rowIndexMax% (
    GOTO ROW_SET_DEL
  ) else (
    GOTO END
  )

:ROW_ENABLE
:ROW_SET_ENABLE
::activate row
snmpset -v 2c -c private  %hac_ip% hm21to1RowStatus.!rowIndex!        i 1  

set /a rowIndex = !rowIndex! + 1
if !rowIndex! LEQ %rowIndexMax% (
    GOTO ROW_SET_ENABLE
  ) else (
    GOTO END
  )

:ROW_DISABLE
:ROW_SET_DISABLE
::deactivate row
snmpset -v 2c -c private  %hac_ip% hm21to1RowStatus.!rowIndex!        i 2  

set /a rowIndex = !rowIndex! + 1
if !rowIndex! LEQ %rowIndexMax% (
    GOTO ROW_SET_DISABLE
  ) else (
    GOTO END
  )
  
:ROW_DESCRIPTION
:ROW_SET_DESCRIPTION
::description
set rowDescription=rule_!rowIndex!
snmpset -v 2c -c private  %hac_ip% hm21to1Description.!rowIndex!        s !rowDescription!

set /a rowIndex = !rowIndex! + 1
if !rowIndex! LEQ %rowIndexMax% (
    GOTO ROW_SET_DESCRIPTION
  ) else (
    GOTO END
  )


:HELP
   echo.
   ECHO usage:   %0  [add/del/ena/dis/alg_ena/alg_dis/descr] [HAC_IP_Address]  [start_index] [end_index]
   ECHO       ( default:     -                                %hac_ip%       %rowIndex%             %rowIndexMax% )
   echo.
   @ECHO OFF
   GOTO END
GOTO END

:toupper
   for %%L IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO SET %1=!%1:%%L=%%L!
   goto :EOF

:tolower
   for %%L IN (a b c d e f g h i j k l m n o p q r s t u v w x y z) DO SET %1=!%1:%%L=%%L!
   goto :EOF

:END
ENDLOCAL