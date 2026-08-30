CONFIG="$HOME/.config/setup/my-configs"
DIR="$HOME/.config"

echo '[1] install [2] copy [3] install scripts'
read option

if [ $option -eq "1" ]
then 
   echo "run install-packages script first"
  
   # ohmzsh setup 
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   mv $HOME/.oh-my-zsh $HOME/.config/


   cp -f $CONFIG/ohmzsh/zshrc $HOME/.zshrc 
   cp -f $CONFIG/xinitrc      $HOME/.xinitrc 

   cp -rf $CONFIG/{dunst,qutebrowser,zathura,nvim} $DIR
  
   # main env setup 
   cd $CONFIG/dwm; sudo make clean install; cd -
   cd $CONFIG/slstatus; sudo make clean install; cd -
   cd $CONFIG/dmenu; sudo make clean install; cd - 
   cd $CONFIG/st; sudo make clean install; cd - 

   

elif [ $option  -eq "2" ]; then

   echo 'copying main setup...'
   cp -rf $DIR/setup/{dmenu,st,slstatus,dwm} $CONFIG 
   cd $CONFIG/dwm; sudo make clean; cd -
   cd $CONFIG/slstatus; sudo make clean; cd -
   cd $CONFIG/dmenu; sudo make clean; cd - 
   cd $CONFIG/st; sudo make clean; cd - 


   cp -rvf $DIR/{dunst,zathura,nvim} $CONFIG

   cp -rfv $DIR/qutebrowser/userscripts $CONFIG/qutebrowser/ 
   cp -fv $DIR/qutebrowser/{config.py,autoconfig.yml,gruvbox.py} $CONFIG/qutebrowser
else 
   sudo chmod +x $CONFIG/*
   cp -fv $CONFIG/scripts/* /usr/bin/ 
fi 
