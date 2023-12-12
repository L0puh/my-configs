/* set display */
xrandr --output VGA-1 --mode 1920x1080 --output LVDS-1 --above VGA-1
/* xrandr --output HDMI-1 --mode 1920x1080 --output LVDS-1 --above HDMI-1 */
/* xwallpaper --zoom ~/Pictures/forest.png */

slstatus &
/* transparent bg */
/* xcompmgr & */

/* set keymaps */ 
setxkbmap -layout us,ru -option grp:toggle 

exec dwm 
