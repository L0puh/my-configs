# preview
![](media.png)
# CONTENT: 
<!-- - arch + i3wm + xterm -->
- arch + dwm + st + slstatus
- zsh + omzsh 
- fzf
- z-zsh
- vim \ nvim 
    - vim-plug
    - YouCompleteMe 
    - fzf 
fonts:
cascadia code (ttf-cascadia-code)
awesome (ttf-awesome-font)

# install vim
```sh
sudo apt install vim
```
# install vim-plug
```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
# install ycm 
.vimrc
```
call plug#begin()
    Plug 'ycm-core/YouCompleteMe'
call plug#end()
```
install requirements
```sh
sudo apt install build-essential cmake vim-nox python3-dev libssl-dev pip
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --clangd-completer
```
# install zsh + tmux + fzf + omzsh
```sh
sudo apt-get install zsh bear fzf tmux
or
pacman -S zsh bear fzf tmux
```
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
install plugins for zsh
```sh
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

# install wm
```sh
sudo pacman -S xorg xorg-xinit
git clone https://git.suckless.org/st 
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/slstatus
```
compile
```
sudo make clean install

```
.xinitrc:
```
slstatus &
exec setxkbmap -layout us,ru -option grp:toggle &
exec dwm
```
patches:
https://st.suckless.org/patches/anysize/st-anysize-0.8.1.diff (no gasps for st)
# install stuff: media player, pdf-reader 
```sh
pacman -S ffmpeg zathura zathura-pfd-poppler htop cmus
```
# install config
```sh
git clone https://github.com/L0puh/my-configs.git
```


### stuff
- watch movies:     lobster-git
- watch anime:      ani-cli
- read manga:       mangal
- watch youtube:    ytfzf 
- search internet:  w3m


## theme:
```
Background color: #0f1417
Foreground color: #bfbfbf
Cursor color: #bfbfbf

Color codes for each of the 8 color slots:
0: #162025
1: #393843
2: #193a48
3: #235964
4: #193a48
5: #2a474a
6: #662b37
7: #bfbfbf

Additional color codes for the 8 color slots in bold text:
8: #365a5c
9: #662b37
10: #193a48
11: #193a48
12: #75404b
13: #662b37
14: #083842
15: #bfbfbf
```

