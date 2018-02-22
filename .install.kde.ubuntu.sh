#!/usr/bin/env bash

source ~/dotfiles/functions.sh

initiate_update;
initiate_upgrade;
install_build_essentials;
install_thunderbird;
install_nano;
install_guake;
install_curl;
install_tmux;
install_postgresql;
install_node;
source ~/.bashrc;
install_typescript;
install_tslint;
install_angular_cli;
install_zsh;
install_oh_my_zsh;
install_zsh_syntax_highlighting;
clone_scripts;
create_sysmbolic_links;
install_libinput_gestures;
change_shell;