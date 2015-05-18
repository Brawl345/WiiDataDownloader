@echo off
:top
CLS
::<---- Ins WDD Verzeichnis wechseln ---->
(if exist "%TEMP%\dir.bat" call "%TEMP%\dir.bat") && (if exist "%TEMP%\dir.bat" del "%TEMP%\dir.bat")
cd %curdir% >NUL
COLOR 1F

::<---- Versionsinformationen ---->
set currentversion=435
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

::<---- šberprfen, ob die Supportdateien existieren ---->
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
IF "%SD%"=="" set SD=AUF_SD_KOPIEREN
if "%USB%"=="" set USB=AUF_USB_KOPIEREN

::Nachchecken, ob die SD noch existiert
if /i "%SD%" EQU "%cd%\AUF_SD_KOPIEREN" set SD=AUF_SD_KOPIEREN
if /i "%SD:~1,1%" NEQ ":" goto:skipcheck
if exist "%SD:~0,2%" (goto:skipcheck) else (set SD=AUF_SD_KOPIEREN)
:skipcheck

::Nachchecken, ob USB noch existiert
if /i "%USB%" EQU "%cd%\AUF_USB_KOPIEREN" set USB=AUF_USB_KOPIEREN
if /i "%USB:~1,1%" NEQ ":" goto:skipcheck
if exist "%USB:~0,2%" (goto:skipcheck) else (set USB=AUF_USB_KOPIEREN)
:skipcheck

:onlinecheck
set offline=1
CLS
if /i "%skipchecks%" EQU "1" goto:skipthings
%header%
echo.
echo			Initialisieren...
:updatecheck
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
echo.
Support\sfk echo -spat \x20 \x20 \x20 \x20 \x20 \x20 \x20 [Red] Deine Version ist nicht aktuell!
echo.
echo			Update auf v%newversion%...
if exist "%updatedlname%" del "%updatedlname%"
start /min/wait support\wget -t 3 -O WDD.zip "%UpdateDLlink%"
echo.
Support\7za x -aoa WDD.zip -r
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
echo			[M] Module laden
echo.
echo			[O] Optionen
echo			[C] Credits
echo			[B] WiiDataDownloader beenden
echo.
echo.
echo			[F] Fehler melden
set /p menu= 	Eingabe: 

if /i "%menu%" EQU "1" call download.bat

if /i "%menu%" EQU "M" goto:module

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
echo		[SD] Ort der SD-Karte „ndern (Momentan: %SD%)
echo		[USB] Ort des USB-Ger„tes „ndern (Momentan: %USB%)
echo.
echo		[U] Nach Updates suchen
echo.
echo		[0] Men
echo.
set /p optionen=	Eingabe:	

if /i "%optionen%" EQU "1" goto:desktopshortcut
if /i "%optionen%" EQU "2" goto:startmenushortcut

if /i "%optionen%" EQU "SD" goto:changesd
if /i "%optionen%" EQU "USB" goto:changeusb

if /i "%optionen%" EQU "U" CLS && goto:updatecheck

if /i "%optionen%" EQU "0" goto:menu

set false=1
goto:optionen


:desktopshortcut
Support\nircmd shortcut "%cd%\Starte WDD.bat" "~$folder.desktop$" "WiiDataDownloader" "" "%cd%\Support\wdd.ico"
goto:optionen

:startmenushortcut
Support\nircmd shortcut "%cd%\Starte WDD.bat" "~$folder.programs$" "WiiDataDownloader" "" "%cd%\Support\wdd.ico"
goto:optionen

:changesd
cls
%header%
echo.
if /i "%false%" EQU "1" (echo.) && (echo		 %sdtemp% ist keine gltige Eingabe.) && (echo		 Bitte versuche es erneut!)
if /i "%false%" EQU "2" (echo.) && (echo		   %sdtemp:~0,2% existiert nicht, versuche es nochmal...)
set sdtemp=%SD%
set false=
echo.
echo		Gebe den Pfad zu deiner SD-Karte oder einem Ordner ein
echo.
echo			Momentan:   %SD%
echo.
echo		Du kannst den Ordner auch in dieses Fenster ziehen oder mit
echo		gedrckter SHIFT-Taste auf den Ordner rechtsklicken und
echo		"Als Pfad kopieren" w„hlen.
echo.
echo         Beispiele:
echo            F:
echo.
echo            %%userprofile%%\Desktop\AUF_SD_KOPIEREN
echo                  Hinweis: %%userprofile%% funktioniert nicht unter XP
echo.
echo            temp\AUF_SD_KOPIEREN
echo                  Hinweis: Dies erstellt den Pfad dort, wo WDD ausgefhrt wird
echo.
echo            %USERPROFILE%\Desktop\AUF_SD_KOPIEREN
echo.
echo		[1] Standard (AUF_SD_KOPIEREN)
echo		[2] Zurck
echo		[0] Men
echo.
set /p sdtemp=	Eingabe:	

::remove quotes from variable (if applicable)
echo "set SDTEMP=%sdtemp%">temp\temp.txt
support\sfk filter -quiet temp\temp.txt -rep _""""__>temp\temp.bat
call temp\temp.bat
del temp\temp.bat>nul
del temp\temp.txt>nul

if /i "%sdtemp%" EQU "0" goto:menu
if /i "%sdtemp%" EQU "2" goto:optionen
if /i "%sdtemp%" EQU "1" set SDTEMP=AUF_SD_KOPIEREN


:doublecheck
set fixslash=
if /i "%sdtemp:~-1%" EQU "\" set fixslash=ja
if /i "%sdtemp:~-1%" EQU "/" set fixslash=ja
if /i "%fixslash%" EQU "ja" set sdtemp=%sdtemp:~0,-1%
if /i "%fixslash%" EQU "ja" goto:doublecheck

::<!-- Wenn der zweite Buchstabe ein : ist, checke nach, ob das Ger„t existiert -->
if /i "%sdtemp:~1,1%" NEQ ":" goto:skipcheck
if exist "%sdtemp:~0,2%" (goto:skipcheck) else (set false=2)
goto:changesd
:skipcheck

set SD=%sdtemp%

::<!-- Speichern -->
support\sfk filter temp\Optionen.bat -!"Set SD=" -write -yes>nul
echo Set SD=%SD%>>temp\Optionen.bat

goto:optionen

:changeusb
cls
%header%
echo.
if /i "%false%" EQU "1" (echo.) && (echo		 %usbtemp% ist keine gltige Eingabe.) && (echo		 Bitte versuche es erneut!)
if /i "%false%" EQU "2" (echo.) && (echo		   %usbtemp:~0,2% existiert nicht, versuche es nochmal...)
set sdtemp=%SD%
set false=
echo.
echo		Gebe den Pfad zu deinem USB-Ger„t oder einem Ordner ein
echo.
echo			Momentan:   %USB%
echo.
echo		Du kannst den Ordner auch in dieses Fenster ziehen oder mit
echo		gedrckter SHIFT-Taste auf den Ordner rechtsklicken und
echo		"Als Pfad kopieren" w„hlen.
echo.
echo         Beispiele:
echo            G:
echo.
echo            %%userprofile%%\Desktop\AUF_USB_KOPIEREN
echo                  Hinweis: %%userprofile%% funktioniert nicht unter XP
echo.
echo            temp\AUF_USB_KOPIEREN
echo                  Hinweis: Dies erstellt den Pfad dort, wo WDD ausgefhrt wird
echo.
echo            %USERPROFILE%\Desktop\AUF_USB_KOPIEREN
echo.
echo		[1] Standard (AUF_USB_KOPIEREN)
echo		[2] Zurck
echo		[0] Men
echo.
set /p usbtemp=	Eingabe:	

::remove quotes from variable (if applicable)
echo "set SDTEMP=%usbtemp%">temp\temp.txt
support\sfk filter -quiet temp\temp.txt -rep _""""__>temp\temp.bat
call temp\temp.bat
del temp\temp.bat>nul
del temp\temp.txt>nul

if /i "%usbtemp%" EQU "0" goto:menu
if /i "%usbtemp%" EQU "2" goto:optionen
if /i "%usbtemp%" EQU "1" set SDTEMP=AUF_USB_KOPIEREN


:doublecheck
set fixslash=
if /i "%usbtemp:~-1%" EQU "\" set fixslash=ja
if /i "%usbtemp:~-1%" EQU "/" set fixslash=ja
if /i "%fixslash%" EQU "ja" set usbtemp=%usbtemp:~0,-1%
if /i "%fixslash%" EQU "ja" goto:doublecheck

::<!-- Wenn der zweite Buchstabe ein : ist, checke nach, ob das Ger„t existiert -->
if /i "%usbtemp:~1,1%" NEQ ":" goto:skipcheck
if exist "%usbtemp:~0,2%" (goto:skipcheck) else (set false=2)
goto:changesd
:skipcheck

set USB=%usbtemp%

::<!-- Speichern -->
support\sfk filter temp\Optionen.bat -!"Set USB=" -write -yes>nul
echo Set USB=%USB%>>temp\Optionen.bat

goto:optionen

:credits
CLS
%header%
echo.
echo					Ich m”chte danken:
echo.
echo			pegelf, Mr.DaBu, DefenderX, Akamaru, gantherfr, 
echo			Centzilius, masterP, jacboy, ...
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

:module
dir temp\Module /a:-d /b>temp\modulliste.txt

support\sfk filter -quiet temp\modulliste.txt -le+".bat" -write -yes

setlocal ENABLEDELAYEDEXPANSION
SET ModullisteTOTAL=0
for /f "delims=" %%i in (temp\modulliste.txt) do set /a ModullisteTOTAL=!ModullisteTOTAL!+1
setlocal DISABLEDELAYEDEXPANSION

SET /a ZEILEN=%ModullisteTOTAL%+29
if %ZEILEN% LEQ 35 goto:nichtvergroessern
mode con cols=85 lines=%LINES%
:nichtvergroessern

CLS
%header%
echo.
if /i "%false%" EQU "1" (echo.) && (echo			 %modulladen% ist keine gltige Eingabe.) && (echo			 Bitte versuche es erneut!)
if /i "%false%" EQU "2" (echo.) && (echo				Kein valides Modul!)
set false=
set modulladen=
echo				W„hle ein Modul:
echo.


if /i "%ModullisteTOTAL%" NEQ "0" goto:nichtnull

echo				Kein Modul gefunden!
echo.
echo 		Um Module benutzen zu k”nnen, mssen diese als
echo 		".bat"-Dateien in "temp\Module" liegen.
echo 		Um ein Modul zu l”schen kannst du es einfach aus
echo 		"temp\Module" l”schen.
echo.
echo 		Drcke eine Taste, um zum Men zurckzukehren.
echo.
pause>nul
goto:menu

:nichtnull

echo.

set ModullisteNUM=0

for /F "tokens=*" %%A in (temp\modulliste.txt) do call :listedurchgehen %%A
goto:skip
:listedurchgehen
set /a ModullisteNUM=%ModullisteNUM%+1
set ModullisteNUMtemp=%*
echo 		%ModullisteNUM% = %ModullisteNUMtemp:~0,-4%
goto:EOF
:skip

echo.
echo.
echo 		Um Module benutzen zu k”nnen, mssen diese als
echo 		".bat"-Dateien in "temp\Module" liegen.
echo 		Um ein Modul zu l”schen kannst du es einfach aus
echo 		"temp\Module" l”schen.
echo.
echo			[M] Men
echo			[B] WDD beenden
echo.
set /p modulladen=	Eingabe:	

if /i "%modulladen%" EQU "M" (mode con cols=85 lines=30) & (goto:menu)
if /i "%modulladen%" EQU "B" exit

if "%modulladen%"=="" goto:falscheeingabe

if %modulladen% LSS 1 goto:falscheeingabe
if /i %modulladen% GTR %ModullisteNUM% goto:falscheeingabe


set ModullisteNUM2=0
for /F "tokens=*" %%A in (temp\modulliste.txt) do call :listedurchgehen2 %%A
goto:skip
:listedurchgehen2
set AktuellesModul=%*
set /a ModullisteNUM2=%ModullisteNUM2%+1
if not exist "temp\DownloadQueues\%AktuellesModul%" goto:EOF
if /i "%ModullisteNUM2%" EQU "%modulladen%" goto:skip
goto:EOF

:skip
del temp\modulliste.txt>nul
findStr /I /C:":endedesmoduls" "temp\Module\%AktuellesModul%" >nul
IF ERRORLEVEL 1 (set false=2) && (goto:module)
mode con cols=85 lines=35

:ladedasmodul
call "temp\Module\%AktuellesModul%"
goto:Module


:falscheeingabe
set false=1
goto:module