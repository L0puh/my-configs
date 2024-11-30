FOLDER="$HOME/music/radio"

choice="$(find $FOLDER -type f -name "*.pls" | sort -n | sed 's|.*/||;' | dmenu  -l 10 -p "select station:")"

if [ "$choice" ];
then
   full_path="$(find $FOLDER -type f -iname $choice)"
   st -e mpv --volume=30 $full_path &> /dev/null &
fi

