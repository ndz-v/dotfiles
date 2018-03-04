#!/usr/bin/env bash

source ~/dotfiles/functions.sh

install_apt_packages;
install_node;
install_npm_packages;
install_oh_my_zsh;
change_shell;
clone_scripts;
create_sysmbolic_links;
install_libinput_gestures;