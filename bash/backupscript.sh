#!/bin/bash

#Check to make sure the user has entered exactly two arguments.

if [[ $# -ne 2 ]]; then
    echo "Usage: backupscript.sh <source_dir> <target_dir>"
    echo "Please try again."
    exit 1
fi

# Check to see wether rsync is installed
if  ! command -v rsync > /dev/null 2>&1; then # send stdout and stderr to null 
    echo "This script requires rsync to be installed"
    echo "Please use your distros package manager to install it"
    exit 2  ## common to have diffrent exit codes for diffrent problems
fi

# Capture current date and store it in the format YYYY-MM-DD (easier to sort)
current_date=$(date +%Y-%m-%d)

# $2 is the target path given as an argument to the script
rsync_options="-avb --backup-dir $2/$current_date --delete" # --dry-run" # always run a rsync script in dry run first

$(which rsync) $rsync_options $1 $2/current >> backup_$current_date.log
