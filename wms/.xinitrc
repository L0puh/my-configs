export DISPLAY=:0
if xrandr -q | grep "HDMI-1 connected" > /dev/null ; then
        xrandr --output HDMI-1 --primary --mode 1920x1080 --left-of eDP-1
else
        xrandr --output eDP --mode 1920x1080
fi

slstatus &
setxkbmap -layout us,ru -option grp:toggle 
systemctl --user import-environment DISPLAY
exec dwm 

