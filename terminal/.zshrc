export ZSH="$HOME/.config/.oh-my-zsh"

ZSH_THEME="clean"

zstyle ':omz:update' mode auto      

export PATH="/usr/local/bin:/usr/bin:/bin:/home/lopuh/.local/bin"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*' -g '!build/*'" 
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

bindkey -v
