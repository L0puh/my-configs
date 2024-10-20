DIR="$HOME/movies/"

choice="$(find $DIR -type f -name "*.mkv" -o -name "*.mp4" | sort -n | sed 's|.*/||; s|\.mkv$||g; s|\.mp4$||' | dmenu -fn "Cascadia Code:size=14" -nb "#121212" -nf "#d4cfd0" -sb "#2b2a2a" -sf "#eeeeee" -l 10 -p "select book:")"

if [ "$choice" ];
then

   full_path=$(find $DIR -type f -iname "$choice.mkv" -o -iname "$choice.mp4")
   mpv "$full_path" &> /dev/null &
fi
