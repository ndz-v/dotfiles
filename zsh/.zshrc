#!/usr/bin/env bash

export ZSH="/home/$USER/.oh-my-zsh"

ZSH_THEME="nidzo"

plugins=(
    colored-man-pages
    colorize
    git
    node
    npm
    globalias
)

export FCEDIT=nano

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
alias root='cd $(git rev-parse --show-toplevel)'
alias ai='sudo apt install'
alias aud='sudo apt update'
alias aug='sudo apt upgrade'
alias alu='apt list --upgradeable'
alias aver='apt-cache policy'
alias dotfiles='code ~/dev/dotfiles'
alias counthere='ls -lAh | wc -l'

# Git aliases
alias status='git status'
alias add='git add .'
alias commit='git commit'
alias amend='git commit --amend'
alias push='git push'
alias pull='git pull'

# Internet
alias yt='youtube-dl -ic'
alias yta='youtube-dl -xic --audio-format mp3'

# PostgreSQL
if type "psql" &> /dev/null
then
    alias statuspostgres="sudo service postgresql status"
    alias startpostgres="sudo service postgresql start; statuspostgres"
    alias stoppostgres="sudo service postgresql stop; statuspostgres"
fi

##########################
# zsh-syntax-highlitning # must always be the last line
##########################

autoload -U compinit
compinit

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
