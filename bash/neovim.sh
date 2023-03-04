#!/bin/bash

check_exit_status() {
    if [[ $? -eq 0 ]]
    then
        echo "$1 successfully terminated"
        sleep 1
    else
        echo "error in $1, check $errorlog for more infos"
    fi
}

## Install neovim from Appimage and also install Plugin Manager "VimPlug"
path="/home/$USER/nvim"
initvim="/home/$USER/stuff/dotfiles/init.vim"
nvimconfig="/home/$USER/.config/nvim/"

logfile="/home/$USER/nvim.log"
errorlog="$HOME/nvim_error.log"

if command -v nvim # könnte man auch mit which nvim prüfen -f which nvim
then
    echo "neovim ist schon installiert"
else
    if [ ! -d $path ]
    then
        mkdir $path #>>$logfile 2>>$errorlog # Creating nvim dir 
    fi
    # change dir to nvim and get nvim appimage from github
    cd $path && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage #>>$logfile 2>>$errorlog
    # make appimage executable and rename it to nvim
    sudo -s chmod +x nvim.appimage && mv nvim.appimage nvim
    # change owner of nvim
    sudo chown root:root nvim  
    sleep 5
    check_exit_status "change owner of nvim appimage"
    
    ## test nvim command
    ./nvim
    if [ $? -eq 0 ]
    then
        echo "neovim appimage wurde erfolgreich installiert" #>> $logfile
    else
        echo "neovim wurde nicht erfolgreich installiert" #>> $errorlog
    fi
    
    # add nvim binaries to PATH 
    bin="/usr/local/bin"
    sudo mv nvim $bin #>>$logfile 2>>$errorlog# move it to bin folder
    rm -rf $path # delete installation dir since no more needed
    
    ## import neovim config file
    if [ ! -d $nvimconfig ] 
    then
        mkdir -p $nvimconfig >>$logfile 2>>$errorlog
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

if [ -$? -eq 0 ]
then    
    while ! command -v pip3 # check if pip3 is installed
    do
        echo $PKG
        sleep 3 # because of debug reason
        sudo $PKG install -y python3-pip
    done
else
    echo "failed to install Vim Plug" #>> $errorlog
fi

## install Plugins inside neovim
pip3 install --user neovim
check_exit_status "pip3 --user neovim successfull"
nvim --headless +PlugInstall +qall


