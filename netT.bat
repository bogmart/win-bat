@ECHO OFF 

IF .%1. == ..  GOTO NET_ADD

IF .%1. == .d.  GOTO NET_DEL
IF .%1. == .D.  GOTO NET_DEL

IF .%1. == .-h.  GOTO HELP

GOTO END


:NET_ADD
net use T: \\stanescu\
GOTO END


:NET_DEL
net use T: /DELETE
GOTO END


:HELP
@echo.
@echo sorin mtrace
@echo netT       == add
@echo netT d[D]  == delete
@echo.
GOTO END


:END

