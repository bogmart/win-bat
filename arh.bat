@ECHO OFF
IF .%1. == .. GOTO ERR


IF NOT .%2. == .. GOTO DIR_SPECIFICAT
IF     .%2. == .. GOTO DIR_CURENT


:DIR_SPECIFICAT
7z a -t7z %1.7z -mx5 -r %2\Makefile %2\*.c %2\*.cpp %2\*.h %2\*.hpp %2\*.py %2\*.htm %2\*.java %2\*.txt
goto END


:DIR_CURENT
7z a -t7z %1.7z -mx5 -r Makefile *.c *.cpp *.h *.hpp *.py *.htm *.java *.txt
goto END


:ERR
echo.
ECHO utilizare:   arh    nume_arhiva    [cale_dorita]
ECHO                                       (implicit, este calea curenta)
@ECHO OFF
goto END


:END