#! /usr/bin/env bash

function goto() {
    cd "$(find ~ -type d | fzf)" || exit
}
