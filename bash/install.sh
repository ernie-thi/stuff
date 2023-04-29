#!/bin/bash

set -x

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

### Array with Packages that have to be installed
packages=(git curl zathura zathura-pdf-poppler xdotool cheese v4l-utils guvcview neofetch pwgen kitty sxhkd inxi hwinfo polybar htop tree xclip \
            spotify-client ncdu inkscape imagemagick)

### Install each package
for package in "${packages[@]}"; do
    sudo $PKG install -y $package 
    check_exit_status "Installation of $package"
done

echo "export PATH=$PATH:$HOME/bin" >> $HOME/.bashrc
source $HOME/.bashrc

./bash_aliases.sh 
check_exit_status "bash_aliases"

./fancyprompt.sh
check_exit_status "fancyprompt.sh"

chmod +x neovim.sh
./neovim.sh
check_exit_status "neovim.sh"
