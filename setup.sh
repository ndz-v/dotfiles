#!/usr/bin/env bash

sudo -v # sk for admin credentials

sudo apt-get update
sudo apt-get upgrade

##########################
## Install apt packages ##
##########################

apt-add-repository ppa:git-core/ppa
sudo apt-get update

APPS=(
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

sudo apt-get install -y "${APPS[@]}" || true

##########################################
## Install youtube-dl, pylint, autopep8 ##
##########################################

# Check if pip3 is installed
if type "pip3" &>/dev/null; then
    pip3 install --user youtube-dl pylint autopep8 pandocfilters jupyter pandas eyed3

    echo '--output '"$HOME/Downloads/%(title)s.%(ext)s" >"/home/$USER/.config/youtube-dl.conf"
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
URL_PART1="https://github.com"
TEMPVAR=$(curl "$URL_PART1/jgm/pandoc/releases")

# Get the first link with a .deb file ending, it's the latest pandoc linux release
URL_PART2=$(echo "$TEMPVAR" | sed -n '/amd64.deb/p' | awk '/<a href/{print $2;exit;}' | sed 's/href=//; s/\"//g')

# Download pandoc
wget "$URL_PART1$URL_PART2"

# Install pandoc
PACKAGE=$(ls ./*.deb)
sudo dpkg -i "$PACKAGE"
sudo apt-get install -f

# Delete .deb file
rm "$PACKAGE"

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
    EXTENSIONS=(
        albert.TabOut
        eamodio.gitlens
        foxundermoon.shell-format
        James-Yu.latex-workshop
        mads-hartmann.bash-ide-vscode
        ms-azuretools.vscode-docker
        ms-dotnettools.csharp
        ms-dotnettools.dotnet-interactive-vscode
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-vscode.cpptools
        PKief.material-icon-theme
        rangav.vscode-thunder-client
        streetsidesoftware.code-spell-checker
        streetsidesoftware.code-spell-checker-german
        sumneko.lua
        timonwong.shellcheck
        Tyriar.sort-lines
        valentjn.vscode-ltex
        VisualStudioExptTeam.vscodeintellicode
        vmsynkov.colonize
        yzhang.markdown-all-in-one
        zhuangtongfa.material-theme
    )
    for EXTENSION in ${EXTENSIONS[*]}; do
        code --install-extension "$EXTENSION"
    done
fi

# KDE Plasma makes VSCode slow, when deleting files in VSCode. This is a fix.
echo "export ELECTRON_TRASH=gio" >"$HOME/.config/plasma-workspace/env/electron-trash-gio.sh"

###########################
## Create symbolic links ##
###########################

DOTFILES_DIR="$HOME/dev/dotfiles"
CONFIG_DIR="$HOME/.config"

# git
ln -sfn "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Konsole
rm -rf "$HOME/.local/share/konsole"
ln -sfn "$DOTFILES_DIR/kon_and_yak/konsole" "$HOME/.local/share/konsole"

# Yakuake
rm "$CONFIG_DIR/yakuakerc"
ln -sfn "$DOTFILES_DIR/kon_and_yak/yakuakerc" "$CONFIG_DIR/yakuakerc"

# nano
ln -sfn "$DOTFILES_DIR/nano/.nanorc" "$HOME/.nanorc"

# neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"
[ -d "$NVIM_CONFIG_DIR" ] || mkdir -p "$NVIM_CONFIG_DIR"

ln -sfn "$DOTFILES_DIR/nvim/init.vim" "$CONFIG_DIR/nvim/init.vim"
ln -sfn "$DOTFILES_DIR/nvim/coc-settings.json" "$CONFIG_DIR/nvim/coc-settings.json"
ln -sfn "$DOTFILES_DIR/nvim/plug-config" "$CONFIG_DIR/nvim/plug-config"

# VS Code
ln -sfn "$DOTFILES_DIR/vscode/settings.json" "$CONFIG_DIR/Code/User/settings.json"
ln -sfn "$DOTFILES_DIR/vscode/keybindings.json" "$CONFIG_DIR/Code/User/keybindings.json"

# Latte Dock
ln -sfn "$DOTFILES_DIR/lattedock/lattedockrc" "$CONFIG_DIR/lattedockrc"
ln -sfn "$DOTFILES_DIR/lattedock/Default.layout.latte" "$CONFIG_DIR/latte/Default.layout.latte"

# zsh
ln -sfn "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Add .git folder to dotfiles
cd "$DOTFILES_DIR" || return
git clone --bare https://github.com/ndz-v/dotfiles.git .git

# Change remote url of dotfiles
git remote set-url origin git@github.com:ndz-v/dotfiles.git

######################
## Disable Services ##
######################

sudo systemctl disable NetworkManager-wait-online.service # Not needed service, decreases boot time
sudo systemctl mask NetworkManager-wait-online.service    # Not needed service, decreases boot time
sudo systemctl disable bluetooth.service
sudo systemctl disable postgresql.service

##################
## Remove snapd ##
##################

sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
sudo apt-get remove --purge snapd
