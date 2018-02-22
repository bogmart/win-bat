@echo off

set nr_linii=100

IF NOT .%1. == .. set nr_linii=%1

printf "creaza %nr_linii% linii si 10 coloane intr-un fisier" > fisier.txt
for /l %%i in (1,1,%nr_linii%) do (
printf "\n%%i" >> fisier.txt
for /l %%j in (1,1,9) do printf "\t%%i" >> fisier.txt
)