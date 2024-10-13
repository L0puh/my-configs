CONFIG="$HOME/.config/my-configs"
WM="$HOME/.config"

echo '[1] install [2] copy'
read option

if [ $option -eq "1" ]
then 
    echo 'Install utilities...'
    pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
    pacman -S --needed vim cmake clangd zsh fzf xorg xorg-xinit feh zathura cmus htop mpv xrandr qutebrowser bc
    pacman -S --needed libxinerama herbe wget curl make gcc gdb 

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    cd ~/.vim/plugged/YouCompleteMe
    python3 install.py --clangd-completer
   
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    mkdir ~/wm
    mkdir ~/wm/patches
    git clone https://git.suckless.org/st ~/wm/st
    git clone https://git.suckless.org/dwm ~/wm/dwm
    git clone https://git.suckless.org/slstatus ~/wm/slstatus
    cd ~/wm/patches
    wget https://dwm.suckless.org/patches/status2d/dwm-status2d-20200508-60bb3df.diff
    cd ~/wm/dwm
    patch -p1 < ../patches/dwm-status2d-20200508-60bb3df.diff
    sudo make clean install
else 
    echo 'Copying wm configs...'
    cp $WM/slstatus/config.h $CONFIG/status_line/slstatus/
    cp $WM/st/config.h $CONFIG/terminal/st
    cp $WM/dwm/config.h $CONFIG/wms/dwm

    echo 'Copying terminal configs...'
    cp ~/.vimrc $CONFIG/terminal
    cp ~/.xinitrc $CONFIG/wms
    cp ~/.zshrc $CONFIG/terminal 

    echo 'Copying other...'
    cp ~/.config/herbe/{config.h,patches} $CONFIG/herbe -r
    cp ~/.config/zathura/zathurarc $CONFIG/zathura
    cp ~/.vim/plugged/gruvbox/colors/gruvbox.vim $CONFIG/colors
    cp ~/.config/zathura/themes $CONFIG/zathura/ -r
    cp ~/.config/zathura/*.color $CONFIG/zathura/
    cp ~/.config/qutebrowser/{config.py,autoconfig.yml,gruvbox.py} $CONFIG/qutebrowser

    echo "Copying scripts to bin..."
    sudo cp ~/.config/my-configs/scripts/bat_check.sh /usr/bin/bat_check
    sudo cp ~/.config/my-configs/scripts/translator.sh /usr/bin/translator
    sudo cp ~/.config/my-configs/scripts/query.sh /usr/bin/query
    sudo cp ~/.config/my-configs/scripts/books.sh /usr/bin/books

    echo "Adding permissions..."
    sudo chmod +x /usr/bin/translator
    sudo chmod +x /usr/bin/bat_check
    sudo chmod +x /usr/bin/query
    sudo chmod +x /usr/bin/books
    echo 'Done!'
fi
