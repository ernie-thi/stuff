#!/bin/bash

## Install neovim from Appimage
path="/home/$USER/nvim"
initvim="/home/$USER/stuff/dotfiles/init.vim"
nvimconfig="/home/$USER/.config/nvim/"


if command -v neovim 
then
    echo "neovim ist schon installiert"
else
    if [ ! -d $path ]
    then
        mkdir $path
    fi
    cd $path
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage

    if [ $? -eq 0 ]
    then
        echo "neovim appimage wurde erfolgreich installiert" >> $log
    else
        echo "neovim wurde nicht erfolgreich installiert" >> $log
    fi

    ## import neovim config file
    if [ ! -d $nvimconfig ] 
    then
        mkdir $nvimconfig
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
