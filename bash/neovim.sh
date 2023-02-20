#!/bin/bash

## Install neovim from Appimage and also install Plugin Manager "VimPlug"
path="/home/$USER/nvim"
initvim="/home/$USER/stuff/dotfiles/init.vim"
nvimconfig="/home/$USER/.config/nvim/"


if command -v nvim 
then
    echo "neovim ist schon installiert"
else
    if [ ! -d $path ]
    then
        mkdir $path
    fi
    cd $path && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    sudo -s chmod +x nvim.appimage && mv nvim.appimage nvim
    chown root:root nvim  
    
    # test nvim command
    ./nvim
    if [ $? -eq 0 ]
    then
        echo "neovim appimage wurde erfolgreich installiert" >> $log
    else
        echo "neovim wurde nicht erfolgreich installiert" >> $log
    fi
    
    # add nvim binaries to PATH 
    path="/usr/local/bin"
    mv nvim $path
    
    ## import neovim config file
    if [ ! -d $nvimconfig ] 
    then
        mkdir -p $nvimconfig
    fi

    # copy initfile
    cp $initvim $nvimconfig

    if [ $? -eq 0 ]
    then
        echo "init.vim wurde erfolgreich kopiert" >> $log
    else
        echo "init.vim konnte nicht erfolgreich kopiert werden" >> $log
    fi
fi
