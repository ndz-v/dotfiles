#!/usr/bin/env bash
export LC_CTYPE=en_US.UTF-8

export ZSH="/home/$USER/.oh-my-zsh"

source "$HOME/.profile"

libs=($HOME/dev/dotfiles/zsh/lib/*.zsh)
for lib in $libs; do
    source $lib
done

plugins=($HOME/dev/dotfiles/zsh/plugins/**/*.zsh)
for plugin in $plugins; do
    source $plugin
done

source "$HOME/dev/dotfiles/zsh/aliases.sh"
source "$HOME/dev/dotfiles/zsh/nidzo.zsh-theme"
# source "$HOME/dev/dotfiles/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$HOME/dev/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # FZF completion and key bindings for terminal
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview='batcat --color=always  {}'"
export FZF_ALT_C_COMMAND='fd --type d . --hidden --exclude .git --exclude node_modules'
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_DEFAULT_OPTS="--extended --multi --inline-info --layout=reverse --no-height --bind='f2:toggle-preview'"

export EDITOR=nvim # Ctrl + x Ctrl + e
export FCEDIT=nvim # fc in cli

export PATH=$PATH:$HOME/dev/dotfiles/scripts && source "$HOME/dev/dotfiles/scripts/rsync_functions.sh"
[ -d "$HOME/.dev-binaries/dotnet" ] && export DOTNET_ROOT=$HOME/.dev-binaries/dotnet && export PATH=$PATH:$HOME/.dev-binaries/dotnet
[ -d "$HOME/.dotnet/tools" ] && export PATH=$PATH:~/.dotnet/tools
[ -d "$HOME/.npm-global/bin" ] && export PATH=$PATH:~/.npm-global/bin # npm config set prefix '~/.npm-global'
