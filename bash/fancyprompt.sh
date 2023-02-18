#!/bin/bash

# determine correct package manager 
if command -v apt 
then
    PKG="apt"
elif command -v dnf 
then
    PKG="dnf"
fi

# Creating logfile
log="/home/$USER/log_fancyprompt.txt"
touch $log

# check for install powerline fonts or do so
if ( $PKG list --installed powerline-fonts || $PKG list --installed fonts-powerline )
then
    echo "Powerline-fonts sind bereits installiert" >> $log
else
    sudo $PKG install -y powerline-fonts || sudo $PKG install -y fonts-powerline
    if [ $? -eq 0 ]
    then
        echo "Powerline-fonts wurden erfolgreich installiert" >> $log
    else
        echo "Powerline-fonts konnten nicht erfolgreich installiert werden" >> $log
    fi
fi

# git clone synth-shell repo
cd /home/$USER
if [ ! -d ~/synth-shell ]
then
    git clone --recursive https://github.com/andresgongora/synth-shell.git
    if [ $? -eq 0 ]
    then
        echo "Synthshell erfolgreich geklont" >> $log
        chmod +x synth-shell/setup.sh
        cd synth-shell
        # run setup script
        ./setup.sh
        if [ $? -eq 0 ]
        then
            echo "setup.sh wurde erfolgreich beendet" >> $log
            cd /home/$USER/stuff
            cp ./dotfiles/synth-shell-prompt.config /home/$USER/.config/synth-shell/
        else
            echo "setup.sh konnte nicht erfolgreich ausgeführt werden" >> $log
        fi
    else
        echo "Synthshell nicht erfolgreich geklont" >> $log
    fi
else
    echo "Synth-Shell Dir existiert bereits" >> $log
fi

echo "fancyprompt script beendet" >> $log
