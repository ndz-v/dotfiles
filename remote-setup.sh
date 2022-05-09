#!/usr/bin/env bash

echo "Installing dotfiles"

mkdir -p "$HOME/.config/dotfiles" &&
    eval "wget --no-check-certificate -O - https://github.com/ndz-v/dotfiles/tarball/fedora | tar -xzv -C $HOME/.config/dotfiles --strip-components=1"
eval "bash $HOME/.config/dotfiles/setup.sh 2>&1 | tee setup.log"
