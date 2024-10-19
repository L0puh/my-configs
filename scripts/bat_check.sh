#!/bin/bash

# in crontab (check every 10 min):
# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/aws/bin:/root/binkkjkk
# */10 * * * * XDG_RUNTIME_DIR=/run/user/$(id -u) /usr/bin/bat_check

MUSIC=$HOME/music/sounds/8bit.mp3
VOLUME=50
BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 4 -d " " | cut -c 1-2` < 20 ]] ; then
    DISPLAY=:0 herbe "LOW BATTERY" "$BATTINFO" &
    mpv --volume=$VOLUME "$MUSIC"
fi

tmp=`echo $BATTINFO | cut -f 5 -d " " | cut -c 1-2`
if [[ `(echo $BATTINFO | grep "Not charging" || echo $BATTINFO | grep "Full")` &&  ($tmp > 98 || $tmp = 10) ]] ; then
    DISPLAY=:0 herbe "DONE: $BATTINFO" &
    mpv --volume=$VOLUME "$MUSIC"
fi

