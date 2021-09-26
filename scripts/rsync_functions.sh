#!/usr/bin/env bash

# r recurse into directories
# v verbose
# h human readable numbers
# a archive mode
# u skip files that are newer on the reciever

rsync_up() {

    rsync -rvhau --exclude='dotfiles' --delete "$HOME/.ssh" \
        "$HOME/.thunderbird" \
        "$HOME/Desktop" \
        "$HOME/Documents" \
        "$HOME/Downloads" \
        "$HOME/LaTeX" \
        "$HOME/Music" \
        "$HOME/Pictures" \
        "$HOME/Public" \
        "$HOME/Videos" \
        "$HOME/dev" \
        /media/nidzo/DATA/linux
}

rsyunc_down() {
    rsync -rvhau -P --exclude='dotfiles' \
        /media/nidzo/DATA/linux/ \
        "$HOME/"
}

rsync_up_dir() {
    rsync -rvhau --exclude='dotfiles' \
        "$HOME/$1" \
        /media/nidzo/DATA/linux
}
