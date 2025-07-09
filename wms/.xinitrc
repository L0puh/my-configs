if xrandr -q | grep "HDMI-1 connected" > /dev/null ; then
        xrandr --output HDMI-1 --primary --mode 1920x1080 --below eDP-1
else
        xrandr --output eDP --mode 1920x1080
fi

slstatus &
setxkbmap -layout us,ru -option grp:toggle 
/* gnome-pomodoro & */
exec dwm 

