@echo off
if not exist temp md temp
cd temp
if not exist ..\Support\nusd.exe goto:failed
if not exist ..\Support\sfk.exe goto:failed
..\Support\nusd 0001000248414241 21 packwad
move ..\Support\0001000248414241\0001000248414241.wad ShoppingChannel-v21.wad >NUL
..\Support\sfk md5 -quiet -verify 7041a8c9f0ee8fd3037f6228ddd6dfc3 ShoppingChannel-v21.wad
if errorlevel 1 goto md5_ShoppingChannel
echo.
echo.
echo  Download erfolgreich.
echo.
pause
goto:end
:md5_ShoppingChannel
echo Fehlgeschlagen!
..\Support\sfk md5 ShoppingChannel-v21.wad > md5.txt
pause
goto:end

:failed
echo Etwas ist schiefgelaufen!
pause
goto:end

:end
rmdir /s /q ..\Support\0001000248414241
del ShoppingChannel-v21.wad
exit