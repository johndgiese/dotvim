WINDOWS INSTALLATION:
    This assumes that your vim directory is in: C:\opt\vim
    If you installed vim in C:\Program Files\vim then make the appropriate changes below.

	git clone git://github.com/johndgiese/dotvim.git C:\opt\vim\vimfiles

Copy the _vimrc file up one directory:

    copy C:\opt\vim\vimfiles\_vimrc C:\opt\vim\_vimrc

For some of the utilities to work, you will need to add the vimfiles\onpath 
directory to the windows PATH:

    setx PATH "%PATH%;C:\opt\vim\vimfiles\onpath"

Note that this will only change the environment variable for the current 
windows user, to add it to the machine path variable use:

    setx PATH "%PATH%;C:\opt\vim\vimfiles\onpath" -M
        
Setup a directory for vim to save its undo files:
    mkdir C:\tmp\vim\undo C:\tmp\vim\swap C:\tmp\vim\backup
