echo "DISPLAY=:0.0 herbe '$1'" | at "$2"
echo "mpv --volume=30 $HOME/music/sounds/notification.mp3" | at "$2"
