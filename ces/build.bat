set BUILD_DISK=S
set DOTLEVEL=888
set EAC_VERSION=800
set VERSION=V08_00

set BUILD_BASE=%BUILD_DISK%:
set CESVXW_SITE_LOCATION=itc
set CLEARCASE_PRIMARY_GROUP=ces
set COPYCMD=/Y
set BLENVOK=FALSE
set BASELEVEL=BL%DOTLEVEL%
set BUILDVERSION=%VERSION%.%DOTLEVEL%
set NEWOAK_BASE=%BUILD_BASE%
set VXCOREFTP_KIT_RELEASE_AREA=%BUILD_DISK%:\floppy\vxcoreftp_kit_release_area
set CES600_KIT_RELEASE_AREA=%BUILD_DISK%:\floppy\ces600_kit_release_area
set FLOPPY_KIT_RELEASE_AREA=%BUILD_DISK%:\floppy\floppy_kit_release_area


REM ==================Make Vxworks============================

cd \malibu\server

call envsite_itc.bat

call blenv.bat

::This command is optional (it cleans the view private files - compiled objects: *.o, *.d from the view).
::make MKFLAGS="baselevel=%BASELEVEL% -k" -k clean_no_depends=yes clean

make MKFLAGS="baselevel=%BASELEVEL%" CC_DEBUG=-g



IF NOT EXIST techpubs goto END


REM ==================Disk 128bitcd============================

cd \malibu
set CD_DEST=128bitcd
make MKFLAGS="baselevel=%BASELEVEL%" 128bitcd_server_mkdir
make MKFLAGS="baselevel=%BASELEVEL%" 128bitcd_server
cd %NEWOAK_BASE%\malibu\%CD_DEST%\%BUILDVERSION%
make -f \malibu\makefile MKFLAGS="baselevel=%BASELEVEL%" tar_gz_create


:END