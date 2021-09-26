#!/usr/bin/env bash

sudo -v # sk for admin credentials

dotfiles_dir="$HOME/dev/dotfiles"
config_dir="$HOME/.config"

##########################
## Install apt packages ##
##########################

sudo add-apt-repository ppa:kubuntu-ppa/backports # Get newest kde version
sudo add-apt-repository ppa:git-core/ppa          # Get newest git version
sudo add-apt-repository ppa:mozillateam/ppa       # Get newest Firefox and Thunderbird version
sudo add-apt-repository ppa:libreoffice/ppa       # Get newest libreoffice version

sudo apt-get update
sudo apt-get upgrade

apps=(
    bat                     # Alternative to cat
    curl                    # Make sure curl is installed
    entr                    # Rebuild project if sources change
    fd-find                 # Alternative to find
    ffmpeg                  # Needed for youtube-dl to work
    fonts-powerline         # For vim-powerline
    git                     # Versioncontrol
    graphviz                # Create graphs
    grub-customizer         # Customize grub with GUI
    latexmk                 # Completely automates the process of generating a LaTeX document
    latte-dock              # Dock for kde plasma desktop
    lm-sensors              # Read sensors
    neovim                  # Text editor
    python3-pip             # Python package manager
    ripgrep                 # Search tool
    shellcheck              # script analysis tool
    silversearcher-ag       # Code searching tool
    testdisk                # Tool for scanning/repairing disks, undeleting files
    texlive-full            # LaTeX distribution
    translate-shell         # Command-line translator
    tree                    # Show directory in a tree
    ufw                     # Firewall
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
    pip3 install --user youtube-dl pylint autopep8 pandocfilters jupyter pandas eyed3 pynvim

    echo '--output '"$HOME/Downloads/%(title)s.%(ext)s" >"/home/$USER/.config/youtube-dl.conf"
fi

##################
## Install font ##
##################

git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts || return
git sparse-checkout add patched-fonts/Hack
./install.sh Hack
rm -r nerd-fonts
cd "$HOME" || return

#################
## Install fzf ##
#################

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

####################
## Install nodejs ##
####################

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

npm config set prefix "$HOME/.npm-global"

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

#########################
## Install zsh plugins ##
#########################

git clone git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$dotfiles_dir/zsh"
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$dotfiles_dir/zsh"

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
        foxundermoon.shell-format
        ionutvmi.path-autocomplete
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
    for extension in ${extensions[*]}; do
        code --install-extension "$extension"
    done
fi

# KDE Plasma makes VSCode slow, when deleting files in VSCode. This is a fix.
echo "export ELECTRON_TRASH=gio" >"$HOME/.config/plasma-workspace/env/electron-trash-gio.sh"

###########################
## Create symbolic links ##
###########################

# bat
sudo ln -sfn /usr/bin/batcat

# git
ln -sfn "$dotfiles_dir/git/.gitconfig" "$HOME/.gitconfig"

# Konsole
rm -rf "$HOME/.local/share/konsole"
ln -sfn "$dotfiles_dir/kon_and_yak/konsole" "$HOME/.local/share/konsole"

# Yakuake
rm "$config_dir/yakuakerc"
ln -sfn "$dotfiles_dir/kon_and_yak/yakuakerc" "$config_dir/yakuakerc"

# nano
ln -sfn "$dotfiles_dir/nano/.nanorc" "$HOME/.nanorc"

# neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim_config_dir="$config_dir/nvim"
[ -d "$nvim_config_dir" ] || mkdir -p "$nvim_config_dir"

ln -sfn "$dotfiles_dir/nvim/init.vim" "$config_dir/nvim/init.vim"
ln -sfn "$dotfiles_dir/nvim/coc-settings.json" "$config_dir/nvim/coc-settings.json"
ln -sfn "$dotfiles_dir/nvim/plug-config" "$config_dir/nvim/plug-config"

# VS Code
ln -sfn "$dotfiles_dir/vscode/settings.json" "$config_dir/Code/User/settings.json"
ln -sfn "$dotfiles_dir/vscode/keybindings.json" "$config_dir/Code/User/keybindings.json"

# Latte Dock
ln -sfn "$dotfiles_dir/lattedock/lattedockrc" "$config_dir/lattedockrc"
ln -sfn "$dotfiles_dir/lattedock/Default.layout.latte" "$config_dir/latte/Default.layout.latte"

# zsh
ln -sfn "$dotfiles_dir/zsh/.zshrc" "$HOME/.zshrc"
ln -sfn "$dotfiles_dir//zsh/.zshenv" "$HOME/.zshenv"

# Add .git folder to dotfiles
cd "$dotfiles_dir" || return
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
