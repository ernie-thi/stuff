#!/bin/bash


logfile="$HOME/install.log"
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

### Update Packages

echo "Following: Update packages"
{ sudo $PKG update -y; sudo $PKG upgrade -y; }
echo "Updating packages completed successfully"


./bash_aliases.sh 
check_exit_status "bash_aliases"

./fancyprompt.sh
check_exit_status "fancyprompt.sh"

chmod +x neovim.sh
./neovim.sh
check_exit_status "neovim.sh"
