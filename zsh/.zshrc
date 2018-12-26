#!/usr/bin/env bash

export ZSH="/home/$USER/.oh-my-zsh"

ZSH_THEME="nidzo"

plugins=(
    git
    gitprompt
    colored-man-pages
    colorize
)

if [ -d "$HOME/.config/npm-global/bin" ]
then
    export PATH=$HOME/.config/npm-global/bin:$PATH
fi

if [ -d "$HOME/.local/bin" ]
then
    export PATH=~/.local/bin:$PATH
fi

if [ -d "$HOME/Projects/dotfiles/scripts" ]
then
    export PATH=$HOME/Projects/dotfiles/scripts:$PATH
fi

source "$ZSH/oh-my-zsh.sh"


# Lazy stuff
alias root='cd $(git rev-parse --show-toplevel)'
alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias list-upgrades='apt list --upgradeable'
alias dotfiles='code ~/Projects/dotfiles'

# Git aliases
alias status='git status'
alias add='git add .'
alias commit='git commit'
alias amend='git commit --amend'
alias push='git push'
alias pull='git pull'

# PostgreSQL
alias statuspostgres="sudo service postgresql status"
alias startpostgres="sudo service postgresql start; statuspostgres"
alias stoppostgres="sudo service postgresql stop; statuspostgres"

##########################
# zsh-syntax-highlitning # must always be the last line
##########################

autoload -U compinit
compinit

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

