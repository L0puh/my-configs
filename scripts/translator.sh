#!/bin/sh
# translates selected (or copied) text

choice="$(echo -e "eng:ru\neng:eng\neng:de\nde:eng" | dmenu -fn "Cascadia Code:size=8" -nb "#121212" -nf "#d4cfd0" -sb "#2b2a2a" -sf "#eeeeee")"
text="$(xclip -out -sel)"
if [ "${text}" = "b'\n'" ]; then
   text="$(xclip -out -sel clip)"
fi
st -e sh -c "trans ${choice} -j \"${text}\"; read"

