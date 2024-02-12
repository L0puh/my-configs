if [ ! $1 ]
then 
   echo no loop found
   if [ ! $2 ]
   then 
      echo play brown 1 time
      mpv  $HOME/music/brown_noise.opus
   else 
      echo play $2 1 time
      mpv $HOME/music/$2_noise.opus
   fi

else
   if [ ! $2 ]
   then 
      echo play $1 times
      mpv --loop=$1 $HOME/music/brown_noise.opus
   else 
      echo play $2 $1 times
      mpv $HOME/music/$2_noise.opus
   fi
fi

