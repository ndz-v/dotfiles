#!/usr/bin/env bash

start_jellyfin() {
    podman run \
        --rm \
        --detach \
        --label "io.containers.autoupdate=registry" \
        --name myjellyfin \
        --publish 8096:8096/tcp \
        --volume /run/media/nidzo/DATA/jellyfin/cache:/cache \
        --volume /run/media/nidzo/DATA/jellyfin/config:/config \
        --volume /run/media/nidzo/DATA/all_movies:/media:ro \
        docker.io/jellyfin/jellyfin:latest
}
