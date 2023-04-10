#!/usr/bin/env bash

BRIGHTNESS=$(cat /sys/class/backlight/amdgpu_bl0/brightness)
MAX_BRIGHTNESS=$(cat /sys/class/backlight/amdgpu_bl0/max_brightness)

if [ "$1" = "up" ]; then
    NEW_BRIGHTNESS=$((BRIGHTNESS + MAX_BRIGHTNESS / 10))
else
    NEW_BRIGHTNESS=$((BRIGHTNESS - MAX_BRIGHTNESS / 10))
fi

echo $NEW_BRIGHTNESS > /sys/class/backlight/amdgpu_bl0/brightness
