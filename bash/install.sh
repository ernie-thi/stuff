#!/bin/bash

### Which package manager to use
PKG=''
if [ -x "$(command -v apt)" ]; then
    echo -n "apt Paketmanager"
    PKG="apt"
elif [ -x "$(command -v dnf)" ]; then 
    echo  "dnf Paketmanager"
    PKG="dnf"
else 
    echo "Paketverwaltungssystem nicht gefunden"
fi

### Update Packages

echo "Following: Update packages"
{ sudo $PKG update -y; sudo $PKG upgrade -y; }
echo "Updating packages completed successfully"

log="/home/$USER/log_install.txt"
touch $log

./bash_aliases.sh
if [ $? -eq 0 ]
then
    echo "bash aliases erfolgreich aktualisiert" >> $log
fi

./fancyprompt.sh
if [ $? -eq 0 ]
then
    echo "fancyprompt erfolgreich ausgeführt" >> $log
fi

if [ $? -eq 0 ]
then
    echo "fancyprompt erfolgreich ausgeführt" >> $log
fi

./neovim.sh
