/* set display */
/* xrandr --output VGA-1 --mode 1920x1080 --output LVDS-1 --above VGA-1 */
/* xrandr --output HDMI-1 --mode 1920x1080 --output LVDS-1 --above HDMI-1 */

/* xrandr --auto --output HDMI-A-0 --mode 1920x1080 --below eDP --output eDP-1 --mode 1920x1080 */
/* xrandr --auto --output eDP --above HDMI-A-0 */
/* xwallpaper --zoom ~/Pictures/forest.png */
/* xrandr --output eDP --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal */

if xrandr -q | grep "HDMI-A-0 connected" > /dev/null ; then

        xrandr --output "HDMI-A-0" --primary --pos "0x0" --scale 0x0 --mode 1920x1080

        /* xrandr --output HDMI-A-0 --mode 1920x1080 */
        xrandr --output eDP --off
else
        xrandr --output eDP --mode 1920x1080
        /* xrandr --output HDMI1 --off */
fi


slstatus &
/* transparent bg */
/* xcompmgr & */

/* set keymaps */ 
setxkbmap -layout us,ru -option grp:toggle 

exec dwm 
