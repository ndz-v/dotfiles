#!/usr/bin/env bash

# APT Packages
install_apt_packages(){
    sudo apt update;
    sudo apt upgrade;
    apt_packages="build-essentials nano thunderbird guake curl zsh postgresql postgresql-contrib pgadmin3 tmux shellcheck zsh-syntax-highlighting fonts-powerline"
    
    for package in $apt_packages; do
        printf "Installing APT Package: %s\n ##################################" "$extension"
        sudo apt install "$package";
    done
}

# Oh-My-Zsh
install_oh_my_zsh(){
    echo "Oh-My-Zsh ###############################################"
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sudo -E bash -
    
    sudo chown -R "$USER" .oh-my-zsh;
}

change_shell(){
    echo "Change Shell To Zsh #####################################"
    chsh -s "$(which zsh)"
    sudo chsh -s "$(which zsh)"
}

# Libinput Gestures
install_libinput_gestures(){
    echo "Libinput Gestures #######################################"
    cd ~ || exit;
    sudo gpasswd -a "$USER" input
    sudo apt install xdotool wmctrl libinput-tools
    git clone http://github.com/bulletmark/libinput-gestures
    cd libinput-gestures || exit;
    sudo ./libinput-gestures-setup install
    libinput-gestures-setup start
    libinput-gestures-setup autostart
    cd ~ || exit;
}

# Node.js
install_node(){
    echo "Node.js #################################################"
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
    sudo apt-get install -y nodejs
    . "$HOME/.bashrc";
    
    # npm packages to be in user profile
    # create a directory for global installations
    mkdir ~/.npm-global;
    # configure npm to use the new directory path
    npm config set prefix "$HOME/.npm-global"
    
    # prepend the export to bashrc
    echo "export PATH=~/.npm-global/bin:$PATH" >> ~/.bashrc;
    . "$HOME/.bashrc";
    sudo chown -R "$USER:$(id -gn "$USER")" ~/.config;
    . "$HOME/.bashrc";
}

install_npm_packages(){
    npm_packages='typescript tslint @angular/cli nodemon'
    for package in $npm_packages;
    do
        printf "Installing NPM Package: %s\n ##################################" "$extension"
        npm install -g "$package";
    done
}

# Visual Studio Code
# Installation of code not working
install_vscode(){
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    
    sudo apt update;
    sudo apt install code;
    
    
    url=https://code.visualstudio.com/
    if command -v code > /dev/null; then
        extensions=(
            Angular.ng-template
            DavidAnson.vscode-markdownlint
            EditorConfig.EditorConfig
            PKief.material-icon-theme
            adamvoss.yaml
            alefragnani.Bookmarks
            christian-kohler.npm-intellisense
            christian-kohler.path-intellisense
            chrmarti.regex
            dbaeumer.vscode-eslint
            eamodio.gitlens
            ecmel.vscode-html-css
            eg2.tslint
            eg2.vscode-npm-script
            esbenp.prettier-vscode
            formulahendry.code-runner
            howardzuo.vscode-npm-dependency
            joelday.docthis
            mrmlnc.vscode-scss
            ms-vscode.cpptools
            msjsdiag.debugger-for-chrome
            robertohuertasm.vscode-icons
            shakram02.bash-beautify
            sidneys1.gitconfig
            timonwong.shellcheck
            wayou.vscode-todo-highlight
            yycalm.linecount
            yzane.markdown-pdf
        )
        printf "\nVS Code extensions: \n"
        for extension in ${extensions[*]}
        do
            printf "Installing %s\n" "$extension"
            code --install-extension "$extension"
        done
    else
        printf "\nVisual Studio Code is not installed.\nPlease install VS Code from: %s\n\n" $url
    fi
}

clone_scripts(){
    echo "cloning scripts #########################################"
    cd ~ || exit;
    git clone https://github.com/nidzov/scripts.git
}

# This creates symlinks from ~/ to dotfiles dir
create_sysmbolic_links(){
    echo "creating symbolic links #################################"
    dir=~/dotfiles
    olddir=~/dotfiles_old
    files=".zshrc .nanorc .gitconfig .aliases"
    
    echo "Creating $olddir for backup of any existing dotfiles in ~"
    mkdir -p $olddir
    echo "...complete."
    
    echo "Changing to the $dir directory"
    cd $dir || exit;
    echo "...complete."
    
    for file in $files; do
        echo "Moving existing dotfiles from ~ to $olddir"
        mv "$HOME/$file" "$HOME/dotfiles_old/"
        echo "Creating symlink to $file in home directory."
        ln -s "$dir/$file" "$HOME/$file"
    done
    
    # This create symlinks to .config/Code/User/settings.json
    mv ~/.config/Code/User/settings.json $olddir
    ln -s ~/dotfiles/code/settings.json ~/.config/Code/User/settings.json
    
    # This create symlinks to .config/Code/User/keybindings.json
    mv ~/.config/Code/User/keybindings.json $olddir
    ln -s ~/dotfiles/code/keybindings.json ~/.config/Code/User/keybindings.json
}
