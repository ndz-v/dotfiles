#!/usr/bin/env bash

# r recurse into directories
# v verbose
# h human readable numbers
# a archive mode
# u skip files that are newer on the reciever
rsync_args=(-rvhau --exclude node_modules --exclude Debug --exclude publish --exclude bin --exclude out)

rsync_up() {
    if cut -d' ' -f2 /proc/mounts | \grep -q "/media/nidzo/DATA\$"; then

        rsync "${rsync_args[@]}" "$HOME/Documents/" /media/nidzo/DATA/all_Documents --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/LaTeX/" /media/nidzo/DATA/all_LaTeX --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/Music/" /media/nidzo/DATA/all_Music --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/dev/" /media/nidzo/DATA/all_dev --log-file="$HOME/rsync.log"

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
            /media/nidzo/DATA/linux_backup --log-file="$HOME/rsync.log"
    fi
}

rsync_down() {
    if cut -d' ' -f2 /proc/mounts | \grep -q "/media/nidzo/DATA\$"; then
        rsync "${rsync_args[@]}" "${rsync_args[@]}" --exclude='dotfiles' \
            /media/nidzo/DATA/linux_backup/ \
            "$HOME/"
    fi
}

rsync_up_dir() {
    if cut -d' ' -f2 /proc/mounts | \grep -q "/media/nidzo/DATA\$"; then
        rsync "${rsync_args[@]}" --exclude='dotfiles' \
            "$HOME/$1" \
            /media/nidzo/DATA/linux_backup
    fi
}
