#!/bin/bash

check_exit_status() {
    if [[ $? -eq 0 ]]
    then
        echo "$1 successfully terminated"
    else
        echo "error in $1, check $errorlog for more infos"
    fi
}

# determine correct package manager 
if command -v apt 
then
    PKG="apt"
elif command -v dnf 
then
    PKG="dnf"
fi

# Creating logfile
logfile="/home/$USER/log_fancyprompt.log"
errorlog="$HOME/fancyprompt_error.log"

# check for install powerline fonts or do so
if ( $PKG list --installed powerline-fonts || $PKG list --installed fonts-powerline ) # check wheter correct fonts are yet installed
then
    echo "Powerline-fonts sind bereits installiert" >> $logfile
else
    sudo $PKG install -y powerline-fonts || sudo $PKG install -y fonts-powerline >>$logfile 2>>$errorlog    # install fonts if necessary
    check_exit_status "powerline-fonts"
    #if [ $? -eq 0 ]
    #then
    #    echo "Powerline-fonts wurden erfolgreich installiert" >> $logfile
    #else
    #    echo "Powerline-fonts konnten nicht erfolgreich installiert werden" >> $errorlog
    #fi
fi

# git clone synth-shell repo
cd /home/$USER
if [ ! -d ~/synth-shell ]       # check for existence of synthshell
then
    git clone --recursive https://github.com/andresgongora/synth-shell.git >>$logfile 2>>$errorlog      # if not so, clone it
    if [ $? -eq 0 ]
    then
        echo "Synthshell erfolgreich geklont" >> $logfile
        chmod +x synth-shell/setup.sh 2>>$errorlog # make it executable
        check_exit_status "chmod synth-shell setup.sh"
        cd synth-shell                      # change dir
        # run setup script
        ./setup.sh
        if [ $? -eq 0 ]
        then
            echo "setup.sh wurde erfolgreich beendet" >> $logfile
            cd /home/$USER/stuff        # switch to correct dir
            cp ./dotfiles/synth-shell-prompt.config /home/$USER/.config/synth-shell/ # copy template of config
        else
            echo "setup.sh konnte nicht erfolgreich ausgeführt werden" >> $errorlog
        fi
    else
        echo "Synthshell nicht erfolgreich geklont" >> $errorlog
    fi
else
    echo "Synth-Shell Dir existiert bereits" >> $logfile
fi

echo "fancyprompt script beendet" >> $logfile
