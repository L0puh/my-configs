# CONTENT: 
- zsh + omzsh 
- fzf
- z-zsh
- vim \ nvim 
    - vim-plug
    - YouCompleteMe 
    - fzf 

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
additional stuff: 
```sh
sudo apt-get install zsh  bear fzf tmux
```
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
```sh
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
```
# install config
```sh
git clone https://github.com/L0puh/my-configs.git
```
