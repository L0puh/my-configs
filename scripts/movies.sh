cd /home/lopuh/movies
movie=$(fzf)

if [ $movie ]
then
   echo $movie
   mpv $movie &
fi
cd -
