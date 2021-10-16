#!/usr/bin/env bash

# r recurse into directories
# v verbose
# h human readable numbers
# a archive mode
# u skip files that are newer on the reciever
rsync_args=(-rvhu --exclude node_modules --exclude Debug --exclude publish --exclude bin --exclude out)

rsync_up() {
    if cut -d' ' -f2 /proc/mounts | \grep -q "/run/media/nidzo/DATA\$"; then

        rsync "${rsync_args[@]}" "$HOME/Documents/" /run/media/nidzo/DATA/all_Documents --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/LaTeX/" /run/media/nidzo/DATA/all_LaTeX --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/Music/" /run/media/nidzo/DATA/all_Music --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/dev/" /run/media/nidzo/DATA/all_dev --log-file="$HOME/rsync.log"

        rsync "${rsync_args[@]}" --exclude='dotfiles' --delete \
            "$HOME/.ssh" \
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
            /run/media/nidzo/DATA/linux_backup --log-file="$HOME/rsync.log"
    fi
}

rsync_down() {
    if cut -d' ' -f2 /proc/mounts | \grep -q "/run/media/nidzo/DATA\$"; then
        rsync_args=(-rvhu --exclude node_modules --exclude Debug --exclude publish --exclude bin --exclude out)
        rsync "${rsync_args[@]}" --exclude='dotfiles' \
            /run/media/nidzo/DATA/linux_backup/ \
            "$HOME/"
    fi
}

rsync_up_dir() {
    if cut -d' ' -f2 /proc/mounts | \grep -q "/run/media/nidzo/DATA\$"; then
        rsync "${rsync_args[@]}" --exclude='dotfiles' \
            "$HOME/$1" \
            /run/media/nidzo/DATA/linux_backup
    fi
}
