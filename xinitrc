


export DISPLAY=:0

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi


if xrandr -q | grep "HDMI-A-0 connected" > /dev/null ; then
   xrandr --output HDMI-A-0 --primary --mode 1920x1080 --left-of eDP
else
        xrandr --output eDP --mode 1920x1080
fi

feh --bg-fill $HOME/pics/gruv-samurai-cyberpunk2077.png
dunst &
slstatus &
setxkbmap -layout us,ru -option grp:toggle
systemctl --user import-environment DISPLAY
exec dwm

