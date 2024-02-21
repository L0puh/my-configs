cd /home/lopuh/books
book=$(fzf)
if [ "$book" ]
then
   zathura "$book" &
fi
cd -
