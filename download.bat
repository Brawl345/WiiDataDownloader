@echo off
:downloadcomponentupdcheck
set downloadcomponent=20141028.1
::<---- Auto-Updater ---->
if /i "%skipchecks%" EQU "1" (set componentupdfailed=1) && (goto:datenbank)
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
if exist temp\WDD_Log.bat del temp\WDD_Log.bat
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
if /i "%wilbrandlauncher%" NEQ "*" echo	 [10] WilBrand Launcher
if /i "%wilbrandlauncher%" EQU "*" echo							  	 	 [10] WilBrand Launcher
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
if /i "%pc%" EQU "10" goto:activatewilbrandlauncher

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
:activatewilbrandlauncher
if /i "%wilbrandlauncher%" EQU "*" (set wilbrandlauncher=) else (set wilbrandlauncher=*)
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
if /i "%wilbrandlauncher%" EQU "*" echo		WilBrand Launcher>> temp\DLnames.txt
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
if /i "%wilbrandlauncher%" EQU "*" goto:wilbrandlauncher
goto:alledownloadsfertig

::<---- Downloads ---->

:customizemii
set md5=237cb5557b0810e51fdd1c13960a47b8
set namedl=CustomizeMii
set name=customizemii.zip
set variable=customizemii
goto:startedownload

:devkitppc
set md5=a33ff8a5dd8ed8489a520213562374ea
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
set md5=87eabe772e26e3b06602503fec245a56
set namedl=NUS Downloader
set name=nusd.zip
set variable=nusd
goto:startedownload

:showmiiwads
set md5=f26b6658a525cf0528a1c40b1a0c48d7
set namedl=ShowMiiWads
set name=showmiiwads.zip
set variable=showmiiwads
goto:startedownload

:usbgxtheme
set md5=cdc267c7c2e6a2da31a802ab99816911
set namedl=USBLoader GX Theme Creator
set name=usbloadergxthemecreator.zip
set variable=usbgxtheme
goto:startedownload

:wbfsfat
set md5=0754ae18df6f962c76f0f2b0fd231111
set namedl=WBFS2FAT
set name=wbfs2fat.zip
set variable=wbfsfat
goto:startedownload

:wiibama
set md5=01790f4df12e344cce52309d8ba7f640
set namedl=Wii Backup Manager
set name=wiibackupmanager.zip
set variable=wiibama
goto:startedownload

:wiigsc
set md5=16e6ed82403caca1b172e8918ae4ab8a
set namedl=WiiGSC
set name=wiigsc.zip
set variable=wiigsc
goto:startedownload

:wilbrandlauncher
set md5=1e68acfe7c611b2e34e383215fe25f96
set namedl=WilBrand Launcher
set name=wilbrandlauncher.zip
set variable=wilbrandlauncher
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
support\sfk echo -spat \x20 \x20  [Yellow] Diese Datei existiert bereits, hat aber den MD5 Test nicht bestanden
support\sfk echo -spat \x20 \x20  [Yellow] Die aktueÅlle Version der Datei wird gelîscht und die Datei wird erneut gedownloadet
echo.
del %name% >NUL
set /a CURRENTDL=%CURRENTDL%-1
goto:startedownload

:erfolgreich
support\sfk echo -spat \x20 \x20  [Green]Diese Datei existiert bereits und hat den MD5 Test bestanden! Entpacke...
start /min/wait Support\7za x -aoa %name% -o"Programme\%namedl%" -r >NUL
del %name%
echo.
set %variable%=
goto:setzevariablen

:existiertnochnicht
start /min/wait support\wget -t 3 "%files%/%name%"
if not exist Programme mkdir Programme
if not exist "Programme\%namedl%" mkdir "Programme\%namedl%"
set md5check=
set md5altcheck=
support\sfk md5 -quiet -verify %md5% %name%
if errorlevel 1 set md5check=fail
IF "%md5check%"=="" set md5check=pass
if /i "%md5check%" NEQ "fail" goto:erfolgreich

:fehlgeschlagen
echo.
support\sfk echo -spat \x20 \x20  [Yellow] Die Datei hat den MD5-Test nicht bestanden
support\sfk echo -spat \x20 \x20  [Yellow] Die aktuelle Version der Datei wird gelîscht und die Datei wird erneut gedownloadet
echo.
if exist %name% del %name%
goto:redownload

:erfolgreich
start /min/wait Support\7za x -aoa %name% -o"Programme\%namedl%" >NUL
if exist %name% del %name%
support\sfk echo -spat \x20 \x20  [Green]Download abgeschlossen!
echo.
if /i "%devkitppc%" EQU "*" set devkitppcinstall=1
echo "support\sfk echo %namedl%: [Green]Erfolreich">>temp\WDD_Log.bat
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
support\sfk echo -spat \x20 \x20  [Red] Fehlgeschlagen! Åberspringe Download...
echo.
SET /a retry=%retry%+1
SET /a attempt=%attempt%+1
if exist %name% del %name%
echo "support\sfk echo -spat \x20 \x20 \x20 \x20 \x20 \x20 \x20 \x20 %namedl%: [Red]Invalide">>temp\WDD_Log.bat
set %variable%=
goto:setzevariablen

:alledownloadsfertig
start Support\dialogs\downloads_complete.vbs
if not exist "temp\WDD_Log.bat" (set problematischeDLs=0) & (goto:nocounting)

support\sfk filter -quiet "temp\WDD_Log.bat" -rep _"""__ -write -yes

::Z‰hle problematische Downloads
support\sfk filter -quiet "temp\WDD_Log.bat" -+"[Red]" -write -yes
set problematischeDLs=0

setlocal ENABLEDELAYEDEXPANSION
for /f "delims=" %%i in (temp\WDD_Log.bat) do set /a problematischeDLs=!problematischeDLs!+1
setlocal DISABLEDELAYEDEXPANSION

:nocounting
if /i "%problematischeDLs%" EQU "0" (set downloadlogsuccess=Erfolgreich) else (set snksuccess=)
if /i "%problematischeDLs%" EQU "0" (set downloadlogfailure=) else (set downloadlogfailure=aber mit Fehlern)

:downloadnachdialog
CLS
%header%
TITLE Download(s) abgeschlossen!
echo.
if /i "%false%" EQU "1" echo.
if /i "%false%" EQU "1" echo		 %downloadsende% ist keine gÅltige Eingabe.
if /i "%false%" EQU "1" echo		 Bitte versuche es erneut!
set downloadsende=
echo			Alle Downloads sind abgeschlossen!
echo.
:problemlog
::Liste problematische Downloads
if /i "%problematischeDLs%" EQU "0" goto:noproblems
echo.
if /i "%DLTOTAL%" EQU "%problematischeDLs%" goto:miniskip
echo 		Von %DLTOTAL% Downloads schlug(en) %problematischeDLs% Download(s) fehl:
:miniskip
if "%DLTOTAL%" EQU "%problematischeDLs%" echo 		Alle Downloads schlugen fehl:
call temp\WDD_Log.bat
:noproblems
echo.
echo			[1] Explorer îffnen
echo			[2] ZurÅck zum DownloadmenÅ
echo			[3] ZurÅck zum HauptmenÅ
echo			[4] WDD beenden
echo.
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
set wilbrandlauncher=
if /i "%pc%" EQU "M" goto:eof
set /p downloadsende= Eingabe:		

if /i "%downloadsende%" EQU "1" (start explorer.exe "%cd%\Programme\") && (goto:downloadnachdialog)
if /i "%downloadsende%" EQU "2" goto:datenbank
if /i "%downloadsende%" EQU "3" (endlocal) && (goto:eof)
if /i "%downloadsende%" EQU "4" exit

set false=1
goto:alledownloadsfertig