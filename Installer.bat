@echo off
COLOR 1F
set url=http://wdd.wiidatabase.de
set updates=%url%/files/update
set updatedlname=WDD.zip
set UpdateDLlink=%updates%/%updatedlname%
set offline=1
TITLE WDD Installer
(if exist "%TEMP%\dir.bat" call "%TEMP%\dir.bat") && (if exist "%TEMP%\dir.bat" del "%TEMP%\dir.bat")
cd %curdir% >NUL
if not exist wget.exe goto:failed
if not exist 7za.exe goto:failed

:top
CLS
echo		Willkommen beim WiiDataDownloader Installer!
echo					Bitte warte!
start /min/wait wget -t 3 "%updates%/initialize.bat"
if exist initialize.bat call initialize.bat
if /i "%offline%" EQU "1" goto:failed
del initialize.bat
if exist %updatedlname% del %updatedlname%
echo		 Wir downloaden gerade die neueste Version... (v%newversion%)
start /min/wait wget -t 3 "%UpdateDLlink%"
if not exist %updatedlname% goto:failed

:choose
CLS
set pfad=
echo			Wohin soll WDD installiert werden?
echo.
echo			[1] %cd%\WDD
echo			[2] %userprofile%\Documents\WDD
echo			[3] %userprofile%\Desktop\WDD
echo			[4] %homedrive%\Program Files\WDD
echo			[5] %homedrive%\WDD
echo.
set /p pfad= 	Eingabe:		

if /i "%pfad%" EQU "1" (set pfad=%cd%\WDD) && (goto:install)

if /i "%pfad%" EQU "2" (set pfad=%userprofile%\Documents\WDD) && (goto:install)

if /i "%pfad%" EQU "3" (set pfad=%userprofile%\Desktop\WDD) && (goto:install)

if /i "%pfad%" EQU "4" (set (pfad=%homedrive%\Program Files\WDD) && (goto:install)

if /i "%pfad%" EQU "5" (set pfad=%homedrive%\WDD) && (goto:install)

goto:choose

:install
CLS
echo				 OK! Wir installieren WDD in:
echo 			%pfad%
echo						Entpacke...
if not exist "%pfad%" mkdir "%pfad%"
start /min/wait 7za x -aoa %updatedlname% -o"%pfad%" -r
del %updatedlname%
:ende
echo.
echo						Starte WDD...
echo set curdir=%pfad%>>%TEMP%\dir.bat
(cd %pfad%) && (start WDD.bat)
exit

:failed
echo.
echo				Installation fehlgeschlagen!
echo				  Druecke eine Taste!
pause >NUL
exit