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

./bash_aliases.sh
if [ $? -eq 0 ]
then
    echo "bash aliases erfolgreich aktualisiert" >> $logfile
else
    echo "Error in bash alias.sh" >> $errorlog
fi

./fancyprompt.sh
if [ $? -eq 0 ]
then
    echo "fancyprompt erfolgreich ausgeführt" >> $logfile
else
    echo "Error in fancyprompt.sh" >> $errorlog
fi

chmod +x neovim.sh
./neovim.sh
if [ $? -eq 0 ]
then
    echo "neovim erfolgreich installiert" >> $logfile
else
    echo "Error in neovim.sh ausführung" >> $errorlog
fi
