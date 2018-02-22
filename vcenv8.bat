@ECHO OFF

::env for VC_8
::se apeleaza:  C:\Program Files\Microsoft Visual Studio 8\Common7\Tools\vsvars32.bat
call "C:\Program Files\Microsoft Visual Studio 8\VC\vcvarsall.bat" x86


::env for SDK_2003
call "C:\Program Files\Microsoft Platform SDK for Windows Server 2003 R2\SetEnv.Cmd" /XP32 /RETAIL

