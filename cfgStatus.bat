
@Echo off

setlocal EnableDelayedExpansion

set hac_ip=10.20.10.104

::Platform 4 - hmFSAction
set hmFSAction=1.3.6.1.4.1.248.14.2.4.6.0
::hmConfigurationStatus: 2 == not in sync  ;  1 == in sync
set hmConfigurationStatus=1.3.6.1.4.1.248.14.2.4.12.0

IF NOT .%1. == ..   set hac_ip=%1

for /L %%i IN (1,1,100000) DO (
  set result=0
  for /f "tokens=*" %%e in (
    'snmpget -c public -v 2c -t 1 -O vq %hac_ip% %hmConfigurationStatus%'
  ) do (
    set result=%%e
  )

  if !result! NEQ 0 (
    :: 2 == not in sync  ;  1 == in sync
    if !result! EQU 1 ( 
	  set cfgState="    in sync"
    ) else (
	  set cfgState="NOT in sync"
    )
  ) else (
    set cfgState=
  )
  
  echo !time!  !cfgState!
  
  sleep 1
)

endlocal