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
if not exist sfk.exe goto:failed

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
if /i "%false%" NEQ "" echo.
if /i "%false%" EQU "1" echo			%pfad% ist keine gÅltige Eingabe.
if /i "%false%" EQU "1" echo			Bitte versuche es erneut!
if /i "%false%" NEQ "" echo.
set pfad=
set false=
echo			Willkommen beim WiiDataDownloader Installer!
echo.
echo			Wohin soll WDD installiert werden?
echo.
echo			[1] %cd%\WDD
echo			[2] %userprofile%\Documents\WDD
echo			[3] %userprofile%\Desktop\WDD
echo			[4] %homedrive%\Program Files\WDD
echo			[5] %homedrive%\WDD
echo			[6] Eigener Pfad
echo.
if /i "%desktopshortcut%" NEQ "*" echo			[D] Desktop-Shortcut erstellen (Nein)
if /i "%desktopshortcut%" EQU "*" echo			[D] Desktop-Shortcut erstellen (Ja)
if /i "%startmenushortcut%" NEQ "*" echo			[S] StartmenÅ-Shortcut erstellen (Nein)
if /i "%startmenushortcut%" EQU "*" echo			[S] StartmenÅ-Shortcut erstellen (Ja)
echo.
echo			[0] Installation abbrechen
echo.
set /p pfad= 	Eingabe:	

if /i "%pfad%" EQU "1" (set pfad=%cd%\WDD) && (goto:install)

if /i "%pfad%" EQU "2" (set pfad=%userprofile%\Documents\WDD) && (goto:install)

if /i "%pfad%" EQU "3" (set pfad=%userprofile%\Desktop\WDD) && (goto:install)

if /i "%pfad%" EQU "4" (set pfad=%homedrive%\Program Files\WDD) && (goto:install)

if /i "%pfad%" EQU "5" (set pfad=%homedrive%\WDD) && (goto:install)

if /i "%pfad%" EQU "6" goto:setpath

if /i "%pfad%" EQU "D" goto:activatedestopshortcut
if /i "%pfad%" EQU "S" goto:activatestartmenushortcut

if /i "%pfad%" EQU "0" exit

set false=1
goto:choose

:activatedestopshortcut
if /i "%desktopshortcut%" EQU "*" (set desktopshortcut=) else (set desktopshortcut=*)
goto:choose

:activatestartmenushortcut
if /i "%startmenushortcut%" EQU "*" (set startmenushortcut=) else (set startmenushortcut=*)
goto:choose

:setpath
CLS
if /i "%false%" NEQ "" echo.
if /i "%false%" EQU "1" echo			Bitte gebe einen Pfad ein!
if /i "%false%" EQU "2" echo			%InstallPathTemp:~0,2% existiert nicht, versuche es nochmal.
if /i "%false%" EQU "3" echo			Der Pfad muss absolut sein, also mit einem
if /i "%false%" EQU "3" echo			Laufwerksbuchstaben und einem Doppelpunkt beginnen!
if /i "%false%" NEQ "" echo.
set InstallPathTemp=
set pfad=
set false=
echo			Willkommen beim WiiDataDownloader Installer!
echo.
echo			Bitte gebe einen Installationsordner ein!
echo.
echo      	 	 Beispiele:
echo         	 E:\WDD
echo          	 %USERPROFILE%\PortableApps
echo			 %homedrive%\WiiDataDownloader
echo.
echo			[1] ZurÅck
echo.
echo			[0] Installation abbrechen
echo.
echo.
set /p InstallPathTemp= 	Eingabe:	

IF "%InstallPathTemp%"=="" set false=1
IF "%InstallPathTemp%"=="" goto:setpath

if /i "%InstallPathTemp%" EQU "1" goto:choose
if /i "%InstallPathTemp%" EQU "0" exit

::<---- Entferne AnfÅhrungszeichen vom Pfad (falls vorhanden) ---->
echo "set InstallPathTemp=%InstallPathTemp%">%TEMP%\install.txt
sfk filter -quiet %TEMP%\install.txt -rep _""""__>%TEMP%\install.bat
call %TEMP%\install.bat
del %TEMP%\install.bat>nul
del %TEMP%\install.txt>nul

:doublecheck
set fixslash=
if /i "%InstallPathTemp:~-1%" EQU "\" set fixslash=y
if /i "%InstallPathTemp:~-1%" EQU "/" set fixslash=y
if /i "%fixslash%" EQU "y" set InstallPathTemp=%InstallPathTemp:~0,-1%
if /i "%fixslash%" EQU "y" goto:doublecheck

::<---- Wenn der zweite Buchstabe ein Doppelpunkt ist, prÅfe nach, ob das GerÑt existiert ---->
if /i "%InstallPathTemp:~1,1%" NEQ ":" (set false=3) && (goto:setpath)
if exist "%InstallPathTemp:~0,2%" (goto:skipcheck) else (set false=2)
goto:setpath
:skipcheck
set pfad=%InstallPathTemp%
goto:install

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
echo				  DrÅcke eine Taste!
pause >NUL
exit