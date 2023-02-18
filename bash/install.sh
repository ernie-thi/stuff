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

# TODO:  <17-02-23, programme die zu installieren sind einfügen> #

./bash_aliases.sh
./fancyprompt.sh
