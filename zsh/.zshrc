#!/usr/bin/env bash

export ZSH="/home/$USER/.oh-my-zsh"
export plugins=(
  colored-man-pages
  colorize
  globalias
  ng
  node
  npm
  zsh-autosuggestions
  sudo
)

source "$HOME/.profile"
source "$ZSH/oh-my-zsh.sh"
source "$HOME/dev/dotfiles/zsh/nidzo.zsh-theme"

source "/usr/share/doc/fzf/examples/completion.zsh"   # FZF completion
source "/usr/share/doc/fzf/examples/key-bindings.zsh" # FZF key bindings for terminal

export EDITOR=nvim # Ctrl + x Ctrl + e
export FCEDIT=nvim # fc in cli
export FZF_DEFAULT_OPTS="--layout=reverse"

[ -d "$HOME/dev/dotfiles/scripts" ] && export PATH=$PATH:$HOME/dev/dotfiles/scripts && source "$HOME/dev/dotfiles/scripts/goto.sh"
[ -d "$HOME/.dev-binaries/dotnet" ] && export DOTNET_ROOT=$HOME/.dev-binaries/dotnet && export PATH=$PATH:$HOME/.dev-binaries/dotnet
[ -d "$HOME/.dotnet/tools" ] && export PATH=$PATH:~/.dotnet/tools
[ -d "$HOME/.local/bin" ] && export PATH=$PATH:~/.local/bin
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
  sr="trans -d :sr"

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
