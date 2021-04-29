#!/usr/bin/env bash

###############################
## Ask for admin credentials ##
###############################

sudo -v

##########################
## Install apt packages ##
##########################

apps=(
    curl                    # Make sure curl is installed
    entr                    # Rebuild project if sources change
    exfat-fuse              # exFat
    exfat-utils             # exFat
    ffmpeg                  # Needed for youtube-dl to work
    fzf                     # General-purpose command-line fuzzy finder
    git                     # Versioncontrol
    graphviz                # Create graphs
    grub-customizer         # Customize grub with GUI
    kid3                    # Tagging mp3 files
    latexmk                 # Completely automates the process of generating a LaTeX document
    latte-dock              # Dock for kde plasma desktop
    libnotify-bin           # Desktop notifications
    lm-sensors              # Read sensors
    neovim                  # Text editor
    postgresql              # Database
    python3-pip             # Python package manager
    ripgrep                 # Search tool
    shellcheck              # script analysis tool
    silversearcher-ag       # Code searching tool
    testdisk                # Tool for scanning/repairing disks, undeleting files
    texlive-full            # LaTeX distribution
    translate-shell         # Command-line translator
    ufw                     # Firewall
    xsel                    # Clipboard support in cli
    yakuake                 # Konsole but Quake style
    zsh                     # Shell
    zsh-syntax-highlighting # Syntax highlighting for zsh
)

sudo apt-get install -y "${apps[@]}" || true

##########################################
## Install youtube-dl, pylint, autopep8 ##
##########################################

# Check if pip3 is installed
if type "pip3" &>/dev/null; then
    pip3 install youtube-dl pylint autopep8 pandocfilters jupyter pandas eyed3

    echo '--output "$HOME/Downloads/%(title)s.%(ext)s"' >"/home/$USER/.config/youtube-dl.conf"
fi

####################
## Install nodejs ##
####################

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

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
sudo dpkg -i "$package"
sudo apt-get install -f

# Delete .deb file
rm "$package"

#######################
## Install Oh-My-zsh ##
#######################
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" # install zsh-autosuggestions plugin
###############################
## Install libinput-gestures ##
###############################

# Check if it's a notebook
if [ -d "/sys/class/power_supply" ]; then

    sudo apt-get install -y tlp powertop

    # Install libinput-gestures for swiping gestures
    if ! type "libinput-gestures" &>/dev/null; then
        sudo gpasswd -a "$USER" input
        sudo apt-get install -y xdotool wmctrl libinput-tools

        cd "$HOME" || return
        git clone https://github.com/bulletmark/libinput-gestures.git
        cd libinput-gestures || return
        sudo make install
        cd .. || return
        rm -rf libinput-gestures

        libinput-gestures-setup autostart
        libinput-gestures-setup start
    fi
fi

#####################
## Install VS Code ##
#####################

# Check if code is installed
if ! type "code" &>/dev/null; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

    sudo apt-get install -y apt-transport-https
    sudo apt-get update
    sudo apt-get install -y code
fi

# Install VS Code extensions
if type "code" &>/dev/null; then
    extensions=(
        albert.TabOut
        eamodio.gitlens
        EFanZh.graphviz-preview
        foxundermoon.shell-format
        geeklearningio.graphviz-markdown-preview
        humao.rest-client
        James-Yu.latex-workshop
        jmrog.vscode-nuget-package-manager
        joaompinto.vscode-graphviz
        mads-hartmann.bash-ide-vscode
        ms-dotnettools.csharp
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode.cpptools
        PKief.material-icon-theme
        sumneko.lua
        timonwong.shellcheck
        Tyriar.sort-lines
        valentjn.vscode-ltex
        VisualStudioExptTeam.vscodeintellicode
        vmsynkov.colonize
        yycalm.linecount
        zhuangtongfa.material-theme
    )
    for extension in ${extensions[*]}; do
        code --install-extension "$extension"
    done
fi

# KDE Plasma makes VSCode slow, when deleting files in VSCode. This is a fix.
echo "export ELECTRON_TRASH=gio" >"$HOME/.config/plasma-workspace/env/electron-trash-gio.sh"

###########################
## Create symbolic links ##
###########################

# git
gitconfig="$HOME/dev/dotfiles/git/.gitconfig"
gitconfig_location="$HOME/.gitconfig"
ln -sfn "$gitconfig" "$gitconfig_location"

# Konsole
konsole="$HOME/dev/dotfiles/kon_and_yak/konsole"
konsole_location="$HOME/.local/share/konsole"
rm -rf "$konsole_location"
ln -sfn "$konsole" "$konsole_location"

# Yakuake
yakuake="$HOME/dev/dotfiles/kon_and_yak/yakuakerc"
yakuake_location="$HOME/.config/yakuakerc"
rm "$yakuake_location"
ln -sfn "$yakuake" "$yakuake_location"

# nano
nanorc="$HOME/dev/dotfiles/nano/.nanorc"
nanorc_location="$HOME/.nanorc"
ln -sfn "$nanorc" "$nanorc_location"

# neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim_config_dir="$HOME/.config/nvim"
[ -d "$nvim_config_dir" ] || mkdir -p "$nvim_config_dir"

neovim_init="$HOME/dev/dotfiles/nvim/init.vim"
coc_settings="$HOME/dev/dotfiles/nvim/coc-settings.json"
plug_config="$HOME/dev/dotfiles/nvim/plug-config"

neovim_init_location="$HOME/.config/nvim/init.vim"
coc_settings_location="$HOME/.config/nvim/coc-settings.json"
plug_config_location="$HOME/.config/nvim/plug-config"

ln -sfn "$neovim_init" "$neovim_init_location"
ln -sfn "$coc_settings" "$coc_settings_location"
ln -sfn "$plug_config" "$plug_config_location"

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

# Add .git folder to dotfiles
cd "$HOME/dev/dotfiles" || return
git clone --bare https://github.com/ndz-v/dotfiles.git .git

# Change remote url of dotfiles
git remote set-url origin git@github.com:ndz-v/dotfiles.git

#######################
## Disable Services ##
#######################
sudo systemctl disable NetworkManager-wait-online.service # Not needed service, decreases boot time
sudo systemctl mask NetworkManager-wait-online.service    # Not needed service, decreases boot time
sudo systemctl disable bluetooth.service
sudo systemctl disable postgresql.service

#######################
## Remove snapd ##
#######################
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
sudo apt-get remove --purge snapd
