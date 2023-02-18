#!/bin/bash

# Script to transfer .bashrc to new OS

# First save default .bashrc and rename it
mv /home/{$USER}/.bashrc default.bashrc

# Now copy .bashrc to homedir 
cp ../dotfiles/.bashrc /home/{$USER}/

echo ".bashrc wurde transferiert"

