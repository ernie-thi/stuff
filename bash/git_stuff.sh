#!/bin/bash

set -x

logfile="$HOME/git_clone.log"
errorlog="$HOME/error_install.log"

check_exit_status() {
    if [[ $? -eq 0 ]]
    then
        echo "$1 successfully terminated"
        echo "$1 successfully terminated" >> $logfile
    else
        echo "error in $1, check $errorlog for more infos"
        echo "error in $1" >> $errorlog
    fi
}

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

if [ -x "$(command -v git --version)" ]; then
    echo "Installing git first" >> $logfile
    sudo $PKG install git
    check_exit_status "installing git"
fi

https://github.com/ernie-thi/stuff.git
if [ ! -d $HOME/gh ]; then
    mkdir $HOME/gh
    check_exit_status "github directory creation" 
fi
