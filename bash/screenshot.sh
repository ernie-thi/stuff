#!/usr/bin/env bash
## bash script to record a screenshot with frame using imagemagick import and
#sending it to clipboard and also saving it in ~/Bilder/Bildschirmfotos


date=$(date +%Y-%m-%d_%H_%M_%S) 
import -frame ~/Bilder/Bildschirmfotos/Screenshot@$date.png 
xclip -selection clipboard -t image/png ~/Bilder/Bildschirmfotos/Screenshot@$date.png

