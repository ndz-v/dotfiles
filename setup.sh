#!/usr/bin/env bash

sudo -v # sk for admin credentials

dotfiles_dir="$HOME/.config/dotfiles"
config_dir="$HOME/.config"

# Create bootable usb
# sudo dd bs=4M if=path/to/input.iso of=/dev/sd<?> conv=fdatasync  status=progress

# update grub configuration
# sudo grub2-mkconfig -o /boot/grub2/grub.cfg
#$(dirname $(realpath $(echo %k | sed -e 's/^file:\/\///')))\\/zotero -url %U
##################
## Speed up dnf ##
##################

sudo sh -c 'echo -e "defaultyes=1\nmax_parallel_downloads=10\nfastestmirror=1" >> /etc/dnf/dnf.conf'

##########################
## Install dnf packages ##
##########################

sudo dnf update

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

apps=(
    ShellCheck          # script analysis tool
    bat                 # Alternative to cat
    curl                # Make sure curl is installed
    entr                # Rebuild project if sources change
    fd-find             # Alternative to find
    g++                 # Needed for neovim treesitter
    git                 # Versioncontrol
    gscan2pdf           # Scanning software
    latte-dock          # Dock for kde plasma desktop
    mold                # faster linker, needed for rust
    neovim              # Text editor
    openssl-devel       # Needed for tarpaulin cargo package
    lld                 # Needed for mold linker
    clang               # Needed for mold linker
    pandoc              # Universal markup converter
    pass                # Password manager
    pass-otp            # One time password generator
    podman              # Run containers
    python3-pip         # Python package manager
    ripgrep             # Search tool
    testdisk            # Tool for scanning/repairing disks, undeleting files
    the_silver_searcher # Code searching tool
    thunderbird         # Mail client
    translate-shell     # Command-line translator
    tree                # Show directory in a tree
    vlc                 # Video and audio player
    yakuake             # Konsole but Quake style
    zbar                # Read QR code from image
    zint                # Generate QR code
    zint-qt             # zint GUI
    zsh                 # Shell
)

sudo dnf install -y "${apps[@]}" || true

# Install NordVPN

sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

##########################################
## Install youtube-dl, pylint, autopep8 ##
##########################################

# Check if pip3 is installed
# if type "pip3" &>/dev/null; then
#     pip3 install --user yt-dlp pylint autopep8 pandocfilters jupyter pandas
# fi

##################
## Install font ##
##################

# git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
# cd nerd-fonts || return
# git sparse-checkout add patched-fonts/Hack
# ./install.sh Hack
# cd "$HOME" || return
# rm -r nerd-fonts

#################
## Install fzf ##
#################

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

####################
## Install nodejs ##
####################

sudo dnf install nodejs

# npm config set prefix "$HOME/.npm-global"

# npm i -g bash-language-server pyright vim-language-server tree-sitter-cli noevim tree-sitter-cli

#########################
## Install zsh plugins ##
#########################

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$dotfiles_dir/zsh/custom/zsh-syntax-highlighting"
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$dotfiles_dir/zsh/custom/zsh-autocomplete"

###############################
## Install libinput-gestures ##
###############################

# Check if it's a notebook
if [ -d "/sys/class/power_supply" ]; then

    # Install libinput-gestures for swiping gestures
    if ! type "libinput-gestures" &>/dev/null; then
        sudo gpasswd -a "$USER" input
        sudo dnf install -y xdotool wmctrl

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
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update
    sudo dnf install code
fi

# Install VS Code extensions
if type "code" &>/dev/null; then
    extensions=(
        albert.TabOut
        christian-kohler.path-intellisense
        eamodio.gitlens
        foxundermoon.shell-format
        James-Yu.latex-workshop
        kde.breeze
        mads-hartmann.bash-ide-vscode
        ms-azuretools.vscode-docker
        ms-python.black-formatter
        ms-python.isort
        ms-python.pylint
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode-remote.remote-wsl
        ms-vscode-remote.vscode-remote-extensionpack
        ms-vscode.remote-explorer
        PKief.material-icon-theme
        redhat.ansible
        redhat.vscode-yaml
        samuelcolvin.jinjahtml
        Tyriar.sort-lines
        vmsynkov.colonize
        yzhang.markdown-all-in-one
    )
    for extension in "${extensions[@]}"; do
        code --install-extension "$extension"
    done
fi


###########################
## Create symbolic links ##
###########################

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
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# nvim_config_dir="$config_dir/nvim"
# [ -d "$nvim_config_dir" ] || mkdir -p "$nvim_config_dir"

# ln -sfn "$dotfiles_dir/nvim/init.vim" "$config_dir/nvim/init.vim"
# ln -sfn "$dotfiles_dir/nvim/coc-settings.json" "$config_dir/nvim/coc-settings.json"
# ln -sfn "$dotfiles_dir/nvim/plug-config" "$config_dir/nvim/plug-config"

# ln -s /lib64/libstdc++.so.6 /lib64/libstdc++.so # Needed for Treesitter to compile

# VS Code
ln -sfn "$dotfiles_dir/vscode/settings.json" "$config_dir/Code/User/settings.json"
ln -sfn "$dotfiles_dir/vscode/keybindings.json" "$config_dir/Code/User/keybindings.json"

# Latte Dock
ln -sfn "$dotfiles_dir/lattedock/lattedockrc" "$config_dir/lattedockrc"
ln -sfn "$dotfiles_dir/lattedock/Default.layout.latte" "$config_dir/latte/Default.layout.latte"

# zsh
ln -sfn "$dotfiles_dir/zsh/.zshrc" "$HOME/.zshrc"

# cargo toml file
ln -sfn "$dotfiles_dir/cargo/config.toml" "$HOME/.cargo/config.toml"
#
# # Add .git folder to dotfiles
# cd "$dotfiles_dir" || return
# git clone -b fedora --bare https://github.com/ndz-v/dotfiles.git .git
#
# # Change remote url of dotfiles
# git remote set-url origin git@github.com:ndz-v/dotfiles.git

##################################
## Install auto sync to usb hdd ##
##################################

# sudo sh -c 'echo "username  ALL=(ALL) NOPASSWD: $HOME/dev/dotfiles/auto_scripts/rsyunc_to_usb.sh" >> /etc/sudoers'
# sudo ln -sfn /home/nidzo/dev/dotfiles/auto_scripts/rsync_up.rules /etc/udev/rules.d/rsync_up.rules
# sudo udevadm control --reload-rules && udevadm trigger

######################
## Disable Services ##
######################

sudo systemctl disable NetworkManager-wait-online.service # Not needed service, decreases boot time
sudo systemctl mask NetworkManager-wait-online.service    # Not needed service, decreases boot time
