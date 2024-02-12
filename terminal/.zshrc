export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="clean"
zstyle ':omz:update' mode auto      # update automatically without asking

path+=('/home/lopuh/.cargo/bin')
export PATH

# export FZF_DEFAULT_OPTS='--preview "bat --style=numbers --line-range :500 {}"'
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/*' -g '!build/*'" 
export FZF_DEFAULT_OPTS='-i --color="dark,fg:#ACA98A"'


# color manuals
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias v="pactl set-sink-volume @DEFAULT_SINK@"
alias todo="grep -i TODO */*.* *.* && grep -i FIXME */*.* *.*"
alias gs="git status"
alias ls="ls --sort=extension --color=always"
alias neofetch="neofetch --disable theme icons host "

# alias anki="/home/lopuh/Downloads/anki/anki"
## MY SCRIPTS
alias b="python ~/.config/my-configs/scripts/book.py"
alias bf="$HOME/.config/my-configs/scripts/books.sh"
alias mf="$HOME/.config/my-configs/scripts/movies.sh"
alias build="sh ~/.config/my-configs/scripts/build.sh"
alias md_to_html="python ~/.config/my-configs/scripts/md_to_html.py"
alias dmenu="dmenu -fn 'Cascadia Code:size=8' -nb '#121212' -nf '#d4cfd0' -sb '#2b2a2a' -sf '#eeeeee'"
