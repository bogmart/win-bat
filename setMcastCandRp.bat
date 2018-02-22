@ECHO OFF

SETLOCAL

set hac_ip=10.20.20.20

IF NOT .. == .%1.  set hac_ip=%1


:PIM-SM__RP-candidate
::#define L7_PIMSM_CRP_ADVERTISEMENT_INTERVAL 60
set /a candRPInterval = 60
set /a grpPrefix = 8

if .%hac_ip%. == .10.20.20.20. (
  set rpCandAddr=10.2.3.20
  )
if .%hac_ip%. == .10.20.20.21. (
  set rpCandAddr=10.2.3.21
  )
if .%hac_ip%. == .10.20.20.22. (
  set rpCandAddr=10.2.6.22
  )
  
GOTO Mihaela

:Bogdan_test
set grp=224.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set grp=225.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set grp=226.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set grp=227.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set grp=228.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set grp=229.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
goto END


:Mihaela
set /a grpPrefix = 8
set grp=230.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set /a grpPrefix = 16
set grp=230.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set /a grpPrefix = 24
set grp=230.0.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set /a grpPrefix = 16
set grp=230.1.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set /a grpPrefix = 24
set grp=230.1.0.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
set /a grpPrefix = 24
set grp=230.1.1.0
snmpset -v 2c -c private  %hac_ip%  pimBsrCandidateRPStatus.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% i 4 pimBsrCandidateRPAdvInterval.1.4.%rpCandAddr%.4.%grp%.%grpPrefix% u %candRPInterval%
goto END






:END
ENDLOCAL