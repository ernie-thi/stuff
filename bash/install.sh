#!/bin/bash

### Which package manager to use
PKG=''
if [ -x "$(command -v apt)" ]; then
    echo -n "apt Paketmanager"
    export PKG="apt"
elif [ -x "$(command -v dnf)" ]; then 
    echo  "dnf Paketmanager"
    export PKG="dnf"
else 
    echo "Paketverwaltungssystem nicht gefunden"
fi

### Update Packages

echo "Following: Update packages"
{ sudo $PKG update -y; sudo $PKG upgrade -y; }
echo "Updating packages completed successfully"

logfile="/home/$USER/install.log"
errorlog="/home/$USER/error_install.log"

./bash_aliases.sh >>$logfile 2>>$errorlog
if [ $? -eq 0 ]
then
    echo "bash aliases erfolgreich aktualisiert"
else
    echo "Error in bash alias.sh copying process, check $errorlog"
fi

./fancyprompt.sh >>$logfile 2>>$errorlog
if [ $? -eq 0 ]
then
    echo "fancyprompt erfolgreich ausgeführt"
else
    echo "Error in fancyprompt.sh, check $errorlog"
fi

chmod +x neovim.sh
./neovim.sh >>$logfile 2>>$errorlog
if [ $? -eq 0 ]
then
    echo "neovim erfolgreich installiert"
else
    echo "Error in neovim.sh ausführung, check $errorlog"
fi
