set /p viminstallpath= What is the full path to your vim install (inlude the final slash)? (e.g. "C:\Program Files\vim\") 
cd %viminstallpath%

:: make symbolic links for .vim and the .vim/vimrc
if not exist %viminstallpath%vimfiles mklink /D %viminstallpath%vimfiles %viminstallpath%.vim
if not exist %viminstallpath%_vimrc mklink %viminstallpath%_vimrc %viminstallpath%vimfiles\vimrc

:: pull changes from git
call git pull

:: setup submodules
call git submodule init
call git submodule update
