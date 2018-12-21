#!/usr/bin/env bash

export ZSH="/home/$USER/.oh-my-zsh"

ZSH_THEME="nidzo"

plugins=(
    git
    gitprompt
    colored-man-pages
    colorize
)

export PATH=~/.npm-global/bin:$PATH

source $ZSH/oh-my-zsh.sh


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

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

