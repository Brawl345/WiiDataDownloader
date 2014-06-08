@echo off
@prompt -$G
COLOR 1F
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 set OS=XP
if /i "%OS%" EQU "XP" goto:xp
TITLE Bitte warten...
echo set curdir=%cd%>>%TEMP%\dir.bat
echo Set UAC = CreateObject("Shell.Application") >>%TEMP%\dir.vbs
echo UAC.ShellExecute "WDD.bat", "", "", "runas", 1 >>%TEMP%\dir.vbs
"%TEMP%\dir.vbs"
del %TEMP%\dir.vbs
exit

:xp
start WDD.bat
exit