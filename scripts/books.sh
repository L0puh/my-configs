BOOKS_DIR="$HOME/books/"

choice="$(find $BOOKS_DIR -type f -name "*.pdf" -o -name "*.epub" -o -name "*.djvu"| sort -n | sed 's|.*/||; s|\.pdf$||g; s|\.epub$||g; s|\.djvu$||g' | dmenu -l 10 -p "select book:")"


echo $FULE
if [ "$choice" ];
then

   full_path="$(find $BOOKS_DIR -type f -iname "$choice.pdf" -o -iname "$choice.epub" -o -iname "$choice.djvu")"
   zathura $full_path &> /dev/null &
fi
