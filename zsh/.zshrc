#!/usr/bin/env bash

export ZSH="/home/$USER/.oh-my-zsh"

export ZSH_THEME="nidzo"

export plugins=(
    colored-man-pages
    colorize
    git
    globalias
    ng
    node
    npm
    zsh-autosuggestions
)

# Ctrl + x Ctrl + e
export EDITOR=nano

# fc in cli
export FCEDIT=code

# if [ -d "$HOME/.dotnetframework" ]
# then
#     export PATH=$PATH:$HOME/.dotnetframework
#     export DOTNET_ROOT=$HOME/.dotnetframework
# fi

if [ -d "$HOME/.dotnet/tools" ]
then
    export PATH=~/.dotnet/tools:$PATH
fi

# npm config set prefix '~/.npm-global'
if [ -d "$HOME/.npm-global/bin" ]
then
    export PATH=~/.npm-global/bin:$PATH
fi

if [ -d "$HOME/.local/bin" ]
then
    export PATH=~/.local/bin:$PATH
fi

if [ -d "$HOME/dev/dotfiles/scripts" ]
then
    export PATH=$HOME/dev/dotfiles/scripts:$PATH
fi

source "$ZSH/oh-my-zsh.sh"

# Lazy stuff
alias ai="sudo apt install"
alias alu="apt list --upgradeable"
alias aud="sudo apt update"
alias aug="sudo apt upgrade"
alias aver="apt-cache policy"
alias counthere="ls -lAh | wc -l"
alias dotfiles="code ~/dev/dotfiles"
alias zshconfig="code ~/dev/dotfiles/zsh/.zshrc"

# Internet
alias yt="youtube-dl -ic"
alias yta="youtube-dl -xic --audio-format mp3"

# PostgreSQL
if type "psql" &> /dev/null
then
    alias startpostgres="sudo service postgresql start; statuspostgres"
    alias statuspostgres="sudo service postgresql status"
    alias stoppostgres="sudo service postgresql stop; statuspostgres"
fi

# Advanced tab completion
autoload -U compinit
compinit

##########################
# zsh-syntax-highlitning # must always be the last line
##########################
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
