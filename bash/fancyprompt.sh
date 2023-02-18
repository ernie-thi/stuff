#!/bin/bash

# determine correct package manager command
if [ -x "$(command -v apt)" ]; then
    PKG="apt"
elif [ -x "$(command -v dnf)" ]; then
    PKG="dnf"
fi

# install powerline fonts
sudo $PKG install -y powerline-fonts
echo "Powerline-fonts installiert"

# git clone synth-shell repo
cd /home/$USER
git clone https://github.com/andresgongora/synth-shell.git
chmod +x synth-shell/setup.sh
cd synth-shell
./setup.sh

# transferring config file to .config
cd /home/$USER/stuff
cp dotfiles/synth-shell-prompt.config /home/$USER/.config/synth-shell/

# Message to confirm installation
echo "SynthShell wurde installiert (wirksam nach Shell Neustart)"
