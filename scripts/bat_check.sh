#!/bin/bash

# in crontab:
# 15 * * * * /path/to/bat_check.sh 

BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 4 -d " " | cut -c 1-2` < 15 ]] ; then
    DISPLAY=:0.0 /usr/bin/xmessage -print LOW BATTERY: $BATTINFO"!" -bg "#121212" -fg "#d4cfd0"
fi
if [[ `echo $BATTINFO | grep charging` && `echo $BATTINFO | cut -f 4 -d " " | cut -c 1-2` > 98 ]] ; then
    DISPLAY=:0.0 /usr/bin/xmessage -print DONE: $BATTINFO"!" -bg "#121212" -fg "#d4cfd0"
fi
