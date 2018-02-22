@ECHO OFF
SETLOCAL

IF .%1. == ..    goto HELP
IF .%1. == .-h.  goto HELP
IF .%1. == .-H.  goto HELP
IF .%1. == ./?.  goto HELP

IF  NOT .%2. == ..   (
    pushd
    cd %2
    )

grep -r %1 --include=*dump.txt . | sed "s/.corefile.dump.txt:/: 0x/"
IF  NOT .%2. == ..   (
    popd
    )
GOTO END


:HELP
    echo.
    ECHO usage:     %0  symbol_name [ path_to_corefile ]
    ECHO ex:        %0  close
    ECHO ex:        %0  " close$"
    ECHO ex:        %0  close        mach4k3a_MR/images
    echo.
    @ECHO OFF
    GOTO END


:END
ENDLOCAL