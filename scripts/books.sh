BOOKS_DIR="$HOME/books/"

choice="$(find $BOOKS_DIR -type f -name "*.pdf" -o -name "*.epub" | sort -n | sed 's|.*/||; s|\.pdf$||g; s|\.epub$||' | dmenu -fn "Cascadia Code:size=14" -nb "#121212" -nf "#d4cfd0" -sb "#2b2a2a" -sf "#eeeeee" -l 10 -p "select book:")"


echo $FULE
if [ "$choice" ];
then

   full_path="$(find $BOOKS_DIR -type f -iname "$choice.pdf" -o -iname "$choice.epub")"
   zathura $full_path &> /dev/null &
fi
