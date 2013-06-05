@echo off

set /p continue="Are you sure you want to delete your vimfiles [y or n]?"
if "%continue%"=="y" goto continue
exit

:continue

echo.
echo "REMOVE SYMBOLIC LINKS"
del %HOME%\_vimrc
del %HOME%\_gvimrc

echo.
echo "REMOVING ALL CUSTOMIZATION FILES"
rmdir /S %HOME%\vimfiles

