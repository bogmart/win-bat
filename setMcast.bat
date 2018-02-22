@ECHO OFF

SETLOCAL

set hac_ip=10.20.20.20

IF NOT .. == .%1.  set hac_ip=%1

:MulticastRouting
snmpset -v 2c -c private  %hac_ip%  hm2AgentMulticastRoutingAdminMode.0 i 1


:IGMP
snmpset -v 2c -c private  %hac_ip%  hm2AgentMulticastIGMPAdminMode.0 i 1
::slot 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.1.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.2.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.3.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.4.1 i 1
::slot 2
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.5.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.6.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.7.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.8.1 i 1
::slot 3
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.9.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.10.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.11.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.12.1 i 1
::slot 4
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.13.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.14.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.15.1 i 1
snmpset -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus.16.1 i 1

snmpwalk -v 2c -c private  %hac_ip%  mgmdRouterInterfaceStatus


:PIM-SM
snmpset -v 2c -c private  %hac_ip%  hm2AgentMulticastPIMSMAdminMode.0 i 1
::slot 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.1.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.2.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.3.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.4.1 i 1
::slot 2
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.5.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.6.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.7.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.8.1 i 1
::slot 3
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.9.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.10.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.11.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.12.1 i 1
::slot 4
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.13.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.14.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.15.1 i 1
snmpset -v 2c -c private  %hac_ip%  pimInterfaceStatus.16.1 i 1

snmpwalk -v 2c -c private  %hac_ip% pimInterfaceStatus


:PIM-SM__RP-static
set grpPrefix=8

::set grp=234.0.0.0
::set rpAddr=0x0a020104
::snmpset -v 2c -c private  %hac_ip%  pimStaticRPRowStatus.1.4.%grp%.%grpPrefix% i 4 pimStaticRPRPAddress.1.4.%grp%.%grpPrefix% x %rpAddr%

set grp=235.0.0.0
set rpAddr=0x0a020105
snmpset -v 2c -c private  %hac_ip%  pimStaticRPRowStatus.1.4.%grp%.%grpPrefix% i 4 pimStaticRPRPAddress.1.4.%grp%.%grpPrefix% x %rpAddr%

set grp=236.0.0.0
set rpAddr=0x0a020806
snmpset -v 2c -c private  %hac_ip%  pimStaticRPRowStatus.1.4.%grp%.%grpPrefix% i 4 pimStaticRPRPAddress.1.4.%grp%.%grpPrefix% x %rpAddr%

set grp=237.0.0.0
set rpAddr=0x0a020314
snmpset -v 2c -c private  %hac_ip%  pimStaticRPRowStatus.1.4.%grp%.%grpPrefix% i 4 pimStaticRPRPAddress.1.4.%grp%.%grpPrefix% x %rpAddr%

set grp=238.0.0.0
set rpAddr=0x0a020616
snmpset -v 2c -c private  %hac_ip%  pimStaticRPRowStatus.1.4.%grp%.%grpPrefix% i 4 pimStaticRPRPAddress.1.4.%grp%.%grpPrefix% x %rpAddr%

set grp=239.0.0.0
set rpAddr=0x0a020315
snmpset -v 2c -c private  %hac_ip%  pimStaticRPRowStatus.1.4.%grp%.%grpPrefix% i 4 pimStaticRPRPAddress.1.4.%grp%.%grpPrefix% x %rpAddr%

::snmpwalk -v 2c -c private  %hac_ip% pimStaticRPRowStatus
::snmpwalk -v 2c -c private  %hac_ip% pimStaticRPRPAddress
snmpwalk -v 2c -c private  %hac_ip% pimGroupMappingPimMode


:PIM-SM__RP-candidate
::#define L7_PIMSM_CRP_ADVERTISEMENT_INTERVAL 60
set /a candRPInterval = 60
set /a grpPrefix = 8

if .%hac_ip%. == .10.20.20.20. (
  set grp=227.0.0.0
  set rpCandAddr=10.2.3.20
  )
if .%hac_ip%. == .10.20.20.21. (
  set grp=229.0.0.0
  set rpCandAddr=10.2.3.21
  )
if .%hac_ip%. == .10.20.20.22. (
  set grp=228.0.0.0
  set rpCandAddr=10.2.6.22
  )
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%

::goto END




:PIM-SM__BSR-candidate
::ATENTIE: pimBsrCandidateBSRAdvInterval  este din alt MIB   FASTPATH-MULTICAST-MIB  !!!
::#define L7_PIMSM_CBSR_PRIORITY         0
::#define L7_PIMSM_CBSR_HASH_MASK_LENGTH   30
::#define L7_PIMSM_CBSR_ADVERTISEMENT_INTERVAL 60
set /a bsrCandPrio = 0
set /a bsrCandHashMask = 30
set /a bsrCandInterval = 60
set /a  zoneIndex = 1

if .%hac_ip%. == .10.20.20.20. (
  set bsrCandAddr=0x0a020314
  )
if .%hac_ip%. == .10.20.20.21. (
  set bsrCandAddr=0x0a020315
  )
if .%hac_ip%. == .10.20.20.22. (
  ::set bsrCandAddr=0x0a020616
  GOTO END
  )
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateBSRStatus.%zoneIndex% i 4 pimBsrCandidateBSRAddressType.%zoneIndex% i 1 pimBsrCandidateBSRAddress.%zoneIndex% x %bsrCandAddr%   pimBsrCandidateBSRPriority.%zoneIndex% u %bsrCandPrio% pimBsrCandidateBSRHashMaskLength.%zoneIndex% u %bsrCandHashMask%  pimBsrCandidateBSRAdvInterval.%zoneIndex% u %bsrCandInterval%


:END
ENDLOCAL