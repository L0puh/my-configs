xwallpaper --zoom ~/Pictures/clouds.jpg
xrandr --output VGA-1 --mode 1920x1080 --output LVDS-1 --above VGA-1
slstatus &
exec setxkbmap -layout us,ru -option grp:toggle &
exec dwm 
