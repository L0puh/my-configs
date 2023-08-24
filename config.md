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
sudo apt install build-essential cmake vim-nox python3-dev
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --clangd-completer
```
# install config
```sh
git clone https://github.com/L0puh/my-configs.git
```
