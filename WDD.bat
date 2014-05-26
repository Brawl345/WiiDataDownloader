@echo off
:top
CLS
::<---- Wechsle ins WDD Verzeichnis ---->
(if exist "%TEMP%\dir.bat" call "%TEMP%\dir.bat") && (if exist "%TEMP%\dir.bat" del "%TEMP%\dir.bat")
cd %curdir% >NUL
COLOR 1F
set currentversion=413
set build=Pre-Alpha
set WDDpath=%cd%
set offline=1
::<---- Hier unten ist der Kernteil: Die URLs! Ohne die funktioniert die H�lfte nicht! -->
set url=http://wdd.wiidatabase.de
set urlwdd=http://wdd.wiidatabase.de
set files=%url%/files
set updates=%files%/update
set updatedlname=WDD.zip
set UpdateDLlink=%updates%/%updatedlname%
::<---- URLs Ende.---->
set Header=echo	    WiiDataDownloader %build% r%currentversion% - Heute ist der %DATE%
mode con cols=85 lines=30
TITLE WDD %build%-%currentversion%
::<---- Es gibt Programme, die Antivirentools f�lschlicherweise als Virus erkennen.
::Hiermit wird gepr�ft, ob ein Antivirusprogramm die Dateien gel�scht hat. Dem User wird
::dann eine Nachricht eingeblendet. Die Dateien werden NICHT neu gedownloadet (da sinnlos, wegen neuer Warnung)! ---->
:check
if not exist Support\nusd.exe goto:fehlt
if not exist Support\sfk.exe goto:fehlt
if not exist Support\dialogs goto:fehlt
if not exist Support\wdd.ico goto:fehlt
if not exist Support\nircmd.exe goto:fehlt
if not exist Support\wget.exe goto:fehlt
if not exist Support\7za.exe goto:fehlt
goto:title

::<---- Diese Nachricht erhalten nur User, denen etwas fehlt ---->
:fehlt
%header%
CLS
TITLE Wichtige Daten fehlen
echo.
echo.
echo.
echo		Eine oder mehrere notwendige Dateien fehlen.
echo		F�ge bitte eine Ausnahme in deinem Antivirenprogramm
echo		f�r ALLE Supportdateien hinzu!
echo		Bitte downloade WDDs Support-Daten nun neu!
echo		Besuche %files%
echo.
echo														WDD wird mit einem Tastendruck beendet.
pause >NUL
exit

:title
CLS
if not exist temp md temp
::<---- Hier werden die Optionen geladen. Diese halten z.B. fest, ob du bestimmte Warnungen schon gesehen hast. ---->
if exist temp\Optionen.bat call temp\Optionen.bat

:onlinecheck
CLS
if exist temp\skipchecks.txt goto:skipthings
:miniskip
::<---- Hier werden verschiedene Variablen, wie Version, etc. gesetzt
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
echo		 �berpr�fe deine Internet Verbindung und deine Firewall!
@ping 127.0.0.1 -n 3 -w 1000> nul
goto:menu


:aktuell
(set update=aktuell) && (goto:menu)


:neuer
cls
%header%
echo.
Support\sfk echo -spat \x20 \x20 \x20 \x20 \x20 \x20 \x20 [Yellow] Das Update ist fehlgeschlagen!
Support\sfk echo -spat \x20  \x20 \x20 \x20 \x20 \x20 \x20 [Yellow] Bitte stelle die Version zur�ck!
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
start /min/wait support\wget -t 3 "%UpdateDLlink%"
echo.
Support\7za x -aoa WDD.zip -r
start Support\dialogs\update_erfolgreich.vbs
del WDD.zip
echo.
goto:top


:offline
::<---- Du landest hier, wenn du offline bist ---->
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
::<---- Hier werden die Downloadvariablen gel�scht --->
set customizemii=
set devkitppc=
set dmlizard=
set nusd=
set showmiiwads=
set usbgxtheme=
set wbfsfat=
set wiibama=
set wiigsc=
set wilbrandgui=
CLS
mode con cols=85 lines=30
TITLE WDD - W�hle eine Aktion...
::<---- WDD GO! ---->
%header%
if /i "%false%" EQU "1" echo.
if /i "%false%" EQU "1" echo		 %menu% ist keine g�ltige Eingabe.
if /i "%false%" EQU "1" echo		 Bitte versuche es erneut!
set menu=
set false=0
echo.
if /i "%update%" EQU "aktuell" echo			Es ist kein Update verf�gbar!
if /i "%update%" EQU "skipped" echo			Das Update wurde �bersprungen!
if /i "%update%" EQU "skipped" echo			Diese Version ist evtl. veraltet!
if exist temp\skiponlinecheck.txt support\sfk echo -spat \x20 \x20 \x20 [Yellow]Du bist mglicherweise offline!
set update=
echo.
echo			Hauptmen� - Bitte w�hle eine Aktion:
echo.
echo			[1] Datenbank
echo.
echo			[O] Optionen
echo			[C] Credits
echo			[0] WiiDataDownloader beenden
echo.
echo.
echo			[B] Fehler melden
set /p menu= 	Eingabe: 

if /i "%menu%" EQU "1" goto:datenbank

if /i "%menu%" EQU "O" goto:optionen
if /i "%menu%" EQU "C" goto:thankyou
if /i "%menu%" EQU "0" exit

if /i "%menu%" EQU "B" goto:bug

set false=1
goto:menu

:optionen
cls
%header%
echo.
if /i "%false%" EQU "1" echo.
if /i "%false%" EQU "1" echo		 %optionen% ist keine g�ltige Eingabe.
if /i "%false%" EQU "1" echo		 Bitte versuche es erneut!
set optionen=
echo.
echo		[1] WDD Desktop-Shortcut erstellen
echo		[2] WDD Startmen�-Shortcut erstellen
echo.
echo.
echo		[0] Menue
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

:datenbank
:pc
::<---- Der Downloadbereich. Die Variablen bestimmen, was gedownloadet wird! ---->
CLS
mode con cols=100 lines=50
TITLE WDD - W�hle Programme...
%header%
if /i "%false%" EQU "1" echo.
if /i "%false%" EQU "1" echo		 %pc% ist keine g�ltige Eingabe.
if /i "%false%" EQU "1" echo		 Bitte versuche es erneut!
set pc=
set false=0
echo.
echo.
echo			Bitte w�hle die zu downloadenden Programme:
echo.
echo ����������������������������������				����������������������������������
echo �	Downloadwahl		 �		 		�	Wird gedownloadet	 �
echo ����������������������������������				����������������������������������
if /i "%customizemii%" NEQ "*" echo	 [1] CustomizeMii
if /i "%customizemii%" EQU "*" echo							  	 	 [1] CustomizeMii
if /i "%devkitppc%" NEQ "*" echo	 [2] DevKitPro
if /i "%devkitppc%" EQU "*" echo							  	 	 [2] DevKitPPC
if /i "%dmlizard%" NEQ "*" echo	 [3] DMLizard
if /i "%dmlizard%" EQU "*" echo							  	 	 [3] DMLizard
if /i "%nusd%" NEQ "*" echo	 [4] NUSD
if /i "%nusd%" EQU "*" echo							  	 	 [4] NUSD
if /i "%showmiiwads%" NEQ "*" echo	 [5] ShowMiiWads
if /i "%showmiiwads%" EQU "*" echo							  	 	 [5] ShowMiiWads
if /i "%usbgxtheme%" NEQ "*" echo	 [6] USBLoader GX Theme Creator
if /i "%usbgxtheme%" EQU "*" echo							  	 	 [6] USBLoader GX Theme Creator
if /i "%wbfsfat%" NEQ "*" echo	 [7] WBFS2FAT
if /i "%wbfsfat%" EQU "*" echo							  	 	 [7] WBFS2FAT
if /i "%wiibama%" NEQ "*" echo	 [8] Wii Backup Manager
if /i "%wiibama%" EQU "*" echo							  	 	 [8] Wii Backup Manager
if /i "%wiigsc%" NEQ "*" echo	 [9] WiiGSC
if /i "%wiigsc%" EQU "*" echo							  	 	 [9] WiiGSC
if /i "%wilbrandgui%" NEQ "*" echo	 [10] WilBrand GUI
if /i "%wilbrandgui%" EQU "*" echo							  	 	 [10] WilBrand GUI
echo.
echo.
echo			[D] Starte Download
echo.
echo			[DB] Mehr (Browser)
echo			[M] Men�
echo			[B] WDD beenden
echo.
echo.
set /p pc= 	Eingabe:		

if /i "%pc%" EQU "1" goto:activatecustomizemii
if /i "%pc%" EQU "2" goto:activatedevkit
if /i "%pc%" EQU "3" goto:activatedmlizard
if /i "%pc%" EQU "4" goto:activatenusd
if /i "%pc%" EQU "5" goto:activateshowmiiwads
if /i "%pc%" EQU "6" goto:activateusbgxtheme
if /i "%pc%" EQU "7" goto:activatewbfsfat
if /i "%pc%" EQU "8" goto:activatewiibama
if /i "%pc%" EQU "9" goto:activatewiigsc
if /i "%pc%" EQU "10" goto:activatewilbrandgui

if /i "%pc%" EQU "D" goto:pcwarteschlange

if /i "%pc%" EQU "DB" start http://wiidatabase.de/downloads/pc-tools
if /i "%pc%" EQU "DB" goto:datenbank
if /i "%pc%" EQU "M" goto:menu
if /i "%pc%" EQU "B" exit


set false=1
goto:pc

::<---- Hier werden die Variablen f�r den Download gesetzt. Der Stern entscheidet, ob eine Datei
::gedownloadet wird, oder nicht ---->
::<---- NUSL Code ---->
:activatecustomizemii
if /i "%customizemii%" EQU "*" (set customizemii=) else (set customizemii=*)
goto:pc
:activatedevkit
if /i "%devkitppc%" EQU "*" (set devkitppc=) else (set devkitppc=*)
goto:pc
:activatedmlizard
if /i "%dmlizard%" EQU "*" (set dmlizard=) else (set dmlizard=*)
goto:pc
:activatenusd
if /i "%nusd%" EQU "*" (set nusd=) else (set nusd=*)
goto:pc
:activateshowmiiwads
if /i "%showmiiwads%" EQU "*" (set showmiiwads=) else (set showmiiwads=*)
goto:pc
:activateusbgxtheme
if /i "%usbgxtheme%" EQU "*" (set usbgxtheme=) else (set usbgxtheme=*)
goto:pc
:activatewbfsfat
if /i "%wbfsfat%" EQU "*" (set wbfsfat=) else (set wbfsfat=*)
goto:pc
:activatewiibama
if /i "%wiibama%" EQU "*" (set wiibama=) else (set wiibama=*)
goto:pc
:activatewiigsc
if /i "%wiigsc%" EQU "*" (set wiigsc=) else (set wiigsc=*)
goto:pc
:activatewilbrandgui
if /i "%wilbrandgui%" EQU "*" (set wilbrandgui=) else (set wilbrandgui=*)
goto:pc

:pcwarteschlange
::<---- Das Herzst�ck des WDD: Die Warteschlange und der anschlie�ende Download! ---->
::<---- Zuee�rst wird gez�hlt, wieviel gedownloadet wird ---->
if exist temp\DLnames.txt del temp\DLnames.txt>nul
setlocal ENABLEDELAYEDEXPANSION
SET DLTOTAL=0
set CURRENTDL=0
if /i "%customizemii%" EQU "*" echo		CustomizeMii>> temp\DLnames.txt
if /i "%devkitppc%" EQU "*" echo		DevkitPCC>> temp\DLnames.txt
if /i "%dmlizard%" EQU "*" echo		DMLizard>> temp\DLnames.txt
if /i "%nusd%" EQU "*" echo		NUSD>> temp\DLnames.txt
if /i "%showmiiwads%" EQU "*" echo		ShowMiiWads>> temp\DLnames.txt
if /i "%usbgxtheme%" EQU "*" echo		USBLoader GX Theme Creator>> temp\DLnames.txt
if /i "%wbfsfat%" EQU "*" echo		WBFS2FAT>> temp\DLnames.txt
if /i "%wiibama%" EQU "*" echo		Wii Backup Manager>> temp\DLnames.txt
if /i "%wiigsc%" EQU "*" echo		WiiGSC>> temp\DLnames.txt
if /i "%wilbrandgui%" EQU "*" echo		WilBrand GUI>> temp\DLnames.txt
if exist temp\DLnames.txt for /f "delims=" %%i in (temp\DLnames.txt) do set /a DLTOTAL=!DLTOTAL!+1
setlocal DISABLEDELAYEDEXPANSION
if /i "%DLTOTAL%" EQU "0" goto:keinedownloads
CLS
TITLE Downloade %DLTOTAL% PC-Programme...
%header%
echo.
echo			Starte Download...
echo.
:setzevariablen
if /i "%customizemii%" EQU "*" goto:customizemii
if /i "%devkitppc%" EQU "*" goto:devkitppc
if /i "%dmlizard%" EQU "*" goto:dmlizard
if /i "%nusd%" EQU "*" goto:nusd
if /i "%showmiiwads%" EQU "*" goto:showmiiwads
if /i "%usbgxtheme%" EQU "*" goto:usbgxtheme
if /i "%wbfsfat%" EQU "*" goto:wbfsfat
if /i "%wiibama%" EQU "*" goto:wiibama
if /i "%wiigsc%" EQU "*" goto:wiigsc
if /i "%wilbrandgui%" EQU "*" goto:wilbrandgui
goto:alledownloadsfertig






:customizemii
set md5=d14156cc170933b7efe669989b75fcd8
set namedl=CustomizeMii
set name=customizemii.zip
set variable=customizemii
goto:startedownload

:devkitppc
set md5=c28c227e2e78234a082bec02996258ab
set namedl=DevkitPro Installer
set name=devkitpro.zip
set variable=devkitppc
goto:startedownload

:dmlizard
set md5=ffd7448a8527b6bf42eb7b8bfdea1788
set namedl=DMLizard
set name=dmlizard.zip
set variable=dmlizard
goto:startedownload

:nusd
set md5=16728c00da1845f4b0486c6564d8e5fc
set namedl=NUS Downloader
set name=nusd.zip
set variable=nusd
goto:startedownload

:showmiiwads
set md5=cd76b0f6f404daeb04f66787dcdd4bcc
set namedl=ShowMiiWads
set name=showmiiwads.zip
set variable=showmiiwads
goto:startedownload

:usbgxtheme
set md5=d4507d1ba007927f5dfb9c0d8673e580
set namedl=USBLoader GX Theme Creator
set name=usbloadergxthemecreator.zip
set variable=usbgxtheme
goto:startedownload

:wbfsfat
set md5=7f8f84a288f6217f9fcd16f9e588e46f
set namedl=WBFS2FAT
set name=wbfsfat.zip
set variable=wbfsfat
goto:startedownload

:wiibama
set md5=5b52f0825415fe448111080edff1a8c8
set namedl=Wii Backup Manager
set name=wiibackupmanager.zip
set variable=wiibama
goto:startedownload

:wiigsc
set md5=351288be570364672fe26272cd743f8b
set namedl=WiiGSC
set name=wiigscinstaller.zip
set variable=wiigsc
goto:startedownload

:wilbrandgui
set md5=cbeb3af96d89eb31d8ff647cc62bbe4d
set namedl=WilBrand GUI und Launcher
set name=wilbrandgui.zip
set variable=wilbrandgui
goto:startedownload

:startedownload
set /a CURRENTDL=%CURRENTDL%+1
TITLE %currentdl% von %dltotal%
Support\sfk echo -spat \x20 \x20 [Magenta]%CURRENTDL% von %DLTOTAL%:  %namedl%
::<----MD5 Check ---->
if not exist %name% goto:existiertnochnicht
set md5check=
set md5altcheck=
support\sfk md5 -quiet -verify %md5% %name%
if errorlevel 1 set md5check=fail
IF "%md5check%"=="" set md5check=pass
if /i "%md5check%" NEQ "fail" goto:erfolgreich

:fehlgeschlagen
echo.
support\sfk echo [Yellow] Diese Datei existiert bereits, hat aber den MD5 Test nicht bestanden
support\sfk echo [Yellow] Die aktue�lle Version der Datei wird gel�scht und die Datei wird erneut gedownloadet
echo.
del %name% >NUL
set /a CURRENTDL=%CURRENTDL%-1
goto:startedownload

:erfolgreich
support\sfk echo [Green]Diese Datei existiert bereits und hat den MD5 Test bestanden! Entpacke...
start /min/wait Support\7za x -aoa %name% -o"Programme\%namedl%" -r >NUL
del %name%
echo.
if /i "%devkitppc%" EQU "*" set devkitppcinstall=1
set %variable%=
goto:setzevariablen

:existiertnochnicht
start /min/wait support\wget -t 3 "%files%/%name%"
if not exist Programme mkdir Programme
if not exist "Programme\%namedl%" mkdir "Programme\%namedl%"
echo.
echo.
set md5check=
set md5altcheck=
support\sfk md5 -quiet -verify %md5% %name%
if errorlevel 1 set md5check=fail
IF "%md5check%"=="" set md5check=pass
if /i "%md5check%" NEQ "fail" goto:erfolgreich

:fehlgeschlagen
echo.
support\sfk echo [Yellow] Die Datei hat den MD5 Test nicht bestanden
support\sfk echo [Yellow] Die aktuelle Version der Datei wird gel�scht und die Datei wird erneut gedownloadet
echo.
del %name%
goto:redownload

:erfolgreich
start /min/wait Support\7za x -aoa %name% -o"Programme\%namedl%" -r >NUL
del %name%
support\sfk echo [Green]Download abgeschlossen!
echo.
if /i "%devkitppc%" EQU "*" set devkitppcinstall=1
set %variable%=
goto:setzevariablen

:redownload
start /min/wait support\wget -t 3 "%files%/%name%"
if not exist Programme mkdir Programme
if not exist "Programme\%namedl%" mkdir "Programme\%namedl%"
echo.
echo.
set md5check=
set md5altcheck=
support\sfk md5 -quiet -verify %md5% %name%
if errorlevel 1 set md5check=fail
IF "%md5check%"=="" set md5check=pass
if /i "%md5check%" NEQ "fail" goto:erfolgreich
echo.
support\sfk echo [Magenta] Fehlgeschlagen! �berspringe Download...
echo.
SET /a retry=%retry%+1
SET /a attempt=%attempt%+1
del %name%
set %variable%=
goto:setzevariablen

:alledownloadsfertig
start Support\dialogs\downloads_complete.vbs
:downloadnachdialog
CLS
%header%
TITLE Download(s) abgeschlossen!
echo.
if /i "%false%" EQU "1" echo.
if /i "%false%" EQU "1" echo		 %downloadsende% ist keine g�ltige Eingabe.
if /i "%false%" EQU "1" echo		 Bitte versuche es erneut!
set downloadsende=
echo			Alle Downloads sind fertig!
echo			Bitte w�hle eine Aktion:
echo.
echo			[1] Zur�ck zum Downloadmen�
echo			[2] Zur�ck zum Hauptmen�
echo			[3] WDD beenden
echo.
if /i "%devkitppcinstall%" EQU "1" echo		F�hre bitte den DevkitPro Installer aus!
start explorer.exe "%cd%\Programme\"
set devkitppcinstall=
echo.
set /p downloadsende= Eingabe:		


if /i "%downloadsende%" EQU "1" goto:pc
if /i "%downloadsende%" EQU "2" goto:menu
if /i "%downloadsende%" EQU "3" exit

set false=1
goto:alledownloadsfertig

:keinedownloads
echo Bitte w�hle z�rst Downloads aus!
@ping 127.0.0.1 -n 2 -w 1000> nul
goto:pc

:bug
start https://github.com/Brawl345/WiiDataDownloader/issues
goto:menu

:thankyou
CLS
%header%
echo.
echo				Ich m�chte danken:
echo.
echo			DefenderX, pegelf, Centzilius, gantherfr, ...
echo			Kurz: Allen meinen Freunden!
echo.
echo			UND:
echo			XFlak
echo			Team Twiizers
echo.
echo			Dr�cke eine Taste...
pause >NUL
goto:menu