CONFIG="$HOME/.config/my-configs"
WM="$HOME/wm"
echo 'Copying wm configs...'
cp $WM/slstatus/config.h $CONFIG/status_line/slstatus/
cp $WM/st/config.h $CONFIG/terminal/st
cp $WM/dwm/config.h $CONFIG/WMs/dwm
echo 'Copying terminal configs...'
cp ~/.tmux.conf $CONFIG/terminal
cp ~/.vimrc $CONFIG/terminal
cp ~/.xinitrc $CONFIG/WMs
cp ~/.zshrc $CONFIG/terminal 
echo 'Copying other...'
cp ~/.config/zathura/zathurarc $CONFIG/zathura
cp ~/.config/lobster/lobster_config.txt $CONFIG/stuff
cp ~/.config/shellcaster/config.toml $CONFIG/stuff
cp ~/.vim/plugged/gruvbox/colors/gruvbox.vim $CONFIG/colors
cp ~/.vim/plugged/mountaineer.vim/colors/mountaineer-grey.vim $CONFIG/
cp ~/.config/zathura/themes $CONFIG/zathura/ -r
cp ~/.config/zathura/*.color $CONFIG/zathura/

echo 'Done!'
