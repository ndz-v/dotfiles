#!/usr/bin/env bash

# r recurse into directories
# v verbose
# h human readable numbers
# a archive mode
# u skip files that are newer on the reciever
rsync_args=(-rvhuP --exclude node_modules --exclude Debug --exclude publish --exclude bin --exclude out --exclude env)

rsync_up() {
    DATA="/run/user/1000/kio-fuse-pfwUBp/smb/fritz.box/FRITZ.NAS/DATA"
    if [ -d $DATA ]; then
        rsync "${rsync_args[@]}" "$HOME/Documents/" "$DATA/all_Documents" --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/LaTeX/" "$DATA/all_LaTeX" --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/Music/" "$DATA/all_Music" --log-file="$HOME/rsync.log"
        rsync "${rsync_args[@]}" "$HOME/dev/" "$DATA/all_dev" --log-file="$HOME/rsync.log"

        rsync "${rsync_args[@]}" --exclude='dotfiles' --delete \
            "$HOME/Desktop" \
            "$HOME/Documents" \
            "$HOME/Downloads" \
            "$HOME/LaTeX" \
            "$HOME/Music" \
            "$HOME/Pictures" \
            "$HOME/Public" \
            "$HOME/Videos" \
            "$HOME/dev" \
            "$DATA/linux_backup" --log-file="$HOME/rsync.log"
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
