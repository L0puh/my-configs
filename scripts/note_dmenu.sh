NOTES_DIR="$HOME/storage/notes"
FORMATS=".tex\n.md"

choice="$(find $NOTES_DIR -type f -name "*.md" -o -name "*.tex" | sort -n | sed 's|.*/||; s|\.tex$||g; s|\.md$||' | dmenu  -l 10 -p "select note:")"

cd_command="cd $NOTES_DIR"
echo $FULE
if [ "$choice" ];
then

   full_path="$(find $NOTES_DIR -type f -iname "$choice.md" -o -iname "$choice.tex")"
   if [ "$full_path" ];
   then
      st -e vim --cmd "$cd_command" $full_path  &> /dev/null &
   else 
      format=$( printf '%s\n%s\n' ".md" ".tex" | dmenu -p "select format:")
      new_note="$NOTES_DIR/$choice$format"
      st -e vim --cmd "$cd_command" $new_note &> /dev/null &
   fi
fi
