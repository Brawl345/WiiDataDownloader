@echo off
@prompt -$G
COLOR 1F
TITLE Starte den WDD Installer...
ver | findstr /i "5\.1\." > nul
IF %ERRORLEVEL% EQU 0 set OS=XP
if /i "%OS%" EQU "XP" goto:xp
echo set curdir=%cd%>>%TEMP%\dir.bat
echo Bitte warte auf die UAC...
echo Set UAC = CreateObject("Shell.Application") >>tmp.vbs
echo UAC.ShellExecute "Installer.bat", "", "", "runas", 1 >>tmp.vbs
"tmp.vbs"
del tmp.vbs
exit

:xp
start WDD.bat
exit