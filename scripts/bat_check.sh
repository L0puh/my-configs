#!/bin/bash

# in crontab (check every 10 min):
# PATH="/usr/local/bin:/usr/bin:/bin"
# 10 * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) /usr/bin/bat_check.sh

BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 4 -d " " | cut -c 1-2` < 15 ]] ; then
    mpv ~/music/sounds/notification.mp3
    DISPLAY=:0.0 herbe "LOW BATTERY" "$BATTINFO"
fi
if [[ `echo $BATTINFO | grep Not charging` && `echo $BATTINFO | cut -f 4 -d " " | cut -c 1-2` > 98 ]] ; then
    mpv ~/music/sounds/notification.mp3
    DISPLAY=:0.0 herbe "DONE: $BATTINFO"
fi
