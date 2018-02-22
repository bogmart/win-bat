@ECHO OFF

SETLOCAL

set MIBS=%MIBS%;OSPF-MIB;RFC1213-MIB;HM2-PLATFORM-ROUTING-MIB

set hac_ip=none

:IP_ITERATOR
IF .. == .%1. (
  if .%hac_ip%. == .none. (
    set hac_ip=10.20.20.20
    goto CONFIG
    )
  if %hac_ip% == 10.20.20.20 (
    set hac_ip=10.20.20.21
    goto CONFIG
    )
  if %hac_ip% == 10.20.20.21 (
    set hac_ip=10.20.20.22
    goto CONFIG
    )
  if %hac_ip% == 10.20.20.22 (
    echo DONE
    goto END
    )
  ) else (
    set hac_ip=%1
  )

:CONFIG  

if .%hac_ip%. == .10.20.20.20. (
  set ospfRouterId=0.0.0.20
  :: 1/1 is mgmt intf
  set ipAddr_1=0.0.0.0
  set ipAddr_2=0.0.0.0
  set ipAddr_3=0.0.0.0
  set ipAddr_4=10.2.4.20
  ::slot 2
  set ipAddr_5=0.0.0.0
  set ipAddr_6=0.0.0.0
  set ipAddr_7=10.2.3.20
  set ipAddr_8=10.2.2.20
  ::slot 3
  set ipAddr_9=0.0.0.0
  set ipAddr_10=0.0.0.0
  set ipAddr_11=0.0.0.0
  set ipAddr_12=0.0.0.0
  ::slot 4
  set ipAddr_13=0.0.0.0
  set ipAddr_14=0.0.0.0
  set ipAddr_15=0.0.0.0
  set ipAddr_16=0.0.0.0
  )
if .%hac_ip%. == .10.20.20.21. (
  set ospfRouterId=0.0.0.21
  :: 1/1 is mgmt intf
  set ipAddr_1=0.0.0.0
  set ipAddr_2=0.0.0.0
  set ipAddr_3=10.2.30.21
  set ipAddr_4=10.2.40.21
  ::slot 2
  set ipAddr_5=0.0.0.0
  set ipAddr_6=10.2.5.21
  set ipAddr_7=10.2.3.21
  set ipAddr_8=10.2.2.21
  ::slot 3
  set ipAddr_9=0.0.0.0
  set ipAddr_10=0.0.0.0
  set ipAddr_11=0.0.0.0
  set ipAddr_12=0.0.0.0
  ::slot 4
  set ipAddr_13=0.0.0.0
  set ipAddr_14=0.0.0.0
  set ipAddr_15=0.0.0.0
  set ipAddr_16=0.0.0.0
  )
if .%hac_ip%. == .10.20.20.22. (
  set ospfRouterId=0.0.0.22
  :: 1/1 is mgmt intf
  set ipAddr_1=0.0.0.0
  set ipAddr_2=0.0.0.0
  set ipAddr_3=10.2.3.22
  set ipAddr_4=10.2.5.22
  ::slot 2
  set ipAddr_5=0.0.0.0
  set ipAddr_6=0.0.0.0
  set ipAddr_7=0.0.0.0
  set ipAddr_8=0.0.0.0
  ::slot 3
  set ipAddr_9=0.0.0.0
  set ipAddr_10=0.0.0.0
  set ipAddr_11=0.0.0.0
  set ipAddr_12=0.0.0.0
  ::slot 4
  set ipAddr_13=0.0.0.0
  set ipAddr_14=10.2.6.22
  set ipAddr_15=0.0.0.0
  set ipAddr_16=10.2.4.22
  )

::optiongroup
::hmcfg_configEntryHandler_standardRow

:Routing_vars
:: mode = 1 --> enable   
:: mode = 2 --> disable
set /a routingMode = 1

set mask_8bit=255.0.0.0
set mask_16bit=255.255.0.0
set mask_24bit=255.255.255.0

GOTO OSPF_global

:Routing_global
snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpRoutingMode.0 i %routingMode%

:Routing_intf

IF NOT %ipAddr_1% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.1 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.1   a %ipAddr_1%  hm2AgentSwitchIpInterfaceNetMask.1     a %mask_24bit%
  )
IF NOT %ipAddr_2% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.2 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.2   a %ipAddr_2%  hm2AgentSwitchIpInterfaceNetMask.2     a %mask_24bit%
  )
IF NOT %ipAddr_3% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.3 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.3   a %ipAddr_3%  hm2AgentSwitchIpInterfaceNetMask.3     a %mask_24bit%
  )
IF NOT %ipAddr_4% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.4 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.4   a %ipAddr_4%  hm2AgentSwitchIpInterfaceNetMask.4     a %mask_24bit%
  )
::slot 2
IF NOT %ipAddr_5% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.5 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.5   a %ipAddr_5%  hm2AgentSwitchIpInterfaceNetMask.5     a %mask_24bit%
  )
IF NOT %ipAddr_6% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.6 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.6   a %ipAddr_6%  hm2AgentSwitchIpInterfaceNetMask.6     a %mask_24bit%
  )
IF NOT %ipAddr_7% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.7 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.7   a %ipAddr_7%  hm2AgentSwitchIpInterfaceNetMask.7     a %mask_24bit%
  )
IF NOT %ipAddr_8% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.8 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.8   a %ipAddr_8%  hm2AgentSwitchIpInterfaceNetMask.8     a %mask_24bit%
  )
::slot 3
IF NOT %ipAddr_9% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.9 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.9   a %ipAddr_9%  hm2AgentSwitchIpInterfaceNetMask.9     a %mask_24bit%
  )
IF NOT %ipAddr_10% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.10 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.10   a %ipAddr_10%  hm2AgentSwitchIpInterfaceNetMask.10     a %mask_24bit%
  )
IF NOT %ipAddr_11% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.11 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.11   a %ipAddr_11%  hm2AgentSwitchIpInterfaceNetMask.11     a %mask_24bit%
  )
IF NOT %ipAddr_12% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.12 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.12   a %ipAddr_12%  hm2AgentSwitchIpInterfaceNetMask.12     a %mask_24bit%
  )
::slot 4
IF NOT %ipAddr_13% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.13 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.13   a %ipAddr_13%  hm2AgentSwitchIpInterfaceNetMask.13     a %mask_24bit%
  )
IF NOT %ipAddr_14% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.14 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.14   a %ipAddr_14%  hm2AgentSwitchIpInterfaceNetMask.14     a %mask_24bit%
  )
IF NOT %ipAddr_15% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.15 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.15   a %ipAddr_15%  hm2AgentSwitchIpInterfaceNetMask.15     a %mask_24bit%
  )
IF NOT %ipAddr_16% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode.16 i %routingMode%
  snmpset -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceIpAddress.16   a %ipAddr_16%  hm2AgentSwitchIpInterfaceNetMask.16     a %mask_24bit%
  )

snmpwalk -v 2c -c private  %hac_ip%  hm2AgentSwitchIpInterfaceRoutingMode



:OSPF_global
snmpset -v 2c -c private  %hac_ip%  ospfAdminStat.0 i 1
snmpset -v 2c -c private  %hac_ip%  ospfRouterId.0 a %ospfRouterId%

:OSPF_intf
IF NOT %ipAddr_1% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_1%.1 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_1%.1 i 1
  )
IF NOT %ipAddr_2% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_2%.2 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_2%.2 i 1
  )
IF NOT %ipAddr_3% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_3%.3 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_3%.3 i 1
  )
IF NOT %ipAddr_4% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_4%.4 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_4%.4 i 1
  )
::slot 2
IF NOT %ipAddr_5% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_5%.5 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_5%.5 i 1
  )
IF NOT %ipAddr_6% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_6%.6 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_6%.6 i 1
  )
IF NOT %ipAddr_7% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_7%.7 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_7%.7 i 1
  )
IF NOT %ipAddr_8% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_8%.8 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_8%.8 i 1
  )
::slot 3
IF NOT %ipAddr_9% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_9%.9 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_9%.9 i 1
  )
IF NOT %ipAddr_10% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_10%.10 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_10%.10 i 1
  )
IF NOT %ipAddr_11% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_11%.11 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_11%.11 i 1
  )
IF NOT %ipAddr_12% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_12%.12 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_12%.12 i 1
  )
::slot 4
IF NOT %ipAddr_13% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_13%.13 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_13%.13 i 1
  )
IF NOT %ipAddr_14% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_14%.14 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_14%.14 i 1
  )
IF NOT %ipAddr_15% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_15%.15 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_15%.15 i 1
  )
IF NOT %ipAddr_16% == 0.0.0.0 (
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_16%.16 i 4
  snmpset -v 2c -c private  %hac_ip%  ospfIfStatus.%ipAddr_16%.16 i 1
  )

snmpwalk -v 2c -c private  %hac_ip% ospfIfStatus


if .%1. == .. (
  echo.
  echo.
  goto IP_ITERATOR
  )


goto END


:END
ENDLOCAL