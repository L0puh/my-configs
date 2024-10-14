#!/bin/bash

# in crontab (check every 10 min):
# PATH="/usr/bin/local/bin:/usr/bin:/bin"
# 10 * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) /usr/bin/bat_check

MUSIC=$HOME/music/sounds/8bit.mp3 
VOLUME=50
BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 4 -d " " | cut -c 1-2` < 15 ]] ; then
    DISPLAY=:0.0 herbe "LOW BATTERY" "$BATTINFO" &
    mpv --volume=$VOLUME "$MUSIC"
fi
if [[ `echo $BATTINFO | grep Not charging` && `echo $BATTINFO | cut -f 4 -d " " | cut -c 1-2` > 98 ]] ; then
    DISPLAY=:0.0 herbe "DONE: $BATTINFO" &
    mpv --volume=$VOLUME "$MUSIC"
fi
