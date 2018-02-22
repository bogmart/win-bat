::Hello
::since the December update of MS office some people reported,
::that the "document control" button in our MOD template does not work anymore.
::If you have the same problem you can try the attached batch file to repair it.
::It removes some temporary files that the update didn't delete.
::Please close MS office before executing.
:: Best regards
::    Heiko

del %temp%\vbe\*.exd
del %temp%\excel8.0\*.exd
del %appdata%\microsoft\forms\*.exd
del %appdata%\microsoft\local\*.exd
del %temp%\word8.0\*.exd
del %temp%\PPT11.0\*.exd
