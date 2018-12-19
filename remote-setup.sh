#!/usr/bin/env bash

echo "Installing dotfiles"

mkdir -p "$HOME/Projects/dotfiles" && \
eval "wget --no-check-certificate -O - https://github.com/nidzov/dotfiles/tarball/master | tar -xzv -C $HOME/Projects/dotfiles --strip-components=1"
eval "bash $HOME/Projects/dotfiles/setup.sh"