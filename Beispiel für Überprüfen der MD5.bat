echo off
md ios
nusd 0001000248414241 21 packwad
copy titles\0001000248414241\21\0001000248414241-NUS-v21.wad ios\ShoppingChannel-v21.wad
sfk md5 -quiet -verify 4028b93ae96832b80ab22ca521963f80 ios\ShoppingChannel-v21.wad
if errorlevel 1 goto md5_ShoppingChannel
cls
echo.
echo.
echo  Download erfolgreich.
echo.
pause
exit
:md5_ShoppingChannel
sfk md5 ios\ShoppingChannel-v21.wad > md5.txt
exit