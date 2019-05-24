#!/usr/bin/env bash

###############################
## Ask for admin credentials ##
###############################
sudo -v

##############################
## Update and upgrade system ##
##############################
sudo apt update
sudo apt upgrade -y

##################
## Install apps ##
##################
apps=(
    calibre
    curl
    entr
    ffmpeg
    figlet
    git
    latexmk
    libnotify-bin
    lm-sensors
    powertop
    python3-pip
    shellcheck
    silversearcher-ag
    texlive-full
    thunderbird
    tree
    ufw
    zsh
    zsh-syntax-highlighting
)

sudo apt install -y "${apps[@]}"

########################
## Add guake from ppa ##
########################
sudo add-apt-repository ppa:linuxuprising/guake
sudo apt update
sudo apt install guake

# Create autostart file for guake ##
cat /usr/share/guake/data/guake.template.desktop > $HOME/.config/autostart/guake.desktop

# Disable bluetooth
udo systemctl disable bluetooth.service

################################
## Add obs ppa and install it ##
################################
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install obs-studio

#####################################
## Add kdenlive ppa and install it ##
#####################################
sudo add-apt-repository ppa:kdenlive/kdenlive-stable
sudo apt update
sudo apt install kdenlive

# Turn on ufw
if type "ufw" &> /dev/null
then
    sudo ufw enable
fi

####################
## Install pandoc ##
####################

# Create the url
url_part1="https://github.com"
tempvar=$(curl "$url_part1/jgm/pandoc/releases")

# Get the first link with a .deb file ending, it's the latest pandoc linux release
url_part2=$(echo "$tempvar" | sed -n '/amd64.deb/p' | awk '/<a href/{print $2;exit;}' | sed 's/href=//; s/\"//g')

# Download pandoc
wget "$url_part1$url_part2"

# Install pandoc
package=$(ls ./*.deb)
sudo dpkg  -i "$package"
sudo apt install -f

# Delete .deb file
rm "$package"

###########################
## Install Google Chrome ##
###########################

# Create download url variable
chrome_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

# Download Chrome
wget $chrome_url

# Install Chrome
package=$(ls ./*.deb)
sudo dpkg  -i "$package"
sudo apt install -f

# Remove .deb file
rm "$package"

#######################
## Install Oh-My-zsh ##
#######################
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh --quiet --show-progress -O - | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"

#######################################
## Install tlp and libinput-gestures ##
#######################################

# Check if it's a notebook
if [ -d "/sys/class/power_supply" ]
then
    # Check if tlp is installed
    if ! type "tlp" &> /dev/null
    then
        sudo add-apt-repository ppa:linrunner/tlp
        sudo apt update
        sudo apt install -y tlp
        sudo tlp start
    fi
    
    # Install libinput-gestures for swiping gestures
    if ! type "libinput-gestures" &> /dev/null
    then
        sudo gpasswd -a "$USER" input
        sudo apt install -y xdotool wmctrl libinput-tools
        
        cd ~ || return
        git clone https://github.com/bulletmark/libinput-gestures.git
        cd libinput-gestures || return
        sudo make install
        cd .. || return
        rm -rf libinput-gestures
        
        libinput-gestures-setup autostart
        libinput-gestures-setup start
    fi
fi

##############################################
## Install latte-dock and apply KDE options ##
##############################################

# Check if the installed desktop environment is KDE Plasma
if [  "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
    # Install latte dock
    if ! type "latte-dock" &> /dev/null
    then
        sudo apt install -y cmake extra-cmake-modules qtdeclarative5-dev libqt5x11extras5-dev libkf5iconthemes-dev libkf5plasma-dev libkf5windowsystem-dev libkf5declarative-dev libkf5xmlgui-dev libkf5activities-dev build-essential libxcb-util-dev libkf5wayland-dev git gettext libkf5archive-dev libkf5notifications-dev libxcb-util0-dev libsm-dev libkf5crash-dev libkf5newstuff-dev
        
        cd ~ || return
        git clone https://github.com/KDE/latte-dock.git
        cd latte-dock || return
        sh install.sh
        cd .. || return
        rm -rf latte-dock
    fi
    
    # Overwrite kde settings
    cat "$HOME/dev/dotfiles/kde/kcminputrc" > "$HOME/.config/kcminputrc"
    
    if [ -d "/sys/class/power_supply" ]
    then
        # cat "$HOME/dev/dotfiles/kde/kglobalshortcutsrc" > "$HOME/.config/kglobalshortcutsrc"
        cat "$HOME/dev/dotfiles/kde/touchpadrc" > "$HOME/.config/touchpadrc"
    fi
    
fi

#####################
## Install VS Code ##
#####################

# Check if code is installed
if ! type "code" &> /dev/null
then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install -y code
fi

# Install VS Code extensions
if type "code" &> /dev/null
then
    extensions=(
        Angular.ng-template
        CoenraadS.bracket-pair-colorizer
        DavidAnson.vscode-markdownlint
        EditorConfig.EditorConfig
        James-Yu.latex-workshop
        PKief.material-icon-theme
        Tyriar.sort-lines
        VisualStudioExptTeam.vscodeintellicode
        donjayamanne.githistory
        dracula-theme.theme-dracula
        eamodio.gitlens
        ms-python.python
        ms-vscode.cpptools
        ms-vscode.csharp
        ms-vscode.vscode-typescript-tslint-plugin
        ms-vsliveshare.vsliveshare
        msjsdiag.vscode-react-native
        quicktype.quicktype
        ritwickdey.LiveServer
        shakram02.bash-beautify
        shd101wyy.markdown-preview-enhanced
        sidneys1.gitconfig
        streetsidesoftware.code-spell-checker
        streetsidesoftware.code-spell-checker-german
        timonwong.shellcheck
        vmsynkov.colonize
        yycalm.linecount
        zhuangtongfa.Material-theme
    )
    for extension in ${extensions[*]}
    do
        code --install-extension "$extension"
    done
fi

##########################################
## Install youtube-dl, pylint, autopep8 ##
##########################################

# Check if pip3 is installed
if type "python3-pip" &> /dev/null
then
    pip3 install --upgrade youtube-dl pylint autopep8
    
    echo '--output "~/Downloads/%(title)s.%(ext)s"' > "/home/$USER/.config/youtube-dl.conf"
fi


###########################
## Create symbolic links ##
###########################

# git
gitconfig="$HOME/dev/dotfiles/git/.gitconfig"
gitconfig_location="$HOME/.gitconfig"
ln -sfn "$gitconfig" "$gitconfig_location"

# guake
guake="$HOME/dev/dotfiles/guake/user"
guake_location="$HOME/.config/dconf/user"
ln -sfn "$guake" "$guake_location"

# nano
nanorc="$HOME/dev/dotfiles/nano/.nanorc"
nanorc_location="$HOME/.nanorc"
ln -sfn "$nanorc" "$nanorc_location"

# VS Code
vscode_settings="$HOME/dev/dotfiles/vscode/settings.json"
vscode_settings_location="$HOME/.config/Code/User/settings.json"
ln -sfn "$vscode_settings" "$vscode_settings_location"

vscode_keybindings="$HOME/dev/dotfiles/vscode/keybindings.json"
vscode_keybindings_location="$HOME/.config/Code/User/keybindings.json"
ln -sfn "$vscode_keybindings" "$vscode_keybindings_location"

# zsh
zshrc="$HOME/dev/dotfiles/zsh/.zshrc"
zshrc_location="$HOME/.zshrc"
ln -sfn "$zshrc" "$zshrc_location"

theme="$HOME/dev/dotfiles/zsh/nidzo.zsh-theme"
theme_location="$HOME/.oh-my-zsh/themes/nidzo.zsh-theme"
ln -sfn "$theme" "$theme_location"

# Dotfiles dir with git
mkdir "$HOME/dev/temp"
cd "$HOME/dev" || return
git clone git@github.com:nidzov/dotfiles.git "$HOME/dev/temp"
mv "$HOME/dev/temp/.git" "$HOME/dev/dotfiles"
rm -rf "$HOME/dev/temp"
