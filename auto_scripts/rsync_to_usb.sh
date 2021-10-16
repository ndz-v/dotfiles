#!/usr/bin/env bash

sleep 5
if cut -d' ' -f2 /proc/mounts | \grep -q "/run/media/nidzo/DATA\$"; then

    su - nidzo -c "rsync -rvhau /home/nidzo/Documents/ /run/media/nidzo/DATA/all_Documents --log-file=/home/nidzo/rsync.log;
    rsync -rvhau /home/nidzo/LaTeX/ /run/media/nidzo/DATA/all_LaTeX --log-file=/home/nidzo/rsync.log;
    rsync -rvhau /home/nidzo/Music/ /run/media/nidzo/DATA/all_Music --log-file=/home/nidzo/rsync.log;
    rsync -rvhau /home/nidzo/dev/ /run/media/nidzo/DATA/all_dev --log-file=/home/nidzo/rsync.log"

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
    /run/media/nidzo/DATA/linux --log-file=/home/nidzo/rsync.log"
fi
