export ZSH="$HOME/.config/.oh-my-zsh"


ZSH_THEME="clean"

zstyle ':omz:update' mode auto      

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

export PATH="/home/lopuh/.local/bin:/usr/local/bin:/usr/bin:/bin"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*' -g '!build/*' -g '!texfiles/*'" 
export FZF_DEFAULT_OPTS='-i --pointer "> " --color="dark,fg:#ACA98A" --preview "head -n 50 {}"' 
export EDITOR='vim'

plugins=(
   git 
   z 
   zsh-autosuggestions 
   zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias gs="git status"
alias bc="bc -ql"
alias ls="ls --sort=extension --color=always"
alias todo="grep -i TODO */*.* *.* && grep -i FIXME */*.* *.*"
alias neofetch="neofetch --disable theme icons host "
alias makec="compiledb make"
alias md_to_html="python ~/.config/my-configs/scripts/md_to_html.py"
alias ardc="arduino-cli compile -b arduino:avr:uno ."
alias ardu="arduino-cli upload -b arduino:avr:uno -p /dev/ttyUSB0"
alias ardr="arduino-cli compile -b arduino:avr:uno . && arduino-cli upload -b arduino:avr:uno -p /dev/ttyUSB0"
alias get_idf='. $HOME/code/esp/esp-idf/export.sh'

bindkey -v

