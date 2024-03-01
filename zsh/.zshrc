#!/usr/bin/env bash

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

dotfiles_dir="$HOME/.config/dotfiles"

export FZF_DEFAULT_COMMAND='fd --type f --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview='bat --color=always  {}'"
export FZF_ALT_C_COMMAND='fd --type d . --hidden --exclude .git --exclude node_modules'
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_DEFAULT_OPTS="--extended --multi --inline-info --layout=reverse --no-height --bind='f2:toggle-preview'"

export EDITOR="code --wait" # Ctrl + x Ctrl + e
export FCEDIT=nvim          # fc in cli

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$DOTNET_ROOT:$PATH:$DOTNET_ROOT/tools
zstyle ':completion:*:*:docker:*' option-stacking yes

FPATH="$dotfiles_dir/completion:${FPATH}"

libs=($dotfiles_dir/zsh/custom/lib/*.zsh)
for lib in $libs; do
    source "$lib"
done

alias vim=nvim
alias vi=nvim

plugins=($dotfiles_dir/zsh/custom/plugins/**/*.zsh)
for plugin in $plugins; do
    source "$plugin"
done

source "$dotfiles_dir/zsh/custom/aliases.sh"
source "$dotfiles_dir/zsh/custom/nidzo.zsh-theme"
source "$dotfiles_dir/zsh/custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# export RUSTUP_HOME=/home/nidzo/.config/rustup
# export CARGO_HOME=/home/nidzo/.config/cargo

[ -f "$dotfiles_dir/zsh/.env" ] && source "$dotfiles_dir/zsh/.env"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(dircolors -b $dotfiles_dir/zsh/.dircolors)"
