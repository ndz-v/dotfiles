#!/usr/bin/env bash
initiate_update(){
    echo 'Update'
    sudo apt update
}

initiate_upgrade(){
    echo 'Upgrade'
    sudo apt upgrade -y
}

# Build Essentials
install_build_essentials(){
    echo 'Build Essentials'
    sudo apt-get install build-essential
}

install_nano(){
    sudo apt install nano
}

# Gnome Shell Session
install_gnome(){
    echo 'Gnome Shell'
    sudo apt install gnome-session
}

# Guake Terminal
install_guake(){
    echo 'Guake Terminal'
    sudo apt install Guake
}

# Curl
install_curl(){
    echo 'Curl'
    sudo apt install curl
}

# Zsh
install_zsh(){
    echo 'Zsh'
    sudo apt install zsh
}

# Oh-My-Zsh
install_oh_my_zsh(){
    echo 'Oh-My-Zsh'
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sudo -E bash -
}

install_libinput_gestures(){
    ### Libinput Gestures
    echo 'Libinput Gestures'
    cd ~
    sudo gpasswd -a $USER input
    sudo apt install xdotool wmctrl libinput-tools
    git clone http://github.com/bulletmark/libinput-gestures
    cd libinput-gestures
    sudo ./libinput-gestures-setup install
    libinput-gestures-setup start
    libinput-gestures-setup autostart
    cd ~
}

# MongoDB
install_mongodb(){
    echo 'Mongodb'
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
    
    echo 'deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
    
    sudo apt update
    sudo apt-get install -y mongodb-org
    sudo mkdir -p /data/db
    sudo chown -R $USER /data
}

# PostgreSQL
install_postgresql(){
    echo 'PostgreSQL'
    sudo apt-get install postgresql postgresql-contrib pgadmin3
}

# Node.js
install_node(){
    echo 'Node.js'
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    sudo apt-get install -y nodejs
}

# TypeScript
install_typescript(){
    echo 'TypeScript'
    sudo npm install -g typescript
}

# TSLint
install_tslint(){
    echo 'TSLint'
    sudo npm install -g tslint
}

# Angular CLI
install_angular_cli(){
    echo 'Angular CLI'
    sudo npm install -g @angular/cli
}

# Zsh-Syntax-Highlighting
install_zsh_syntax_highlighting(){
    echo 'Zsh-Syntax-Highlighting'
    sudo apt install zsh-syntax-highlighting
}

# Visual Studio Code
# Installation of code not working
install_code(){
    echo 'Visual Studio Code'
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    
    sudo apt-get update
    sudo apt-get install code
    
    code --install-extension Angular.ng-template
    code --install-extension DavidAnson.vscode-markdownlint
    code --install-extension EditorConfig.EditorConfig
    code --install-extension PKief.material-icon-theme
    code --install-extension adamvoss.yaml
    code --install-extension alefragnani.Bookmarks
    code --install-extension christian-kohler.npm-intellisense
    code --install-extension christian-kohler.path-intellisense
    code --install-extension chrmarti.regex
    code --install-extension dbaeumer.vscode-eslint
    code --install-extension eamodio.gitlens
    code --install-extension ecmel.vscode-html-css
    code --install-extension eg2.tslint
    code --install-extension eg2.vscode-npm-script
    code --install-extension formulahendry.code-runner
    code --install-extension howardzuo.vscode-npm-dependency
    code --install-extension joelday.docthis
    code --install-extension jvitor83.types-autoinstaller
    code --install-extension mrmlnc.vscode-scss
    code --install-extension msjsdiag.debugger-for-chrome
    code --install-extension robertohuertasm.vscode-icons
    code --install-extension shakram02.bash-beautify
    code --install-extension sidneys1.gitconfig
    code --install-extension wayou.vscode-todo-highlight
    code --install-extension yycalm.linecount
    code --install-extension yzane.markdown-pdf
}

clone_scripts(){
    cd ~;
    git clone https://github.com/nidzov/scripts.git
}

create_sysmbolic_links(){
    # This creates symlinks from ~/ to dotfiles dir
    
    dir=~/dotfiles
    olddir=~/dotfiles_old
    files=".zshrc .nanorc .gitconfig .aliases"
    
    echo "Creating $olddir for backup of any existing dotfiles in ~"
    mkdir -p $olddir
    echo "...complete."
    
    echo "Changing to the $dir directory"
    cd $dir
    echo "...complete."
    
    for file in $files; do
        echo "Moving existing dotfiles from ~ to $olddir"
        mv ~/$file ~/dotfiles_old/
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/$file
    done
    
    # This create symlinks to .config/Code/User/settings.json
    mv ~/.config/Code/User/settings.json $olddir
    ln -s $dir/.config/code/settings.json ~/.config/Code/User/settings.json
    
    # This create symlinks to .config/Code/User/keybindings.json
    mv ~/.config/Code/User/keybindings.json $olddir
    ln -s $dir/.config/code/keybindings.json ~/.config/Code/User/keybindings.json
}