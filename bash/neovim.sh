#!/bin/bash

## Install neovim from Appimage and also install Plugin Manager "VimPlug"
path="$HOME/nvim"
initvim="$HOME/stuff/dotfiles/init.vim"
nvimconfig="$HOME/.config/nvim/"
logfile="$HOME/nvim.log"
errorlog="$HOME/nvim_error.log"


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


## Function to check exit code of commands
check_exit_status() {
    if [[ $? -eq 0 ]]
    then
        echo "$1 successfully terminated"
        echo "$1 successfully done" >> $logfile
        sleep 1
    else
        echo "error in $1, check $errorlog for more infos"
        echo "error in $1" >> $errorlog
        sleep 1
    fi
}


if command -v nvim # könnte man auch mit which nvim prüfen -f which nvim
then
    echo "neovim ist schon installiert"
else
    if [[ ! -d $path ]]
    then
        mkdir $path # Creating nvim dir 
        check_exit_status "Creating nvim directory in Homedir"
    fi
    # change dir to nvim and get nvim appimage from github
    cd $path && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    check_exit_status "Changing to directory nvim and curling nvim.appimage"

    # make appimage executable and rename it to nvim
    chmod +x nvim.appimage && mv nvim.appimage nvim
    check_exit_status "Making nvim.appimage executable and renaming it into nvim"
    ## change owner of nvim
    #sudo chown root:root nvim  
    #sleep 5
    #check_exit_status "change owner of nvim appimage"
    
   # ## test nvim command
   # ./nvim
   # if [ $? -eq 0 ]
   # then
   #     echo "neovim appimage wurde erfolgreich installiert" #>> $logfile
   # else
   #     echo "neovim wurde nicht erfolgreich installiert" #>> $errorlog
   # fi

    # Creating bin directory and putting nvim there
    if [[ ! -d $HOME/bin ]]; then
       mkdir -p $HOME/bin 
       check_exit_status "Created $HOME/bin directory "
    fi
    mv nvim $HOME/bin/
    check_exit_status "Moving nvim to bin directory"
    
    # add nvim binaries to PATH 
    #bin="/usr/local/bin"
    #sudo mv nvim $bin #>>$logfile 2>>$errorlog# move it to bin folder
    #rm -rf $path # delete installation dir since no more needed
    export PATH="$HOME/bin/:$PATH"
    
    ## import neovim config file
    if [[ ! -d $nvimconfig ]] 
    then
        mkdir -p $nvimconfig
        check_exit_status "importing neovim config file "
    fi

    # copy initfile
    cp $initvim $nvimconfig # >>$logfile 2>>$errorlog
    check_exit_status "copying of init.vim file"
    #if [ $? -eq 0 ]
    #then
    #    echo "init.vim wurde erfolgreich kopiert" >> $logfile
    #else
    #    echo "init.vim konnte nicht erfolgreich kopiert werden" >> $errorlog
    #fi
fi

## install vim-Plug Pluginmanager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if [[ -$? -eq 0 ]]
then    
    while ! command -v pip3 # check if pip3 is installed
    do
        echo $PKG
        sleep 3 # because of debug reason
        sudo $PKG install -y python3-pip
    done
else
    echo "Failed to install vim Plug Plugin manager"
    echo "failed to install Vim Plug" >> $errorlog
fi

## install Plugins inside neovim
cd $HOME
pip3 install --user neovim
check_exit_status "pip3 --user neovim successfull"
nvim --headless +PlugInstall +qall
