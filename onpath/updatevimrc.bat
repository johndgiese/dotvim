cd C:\opt\vim\vimfiles
if not exist C:\opt\vim\vimfiles mkdir C:\opt\vim\vimfiles
if not exist C:\opt\vim\tmp\undo mkdir C:\opt\vim\tmp\undo
if not exist C:\opt\vim\tmp\backup mkdir C:\opt\vim\tmp\backup
if not exist C:\opt\vim\tmp\swap mkdir C:\opt\vim\tmp\swap
git pull
if not exist C:\opt\vim\_vimrc mklink C:\opt\vim\_vimrc C:\opt\vim\vimfiles\_vimrc
