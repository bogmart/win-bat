@echo off


if .%1. == .buricea. (
  set ip=10.2.6.35
  set mac=00:14:85:0c:5d:20
  goto test_send_real_mac
)

if .%1. == .jock. (
  set ip=10.2.5.152
  set mac=00:14:85:3f:71:06
  goto test_send_real_mac
)


if .%1. == .ciprian. (
  set ip=10.2.5.184
  set mac=00:0d:61:3c:cf:ce
  goto test_send_real_mac
)

if .%1. == .josephine. ( ::mene
  set ip=10.2.4.192
  set mac=00:0f:ea:5d:e0:0b
  goto test_send_real_mac
)

if .%1. == .vili. (
  set ip=10.2.4.86
  set mac=00:e0:18:e5:b5:62
  goto test_send_real_mac
)


::linux

if .%1. == .dbadea. (
  set ip=10.2.5.173
  set mac=00:13:20:54:82:fb
  goto test_send_real_mac
)

if .%1. == .ancristi. (
  set ip=10.2.5.44
  set mac=00:0f:ea:34:a0:e5
  goto test_send_real_mac
)


goto help


:test_send_real_mac
  if     .%2. == .set. goto send_real_mac
  if not .%2. == .set. goto send

:send_real_mac
  nemesis arp -S 10.2.5.188 -D %ip% -h 00:0D:61:AA:05:1E -m 00:00:00:00:00:00 -r -H 00:0D:61:AA:05:1E -M %mac%
  goto end


:send
  nemesis arp -S 10.2.5.188 -D %ip% -h 00:0D:61:AA:05:1E -m 00:00:00:00:00:00 -r -H 00:0D:61:AA:05:1E -M %mac%
  msleep %2
  nemesis arp -S 10.2.5.188 -D %ip% -h 00:0D:61:AA:05:EE -m 00:00:00:00:00:00 -r -H 00:0D:61:AA:05:1E -M %mac%
  goto end


:help
  echo.
  echo Verifica timpul minim pentru care 2 pachete ARP cu aceasi destinatie "ip" sunt acceptate.
  echo Nota: windows-ul accepta oricat de repede, linux-ul are un interval de 1 secunda.
  echo.
  echo Utilizare:
  echo   arp hostname wait_msec
  echo   arp hostname set
  echo.

:end


