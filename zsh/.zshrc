#!/usr/bin/env bash

export ZSH="/home/$USER/.oh-my-zsh"
export plugins=(
    colored-man-pages
    colorize
    globalias
    zsh-autosuggestions
    sudo
)

source "$HOME/.profile"
source "$ZSH/oh-my-zsh.sh"
source "$HOME/dev/dotfiles/zsh/nidzo.zsh-theme"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # FZF completion and key bindings for terminal
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview='batcat --color=always  {}'"

export FZF_ALT_C_COMMAND='fdfind --type d . --hidden --exclude .git --exclude node_modules'
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

export FZF_DEFAULT_OPTS="--extended --multi --inline-info --layout=reverse --no-height --bind='f2:toggle-preview'"

export EDITOR=nvim # Ctrl + x Ctrl + e
export FCEDIT=nvim # fc in cli

[ -d "$HOME/dev/dotfiles/scripts" ] && export PATH=$PATH:$HOME/dev/dotfiles/scripts && source "$HOME/dev/dotfiles/scripts/goto.sh"
[ -d "$HOME/.dev-binaries/dotnet" ] && export DOTNET_ROOT=$HOME/.dev-binaries/dotnet && export PATH=$PATH:$HOME/.dev-binaries/dotnet
[ -d "$HOME/.dotnet/tools" ] && export PATH=$PATH:~/.dotnet/tools
[ -d "$HOME/.npm-global/bin" ] && export PATH=$PATH:~/.npm-global/bin # npm config set prefix '~/.npm-global'

# Lazy stuff
alias ai="sudo apt install" \
    alu="apt list --upgradeable" \
    aud="sudo apt update" \
    aug="sudo apt upgrade" \
    clean="sudo apt autoremove && sudo apt autoclean" \
    aver="apt-cache policy" \
    counthere="ls -lAh | wc -l" \
    dotfiles="code ~/dev/dotfiles" \
    zshconfig="code ~/dev/dotfiles/zsh/.zshrc" \
    vim="nvim" \
    yt="youtube-dl -ic" \
    yta="youtube-dl -xic --audio-format mp3" \
    de="trans -d :de" \
    en="trans -d :en" \
    sr="trans -d :sr" \
    bat=batcat

# PostgreSQL
if type "psql" &>/dev/null; then
    alias startpostgres="sudo service postgresql start"
    alias stoppostgres="sudo service postgresql stop"
fi

# Advanced tab completion
setopt auto_menu                                                            # automatically use menu completion
zstyle ':completion:*' menu select                                          # select completions with arrow keys
zstyle ':completion:*' group-name ''                                        # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
autoload -Uz compinit && compinit

##########################
# zsh-syntax-highlitning # must always be the last line
##########################
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
