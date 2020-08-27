#! /usr/bin/env bash

function go() {
    cd "$(find ~ -type d | fzf)" || exit
}
