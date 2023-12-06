CONFIG="$HOME/.config/my-configs"
WM="$HOME/wm"

echo '[1] install [2] copy'
read option

if [ $option -eq "1" ]
then 
    echo 'Install utilities...'
    pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    pacman -S --needed vim cmake clangd zsh fzf tmux xorg xorg-xinit lobster-git feh zathura cmus htop gphotofs mpv xrandr xcompmgr 
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cd ~/.vim/plugged/YouCompleteMe
    python3 install.py --clangd-completer
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    mkdir ~/wm
    mkdir ~/wm/patches
    git clone https://git.suckless.org/st ~/wm/st
    git clone https://git.suckless.org/dwm ~/wm/dwm
    git clone https://git.suckless.org/slstatus ~/wm/slstatus
    cd ~/wm/patches
    wget https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff
    whet https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff
    cd ~/wm/st
    patch -p1 < ../patches/st-anysize-20220718-baa9357.diff
    patch -p1 < ../patches/st-alpha-20220206-0.8.5.diff
    yay -S librewolf pyradio
else 
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
    cp ~/.vim/plugged/mountaineer.vim/colors/mountaineer-grey.vim $CONFIG/colors
    cp ~/.config/zathura/themes $CONFIG/zathura/ -r
    cp ~/.config/zathura/*.color $CONFIG/zathura/
    cp ~/.config/shellcaster/config.toml ~/.config/shellcaster/podcasts.txt $CONFIG/shellcaster
    cp ~/.config/qutebrowser/config.py ~/.config/qutebrowser/gruvbox.py $CONFIG/qutebrowser
    cp ~/.config/pyradio $CONFIG -r 
    echo 'Done!'
fi
