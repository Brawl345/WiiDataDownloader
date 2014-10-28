@echo off
:top
CLS
::<---- Ins WDD Verzeichnis wechseln ---->
(if exist "%TEMP%\dir.bat" call "%TEMP%\dir.bat") && (if exist "%TEMP%\dir.bat" del "%TEMP%\dir.bat")
cd %curdir% >NUL
COLOR 1F

::<---- Versionsinformationen ---->
set currentversion=425
set build=Pre-Alpha
set WDDpath=%cd%

::<---- URLs -->
set url=http://wdd.wiidatabase.de
set files=%url%/files
set updates=%files%/update
set updatedlname=WDD.zip
set UpdateDLlink=%updates%/%updatedlname%
set Header=echo	    WiiDataDownloader %build% r%currentversion% - Heute ist der %DATE%
mode con cols=85 lines=30
TITLE WDD %build%-%currentversion%

::<---- Überprüfen, ob die Supportdateien existieren ---->
:check
if not exist Support\nusd.exe goto:fehlt
if not exist Support\sfk.exe goto:fehlt
if not exist Support\dialogs goto:fehlt
if not exist Support\wdd.ico goto:fehlt
if not exist Support\nircmd.exe goto:fehlt
if not exist Support\wget.exe goto:fehlt
if not exist Support\7za.exe goto:fehlt
goto:title
:fehlt
CLS
%header%
TITLE Wichtige Daten fehlen
echo.
echo.
echo.
echo		Eine oder mehrere notwendige Dateien fehlen.
echo		Fge bitte eine Ausnahme in deinem Antivirenprogramm
echo		fr ALLE Supportdateien hinzu!
echo		Bitte downloade WDDs Support-Daten nun neu!
echo		Besuche %url%
echo.
echo														WDD wird mit einem Tastendruck beendet.
pause >NUL
exit

:title
if not exist temp md temp
::<---- Laden der Optionen ---->
if exist temp\Optionen.bat call temp\Optionen.bat

:onlinecheck
set offline=1
CLS
if /i "%skipchecks%" EQU "1" goto:skipthings
%header%
echo.
echo			Initialisieren...
start /min/wait Support\wget -t 3 "%updates%/initialize.bat"
if exist initialize.bat call initialize.bat
if /i "%offline%" EQU "1" goto:offline
del initialize.bat
::<---- Auto-Updater ---->
TITLE WDD - Suche nach Updates...
if /i "%newversion%" EQU "" goto:failed
if /i "%currentversion%" EQU "%newversion%" goto:aktuell
if /i "%currentversion%" GEQ "%newversion%" goto:neuer
if /i "%currentversion%" NEQ "%newversion%" goto:update

:failed
CLS
TITLE WDD - Das Update ist fehlgeschlagen
%header%
echo.
echo			Die Suche nach Updates ist fehlgeschlagen!
echo		 berprfe deine Internet Verbindung und deine Firewall!
@ping 127.0.0.1 -n 3 -w 1000> nul
goto:menu
:aktuell
(set update=aktuell) && (goto:menu)
:neuer
cls
%header%
echo.
Support\sfk echo -spat \x20 \x20 \x20 \x20 \x20 \x20 \x20 [Yellow] Das Update ist fehlgeschlagen!
Support\sfk echo -spat \x20  \x20 \x20 \x20 \x20 \x20 \x20 [Yellow] Bitte stelle die Version zurck!
echo.
echo				Aktuelle Version: %newversion%
echo				Deine    Version: %currentversion%
@ping 127.0.0.1 -n 3 -w 1000> nul
goto:menu
:update
cls
%header%
Support\sfk echo -spat \x20 \x20 \x20 [Red] Deine Version ist nicht aktuell!
start Support\dialogs\update.vbs
echo.
echo			WDD aktualisiert sich jetzt auf v%newversion%...
start /min/wait support\wget -t 3 -O WDD.zip "%UpdateDLlink%"
echo.
Support\7za x -aoa WDD.zip -r
start Support\dialogs\update_erfolgreich.vbs
del WDD.zip
echo.
goto:top


:offline
CLS
%header%
echo.
echo 			Du bist offline :(
echo			Bitte gehe wieder online.
echo		 Beende WDD mit einem Tastendruck...
pause >NUL
exit
:skipthings
(set update=skipped) && (goto:menu)

:menu
CLS
mode con cols=85 lines=30
TITLE WDD - W„hle eine Aktion...
%header%
echo.
if /i "%false%" EQU "1" (echo.) && (echo		 %menu% ist keine gltige Eingabe.) && (echo		 Bitte versuche es erneut!)
if /i "%update%" EQU "aktuell" echo			Es ist kein Update verfgbar!
if /i "%update%" EQU "skipped" (echo			Das Update wurde bersprungen!) && (echo			Diese Version ist evtl. veraltet!) && (support\sfk echo -spat \x20 \x20 \x20 \x20 \x20 \x20 \x20 \x20 [Yellow]Du bist m”glicherweise offline!)
set menu=
set false=0
set update=
echo.
echo			Hauptmen - Bitte w„hle eine Aktion:
echo.
echo			[1] Datenbank
echo.
echo			[O] Optionen
echo			[C] Credits
echo			[B] WiiDataDownloader beenden
echo.
echo.
echo			[F] Fehler melden
set /p menu= 	Eingabe: 

if /i "%menu%" EQU "1" call download.bat

if /i "%menu%" EQU "O" goto:optionen
if /i "%menu%" EQU "C" goto:credits
if /i "%menu%" EQU "B" exit

if /i "%menu%" EQU "F" (start https://github.com/Brawl345/WiiDataDownloader/issues) && (goto:menu)

set false=1
if /i "%menu%" EQU "1" set false=0
goto:menu

:optionen
cls
%header%
echo.
if /i "%false%" EQU "1" (echo.) && (echo		 %optionen% ist keine gltige Eingabe.) && (echo		 Bitte versuche es erneut!)
set optionen=
set false=
echo.
echo		[1] WDD Desktop-Shortcut erstellen
echo		[2] WDD Startmen-Shortcut erstellen
echo.
echo.
echo		[0] Men
echo.
set /p optionen=	Eingabe:	

if /i "%optionen%" EQU "1" goto:desktopshortcut
if /i "%optionen%" EQU "2" goto:startmenushortcut
if /i "%optionen%" EQU "0" goto:menu

set false=1
goto:optionen


:desktopshortcut
Support\nircmd shortcut "%cd%\Starte WDD.bat" "~$folder.desktop$" "WiiDataDownloader" "" "%cd%\Support\wdd.ico"
goto:optionen

:startmenushortcut
Support\nircmd shortcut "%cd%\Starte WDD.bat" "~$folder.programs$" "WiiDataDownloader" "" "%cd%\Support\wdd.ico"
goto:optionen

:credits
CLS
%header%
echo.
echo					Ich m”chte danken:
echo.
echo			DefenderX, pegelf, Centzilius, gantherfr, Mr.DaBu, 
echo			Akamaru, masterP, jacboy, LittleSatan, ...
echo.			
echo			Und allen anderen, die ich vergessen habe zu erw„hnen!
echo.
echo			UND GANZ SPEZIELL:
echo			XFlak		- fr ModMii und dessen Code
echo			Team Twiizers	- fr Homebrew auf der Wii
echo.
support\sfk echo -spat \x20 \x20 \x20 \x20 \x20 \x20 \x20 \x20 [Red]WDD-Version: %build% r%currentversion% - Download-Komponente: %newdownloadcomponent%
echo.
support\sfk echo -spat \x20 \x20 \x20 \x20 \x20 \x20 \x20 \x20 [Yellow](c) 2011-2014 WiiDatabase.de
support\sfk echo -spat \x20 \x20 \x20 \x20 \x20 \x20 \x20 \x20 [Yellow]Source-Code: https://github.com/Brawl345/WiiDataDownloader/
echo.
echo			Drcke eine Taste...
pause >NUL
goto:menu