#!/bin/bash

# Creating logfile
logfile="$HOME/log_fancyprompt.log"
errorlog="$HOME/fancyprompt_error.log"


check_exit_status() {
    if [[ $? -eq 0 ]]
    then
        echo "$1 successfully terminated" >> $logfile
        echo "$1 successfully terminated"
    else
        echo "error in $1, check $errorlog for more infos"
        echo "error in $1" >> $errorlog
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


# check for install powerline fonts or do so
if ( dpkg-query -W powerline-fonts || dpkg-query -W fonts-powerline) # check wheter correct fonts are yet installed
then
    echo "Powerline-fonts sind bereits installiert" >> $logfile
else
    sudo $PKG install -y powerline-fonts || sudo $PKG install -y fonts-powerline >>$logfile 2>>$errorlog    # install fonts if necessary
    check_exit_status "powerline-fonts"
fi

# git clone synth-shell repo
cd $HOME
if [[ ! -d ~/synth-shell ]]       # check for existence of synthshell
then
    git clone --recursive https://github.com/andresgongora/synth-shell.git 2>>$errorlog      # if not so, clone it
    if [ $? -eq 0 ]
    then
        check_exit_status "git clone synthshell "
        chmod +x synth-shell/setup.sh 2>>$errorlog # make it executable
        check_exit_status "chmod synth-shell setup.sh"
        cd synth-shell          # change dir
        # run setup script
        ./setup.sh
        if [ $? -eq 0 ]
        then
            check_exit_status "setup.sh"
            cd $HOME/stuff        # switch to correct dir
            cp ./dotfiles/synth-shell-prompt.config $HOME/.config/synth-shell/ # copy template of config
            check_exit_status "synthshell config file kopieren "
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
