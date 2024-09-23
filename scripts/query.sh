QUERY=https://lite.duckduckgo.com/lite/?q=
BROWSER=qutebrowser

query="$( echo "" | dmenu -fn "Cascadia Code:size=8" -nb "#121212" -nf "#d4cfd0" -sb "#2b2a2a"\
                     -sf "#eeeeee" -p "search: " <&- )"

if [ -n "${query}" ];
then 
   $BROWSER $QUERY"${query}"  &> /dev/null &
fi
