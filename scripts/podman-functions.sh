#!/usr/bin/env bash

start_jellyfin() {
    podman run \
        --rm \
        --detach \
        --label "io.containers.autoupdate=registry" \
        --name myjellyfin \
        --publish 8096:8096/tcp \
        --volume /run/user/1000/kio-fuse-pfwUBp/smb/fritz.box/FRITZ.NAS/DATA/jellyfin/cache:/cache \
        --volume /run/user/1000/kio-fuse-pfwUBp/smb/fritz.box/FRITZ.NAS/DATA/jellyfin/config:/config \
        --volume /run/user/1000/kio-fuse-pfwUBp/smb/fritz.box/FRITZ.NAS/DATA/all_movies:/media:ro \
        docker.io/jellyfin/jellyfin:latest
}
