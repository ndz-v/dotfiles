#!/usr/bin/env bash

sleep 10
if cut -d' ' -f2 /proc/mounts | \grep -q "/media/nidzo/DATA\$"; then
    su - nidzo -c "rsync -rvhau --exclude='dotfiles' --delete \
    /home/nidzo/.ssh \
    /home/nidzo/.thunderbird \
    /home/nidzo/Desktop \
    /home/nidzo/Documents \
    /home/nidzo/Downloads \
    /home/nidzo/LaTeX \
    /home/nidzo/Music \
    /home/nidzo/Pictures \
    /home/nidzo/Public \
    /home/nidzo/Videos \
    /home/nidzo/dev \
    /media/nidzo/DATA/linux --log-file=/home/nidzo/rsync.log"
fi
