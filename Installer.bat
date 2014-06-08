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
echo			Willkommen beim WiiDataDownloader Installer!
echo					Bitte warte!
start /min/wait wget -t 3 "%updates%/initialize.bat"
if exist initialize.bat call initialize.bat
if /i "%offline%" EQU "1" goto:failed
del initialize.bat
if exist %updatedlname% del %updatedlname%

:choose
CLS
set pfad=
echo			Willkommen beim WiiDataDownloader Installer!
echo.
echo			Wohin soll WDD installiert werden?
echo.
echo			[1] %cd%\WDD
echo			[2] %userprofile%\Documents\WDD
echo			[3] %userprofile%\Desktop\WDD
echo			[4] %homedrive%\Program Files\WDD
echo			[5] %homedrive%\WDD
echo.
if /i "%desktopshortcut%" NEQ "*" echo			[D] Desktop-Shortcut erstellen (Nein)
if /i "%desktopshortcut%" EQU "*" echo			[D] Desktop-Shortcut erstellen (Ja)
if /i "%startmenushortcut%" NEQ "*" echo			[S] Startmen-Shortcut erstellen (Nein)
if /i "%startmenushortcut%" EQU "*" echo			[S] Startmen-Shortcut erstellen (Ja)
echo.
echo			[0] Installation abbrechen
echo.
set /p pfad= 	Eingabe:		

if /i "%pfad%" EQU "1" (set pfad=%cd%\WDD) && (goto:install)

if /i "%pfad%" EQU "2" (set pfad=%userprofile%\Documents\WDD) && (goto:install)

if /i "%pfad%" EQU "3" (set pfad=%userprofile%\Desktop\WDD) && (goto:install)

if /i "%pfad%" EQU "4" (set pfad=%homedrive%\Program Files\WDD) && (goto:install)

if /i "%pfad%" EQU "5" (set pfad=%homedrive%\WDD) && (goto:install)

if /i "%pfad%" EQU "D" goto:activatedestopshortcut
if /i "%pfad%" EQU "S" goto:activatestartmenushortcut

if /i "%pfad%" EQU "0" exit

goto:choose

:activatedestopshortcut
if /i "%desktopshortcut%" EQU "*" (set desktopshortcut=) else (set desktopshortcut=*)
goto:choose

:activatestartmenushortcut
if /i "%startmenushortcut%" EQU "*" (set startmenushortcut=) else (set startmenushortcut=*)
goto:choose

:install
CLS
echo				 OK! Wir installieren WDD in:
echo 			%pfad%
echo.
echo		  Wir downloaden gerade die neueste Version... (v%newversion%)
start /min/wait wget -t 3 "%UpdateDLlink%"
if not exist %updatedlname% goto:failed
echo.
echo					Entpacke...
if not exist "%pfad%" mkdir "%pfad%"
start /min/wait 7za x -aoa %updatedlname% -o"%pfad%" -r
del %updatedlname%
if not exist "%pfad%\WDD.bat" goto:failed
if /i "%desktopshortcut%" EQU "*" "%pfad%\Support\nircmd" shortcut "%pfad%\Starte WDD.bat" "~$folder.desktop$" "WiiDataDownloader" "" "%pfad%\Support\wdd.ico"
if /i "%startmenushortcut%" EQU "*" "%pfad%\Support\nircmd" shortcut "%pfad%\Starte WDD.bat" "~$folder.programs$" "WiiDataDownloader" "" "%pfad%\Support\wdd.ico"
echo.
echo					Starte WDD...
echo set curdir=%pfad%>>%TEMP%\dir.bat
(cd %pfad%) && (start WDD.bat)
exit

:failed
echo.
echo				Installation fehlgeschlagen!
echo				  Druecke eine Taste!
pause >NUL
exit