#!/usr/bin/env bash

source ~/.dotfiles/functions.sh

install_apt_packages;
install_node;
install_npm_packages;
install_oh_my_zsh;
install_libinput_gestures;
install_vscode;
install_latte_dock;
clone_scripts;
create_sysmbolic_links;
change_shell;
