#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/cuts"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 2; done

# Launch the bar
polybar -q top -c "$DIR"/config.ini &
polybar -q bottom -c "$DIR"/config.ini &
if [[ $(xrandr --query | grep 'HDMI-A-0') == *connected* ]]; then
   polybar top_external -c $HOME/.config/polybar/cuts/config.ini & 
   polybar bottom_external -c $HOME/.config/polybar/cuts/config.ini &
fi
