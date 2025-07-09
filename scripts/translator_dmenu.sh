#!/bin/sh
# translates selected (or copied) text

from_clipboard="$( printf "%s\n%s" "clipboard" "enter" | dmenu -p ":")"

if [ "${from_clipboard}" = "enter" ]; then
   text="$( echo "" | dmenu -p "translate: " <&- )"

   if [ -n "${text}" ];
   then 
      choice="$( printf "%s\n%s\n%s" "ru:en" "en:ru" "definition" | dmenu -p "lang: ")"
      if [ $choice = "definition" ];
      then 
         translation=$(trans -no-ansi -show-original n -d ${text})
      else 
         translation=$(trans ${choice} -j -b ${text})
      fi
      DISPLAY=:0.0 herbe "$translation"
   fi
else
   choice="$(echo -e "en:ru\nen:de\nde:en\nen:en\nru:en\nnone" | dmenu -fn "Cascadia Code:size=8" -nb "#121212" -nf "#d4cfd0" -sb "#2b2a2a" -sf "#eeeeee")"

   if [ -n "${choice}" ]; then

      text="$(xclip -out -sel)"
      if [ "${text}" = "b'\n'" ]; then
         text="$(xclip -out -sel clip)"
      fi
      
      if [ "${choice}" = "en:en" ]; then
         translation=$(trans -no-ansi -show-original n -d ${text})
      else
         # st -e sh -c "trans ${choice} -j \"${text}\"; read"
         translation=$(trans ${choice} -j -b ${text})
      fi 
      DISPLAY=:0.0 herbe "$translation"
   fi
fi
