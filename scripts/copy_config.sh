CONFIG="$HOME/.config/my-configs"
WM="$HOME/.config/wm"

echo '[1] install [2] copy'
read option

if [ $option -eq "1" ]
then 
    echo 'Install utilities...'
    pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    pacman -S --needed vim cmake clangd zsh fzf tmux xorg xorg-xinit feh zathura cmus htop gphotofs mpv xrandr qutebrowser
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
    cp ~/.config/herbe/config.h $CONFIG/WMs/herbe
    cp ~/.config/zathura/zathurarc $CONFIG/zathura
    cp ~/.config/ranger/rc.conf $CONFIG
    cp ~/.vim/plugged/gruvbox/colors/gruvbox.vim $CONFIG/colors
    # cp ~/.vim/plugged/mountaineer.vim/colors/mountaineer-grey.vim $CONFIG/colors
    cp ~/.config/zathura/themes $CONFIG/zathura/ -r
    cp ~/.config/zathura/*.color $CONFIG/zathura/
    cp ~/.config/qutebrowser/{config.py,autoconfig.yml,gruvbox.py} $CONFIG/qutebrowser

    echo "Copying scripts to bin..."
    sudo cp ~/.config/my-configs/scripts/bat_check.sh /usr/bin/bat_check.sh
    sudo cp ~/.config/my-configs/scripts/translator.sh /usr/bin/translator
    sudo cp ~/.config/my-configs/scripts/query.sh /usr/bin/query
    sudo cp ~/.config/my-configs/scripts/books.sh /usr/bin/books

    echo "Adding permissions..."
    sudo chmod +x /usr/bin/translator
    sudo chmod +x /usr/bin/query
    sudo chmod +x /usr/bin/books
    echo 'Done!'
fi
