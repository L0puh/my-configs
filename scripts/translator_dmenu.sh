
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
