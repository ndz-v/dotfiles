#!/usr/bin/env bash

# Ask for admin credentials
sudo -v

# Update and upgrade system
apt update
apt upgrade

# Install apps
apps=(
    build-essentials
    git
    guake
    zsh
    zsh-syntax-highlighting
    shellcheck
    curl
    thunderbird
)
for app in ${apps[*]}
do
    sudo apt install "$app"
done

# Install Oh-My-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


# Create autostart file for guake
eval "cat /usr/share/guake/data/guake.template.desktop >> $HOME/.config/autostart/guake.desktop"


# Check if it's a laptop system
if [ -d "/sys/class/power_supply" ]; then
    add-apt-repository ppa:linrunner/tlp
    apt-get update
    apt-get install tlp nvidia-driver-390
    tlp start
    
    sudo gpasswd -a "$USER" input
    sudo apt-get install xdotool wmctrl libinput-tools
    
    cd ~ || exit
    git clone https://github.com/bulletmark/libinput-gestures.git
    cd libinput-gestures || exit
    sudo make install
    cd .. || exit
    rm -rf libinput-gestures
    
    libinput-gestures-setup autostart
    libinput-gestures-setup start
fi

# Install latte dock if KDE desktop environment
if [  "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
    sudo apt install cmake extra-cmake-modules qtdeclarative5-dev libqt5x11extras5-dev libkf5iconthemes-dev libkf5plasma-dev libkf5windowsystem-dev libkf5declarative-dev libkf5xmlgui-dev libkf5activities-dev build-essential libxcb-util-dev libkf5wayland-dev git gettext libkf5archive-dev libkf5notifications-dev libxcb-util0-dev libsm-dev libkf5crash-dev libkf5newstuff-dev
    
    cd ~ || exit
    git clone https://github.com/KDE/latte-dock.git
    cd latte-dock || exit
    sh install.sh
    cd .. || exit
    rm -rf latte-dock
    
    # create symbolic links for kde settings
    
    ln -sfn "$HOME/Projects/dotfiles/kde/kcminputrc" "$HOME/.config/kcminputrc"
    
    ln -sfn "$HOME/Projects/dotfiles/kde/kglobalshortcutsrc" "$HOME/.config/kglobalshortcutsrc"
    
    ln -sfn "$HOME/Projects/dotfiles/kde/plasma-org.kde.plasma.desktop-appletsrc" "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
    
    ln -sfn "$HOME/Projects/dotfiles/kde/touchpadrc" "$HOME/.config/touchpadrc"
fi

# Install VS Code extensions
extensions=(
    donjayamanne.githistory
    dracula-theme.theme-dracula
    eamodio.gitlens
    PKief.material-icon-theme
    shakram02.bash-beautify
    shd101wyy.markdown-preview-enhanced
    sidneys1.gitconfig
    timonwong.shellcheck
    yycalm.linecount
)
for extension in ${extensions[*]}
do
    code --install-extension "$extension"
done

# Create symbolic links

# git
gitconfig="$HOME/Projects/dotfiles/git/.gitconfig"
gitconfig_location="$HOME/.gitconfig"
ln -sfn "$gitconfig" "$gitconfig_location"

# guake
guake="$HOME/Projects/dotfiles/guake/user"
guake_location="$HOME/.config/dconf/user"
ln -sfn "$guake" "$guake_location"

# nano
nanorc="$HOME/Projects/dotfiles/nano/.nanorc"
nanorc_location="$HOME/.nanorc"
ln -sfn "$nanorc" "$nanorc_location"

# VS Code
vscode_settings="$HOME/Projects/dotfiles/vscode/settings.json"
vscode_settings_location="$HOME/.config/Code/User/settings.json"
ln -sfn "$vscode_settings" "$vscode_settings_location"

vscode_keybindings="$HOME/Projects/dotfiles/vscode/keybindings.json"
vscode_keybindings_location="$HOME/.config/Code/User/keybindings.json"
ln -sfn "$vscode_keybindings" "$vscode_keybindings_location"

# zsh
zshrc="$HOME/Projects/dotfiles/zsh/.zshrc"
zshrc_location="$HOME/.zshrc"
ln -sfn "$zshrc" "$zshrc_location"

theme="$HOME/Projects/dotfiles/zsh/nidzo.zsh-theme"
theme_location="$HOME/.oh-my-zsh/themes/nidzo.zsh-theme"
ln -sfn "$theme" "$theme_location"

