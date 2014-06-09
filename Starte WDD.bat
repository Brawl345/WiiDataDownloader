@echo off
@prompt -$G
COLOR 1F
TITLE Starte WDD...
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 set OS=XP
if /i "%OS%" EQU "XP" goto:xp
TITLE Bitte warten...
echo set curdir=%cd%>>%TEMP%\dir.bat
echo Set UAC = CreateObject("Shell.Application") >%TEMP%\uac.vbs
echo UAC.ShellExecute "WDD.bat", "", "", "runas", 1 >>%TEMP%\uac.vbs
"%TEMP%\uac.vbs"
del %TEMP%\uac.vbs
exit

:xp
start WDD.bat
exit
