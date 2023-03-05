#!/bin/bash

# Script to transfer .bash_aliases to new OS
cp ../dotfiles/.bash_aliases $HOME 2>>$HOME/error_install.log

if [[ $? -eq 0 ]]; then
    echo "bash_aliases wurde transferiert" >> $HOME/install.log
else
    echo "bash_aliases wurde nicht erfolgreich kopiert" >> $HOME/install.log
    echo "Fehler in bash_aliases kopiervorgang"
fi
