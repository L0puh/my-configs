#!/bin/sh
# translates selected (or copied) text

choice="$(echo -e "en:ru\nen:de\nde:en\nen:en\nru:en\nnone" | dmenu -fn "Cascadia Code:size=8" -nb "#121212" -nf "#d4cfd0" -sb "#2b2a2a" -sf "#eeeeee")"

if [ -n "${choice}" ]; then

   text="$(xclip -out -sel)"
   if [ "${text}" = "b'\n'" ]; then
      text="$(xclip -out -sel clip)"
   fi

   # st -e sh -c "trans ${choice} -j \"${text}\"; read"
   translation=$(trans ${choice} -j -b ${text})
   DISPLAY=:0.0 herbe "$translation"
fi

