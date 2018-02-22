@ECHO OFF
SETLOCAL

for /R %%G in (*corefile) do (
  ::gdbppc --batch  "%%G" -x endian_gdb.txt
  ECHO "%%G" | findstr "fastboot slowboot boot dump _ABB_ _GC_ _GE_ Schneider" 1>nul
  IF errorlevel 1 (
    ECHO "%%G" 
    readelf -h "%%G" | grep "Data:" | cut -d, -f2
    ECHO(
  )
)


REM "D:\versiuni\P4\v9.0\B11\m1000geL3P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m100geL2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m100geL3P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m100L2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m4002L2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m4002L3E.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m4002L3P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m4002xgL2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m4002xgL3E.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\m4002xgL3P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\marL2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\miceL2E.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\miceL2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\octL2E.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\octL2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\osL2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\pmL2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\pmL3E.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\pmL3P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\rsL2E.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\rsL2P.corefile"
 REM big endian

REM "D:\versiuni\P4\v9.0\B11\rsrL2P.corefile"
 REM big endian


REM "D:\versiuni\P5_v5\a21\msp\msp2a_corefile"
 REM big endian

REM "D:\versiuni\P5_v5\endianness\EES\debugging_files\ees_corefile"
 REM little endian

REM "D:\versiuni\P5_v5\endianness\EESX\debugging_files\eesx_corefile"
 REM little endian

REM "D:\versiuni\P5_v5\endianness\GRS\debugging_files\grs_corefile"
 REM little endian

REM "D:\versiuni\P5_v5\endianness\MSP\debugging_files\msp2a_corefile"
 REM big endian

REM "D:\versiuni\P5_v5\endianness\OCTOPUS\debugging_files\os22a_corefile"
 REM big endian

REM "D:\versiuni\P5_v5\endianness\RED\debugging_files\red_corefile"
 REM little endian

REM "D:\versiuni\P5_v5\endianness\RSP\debugging_files\rsp2a_corefile"
 REM big endian

REM "D:\versiuni\P5_v5\endianness\RSP\debugging_files\rsp2s_corefile"
 REM big endian

REM "D:\versiuni\P5_v5\endianness\RSPE\debugging_files\rspe2a_corefile"
 REM big endian

REM "D:\versiuni\P5_v5\endianness\RSPL\debugging_files\rspl_corefile"
 REM little endian

REM "D:\versiuni\P5_v5\endianness\RSPS\debugging_files\rsps_corefile"
 REM little endian


ENDLOCAL