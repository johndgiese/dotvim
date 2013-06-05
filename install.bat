@echo off

echo.
echo "SETTING UP SYMBOLIC LINKS..."
mklink %HOME%/_vimrc %HOME%/vimfiles/vimrc
mklink %HOME%/_gvimrc %HOME%/vimfiles/gvimrc

echo.
echo "INSTALLING VUNDLE, THE VIM PLUGIN MANAGER, ..."
git clone -v https://github.com/gmarik/vundle.git %HOME%/vimfiles/bundle/vundle

echo.
echo "INSTALLING PLUGINS, MAY TAKE A WHILE ..."
vim -c "execute 'BundleInstall' | quitall!"

echo.
echo "FINISHED!  HAPPY VIMMING!"
