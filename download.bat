@echo off
:downloadcomponentupdcheck
set downloadcomponent=20141026.1
::<---- Auto-Updater ---->
if exist temp\skipchecks.txt (set componentupdfailed=1) && (goto:datenbank)
TITLE Suche nach Updates...
if /i "%downloadcomponent%" EQU "" (set componentupdfailed=1) && (goto:datenbank)
if /i "%downloadcomponent%" EQU "%newdownloadcomponent%" goto:datenbank
if /i "%downloadcomponent%" GEQ "%newdownloadcomponent%" (set componentupdfailed=1) && (goto:datenbank)
if /i "%downloadcomponent%" NEQ "%newdownloadcomponent%" goto:update

:update
cls
%header%
Support\sfk echo -spat \x20 \x20 \x20 [Red] Update der Download-Komponente....
echo.
echo			Aktualisieren auf %newdownloadcomponent%...
start /min/wait support\wget -t 3 -O download.bat "%updates%/download.bat"
goto:downloadcomponentupdcheck


:datenbank
:pc
::<---- Der Downloadbereich. Die Variablen bestimmen, was gedownloadet wird! ---->
CLS
mode con cols=100 lines=50
TITLE WDD - WÑhle Programme...
%header%
if /i "%false%" EQU "1" (echo.) && (echo		 %pc% ist keine gÅltige Eingabe.) && (echo		 Bitte versuche es erneut!)
if /i "%componentupdfailed%" EQU "1" (echo.) && (echo		 	Die Download-Komponente konnte nicht aktualisiert werden.) && (set componentupdfailed=0)
set pc=
set false=0
echo.
echo.
echo			Bitte wÑhle die zu downloadenden Programme:
echo.
echo ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞				∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
echo ∞	Downloadwahl		 ∞		 		∞	Wird gedownloadet	 ∞
echo ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞				∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞
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
echo			[M] MenÅ
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
if /i "%pc%" EQU "M" goto:loeschevariablen
if /i "%pc%" EQU "B" exit


set false=1
goto:pc

:keinedownloads
echo Bitte wÑhle zuerst Downloads aus!
@ping 127.0.0.1 -n 2 -w 1000> nul
goto:pc

::<---- Hier werden die Variablen f¸r den Download gesetzt. Der Stern entscheidet, ob eine Datei
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
::<---- Downloads zÑhlen ---->
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

::<---- Downloads ---->

:customizemii
set md5=e27125f54b03326ca6c512150f5f948f
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
set md5=f0f75945092f6c7224a7fed1b670866e
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

::<---- Starte Download ---->

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
support\sfk echo [Yellow] Die aktueÅlle Version der Datei wird gelîscht und die Datei wird erneut gedownloadet
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
support\sfk echo [Yellow] Die aktuelle Version der Datei wird gelîscht und die Datei wird erneut gedownloadet
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
support\sfk echo [Red] Fehlgeschlagen! Åberspringe Download...
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
if /i "%false%" EQU "1" echo		 %downloadsende% ist keine gÅltige Eingabe.
if /i "%false%" EQU "1" echo		 Bitte versuche es erneut!
set downloadsende=
echo			Alle Downloads sind fertig!
echo			Bitte wÑhle eine Aktion:
echo.
echo			[1] Explorer îffnen
echo			[2] ZurÅck zum DownloadmenÅ
echo			[3] ZurÅck zum HauptmenÅ
echo			[4] WDD beenden
echo.
if /i "%devkitppcinstall%" EQU "1" echo		FÅhre bitte den DevkitPro Installer aus!
set devkitppcinstall=
echo.
:loeschevariablen
::<---- Hier werden die Downloadvariablen gelˆscht --->
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
if /i "%pc%" EQU "M" goto:eof
set /p downloadsende= Eingabe:		

if /i "%downloadsende%" EQU "1" (start explorer.exe "%cd%\Programme\") && (goto:downloadnachdialog)
if /i "%downloadsende%" EQU "2" goto:datenbank
if /i "%downloadsende%" EQU "3" goto:eof
if /i "%downloadsende%" EQU "4" exit

set false=1
goto:alledownloadsfertig