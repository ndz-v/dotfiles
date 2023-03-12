#!/usr/bin/env bash

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

dotfiles_dir="$HOME/.config/dotfiles"

libs=($dotfiles_dir/zsh/custom/lib/*.zsh)
for lib in $libs; do
    source $lib
done

plugins=($dotfiles_dir/zsh/custom/plugins/**/*.zsh)
for plugin in $plugins; do
    source $plugin
done

source "$dotfiles_dir/zsh/.env"

source "$dotfiles_dir/zsh/custom/aliases.sh"
source "$dotfiles_dir/zsh/custom/nidzo.zsh-theme"
# source "$dotfiles_dir/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source "$dotfiles_dir/zsh/custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview='bat --color=always  {}'"
export FZF_ALT_C_COMMAND='fd --type d . --hidden --exclude .git --exclude node_modules'
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_DEFAULT_OPTS="--extended --multi --inline-info --layout=reverse --no-height --bind='f2:toggle-preview'"

export EDITOR="code --wait" # Ctrl + x Ctrl + e
export FCEDIT=nvim          # fc in cli

export PATH=$PATH:$dotfiles_dir/scripts &&
    source "$dotfiles_dir/scripts/rsync_functions.sh"

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$DOTNET_ROOT:$PATH:$DOTNET_ROOT/tools

# [ -d "$HOME/.dev-binaries/dotnet" ] && export DOTNET_ROOT=$HOME/.dev-binaries/dotnet && export PATH=$PATH:$HOME/.dev-binaries/dotnet
# [ -d "$HOME/.dotnet/tools" ] && export PATH=$PATH:~/.dotnet/tools
[ -d "$HOME/.local/.npm-global/bin" ] && export PATH=$PATH:~/.npm-global/bin # npm config set prefix '~/.local/.npm-global'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
