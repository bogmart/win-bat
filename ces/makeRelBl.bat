set compile_start=%time%

make build_dumbtunnels=yes build_debug=no build_reduced_symbols=no build_ap_debug=yes CC_DEBUG=-g %*

@echo off
echo.
echo  compilarea a inceput la ora     %compile_start%
echo  compilarea s-a terminat la ora  %time%
echo.

set compile_start=