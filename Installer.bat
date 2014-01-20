@echo off
COLOR 1F
TITLE WDD Installer
if exist "%userprofile%\dir.bat" call "%userprofile%\dir.bat"
if exist "%userprofile%\dir.bat" del "%userprofile%\dir.bat"
cd %curdir%
:top
echo.
CLS
echo		Willkommen beim WiiDataDownloader Installer!
echo						Bitte warte!
if exist checkconnect.bat call checkconnect.bat
start /min/wait wget -t 3 "http://wiidatabase.de/wddfiles/checkconnect.bat"
if /i "%offline%" EQU "1" goto:offline
del checkconnect.bat
if exist version.bat del version.bat
start /min/wait wget -t 3 "http://wiidatabase.de/wddfiles/version.bat"
call version.bat
if exist version.bat del version.bat
echo		 Wir downloaden gerade die neueste Version... (v%newversion%)
start /min/wait wget -t 3 http://wiidatabase.de/wddfiles/WDD.zip
if not exist wdd.zip goto:failed
:choose
CLS
set pfad=
echo			Wohin soll WDD installiert werden?
echo.
echo			[1] %cd%\WDD
echp			[2] %userprofile%\Documents\WDD
echo			[3] %userprofile%\Desktop\WDD
echo			[4] %homedrive%\Program Files\WDD
echo			[5] %homedrive%\WDD
echo.
set /i pfad= 	Eingabe:

if /i "%pfad%" EQU "1" set pfad=%cd%\WDD
if /i "%pfad%" EQU "1" goto:install

if /i "%pfad%" EQU "2" set pfad=%userprofile%\Documents\WDD
if /i "%pfad%" EQU "2" goto:install

if /i "%pfad%" EQU "3" set pfad=%userprofile%\Desktop\WDD
if /i "%pfad%" EQU "3" goto:install

if /i "%pfad%" EQU "4" set pfad=%homedrive%\Program Files\WDD
if /i "%pfad%" EQU "4" goto:install

if /i "%pfad%" EQU "5" set pfad=%homedrive%\WDD
if /i "%pfad%" EQU "5" goto:install

goto:choose

:install
CLS
echo				 OK! Wir installieren WDD in:
echo %pfad%
echo						Entpacke...
if not exist %pfad% mkdir %pfad%
7za e -aoa wdd.zip -o%pfad% -r
:ende
echo.
echo						Starte WDD...
call "%pfad%\Starte WDD.bat"
exit


:offline
CLS
echo		Willkommen beim WiiDataDownloader Installer!
echo						Bitte warte!
echo		  Du bist offline! Bitte gehe wieder online!
echo				 Druecke eine Taste!
pause >NUL
exit

:failed
CLS
echo		Willkommen beim WiiDataDownloader Installer!
echo						Bitte warte!
echo		 Wir downloaden gerade die neueste Version... (v%newversion%)
echo					Download fehlgeschlagen!
echo				 	 Druecke eine Taste!
pause >NUL
exit