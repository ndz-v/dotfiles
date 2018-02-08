#!/usr/bin/env bash
initiate_update(){
    echo ''
    echo '#########################################################'
    echo 'Update'
    echo '#########################################################'
    sudo apt update
}

initiate_upgrade(){
    echo ''
    echo '#########################################################'
    echo 'Upgrade'
    echo '#########################################################'
    sudo apt upgrade -y
}

# Build Essentials
install_build_essentials(){
    echo ''
    echo '#########################################################'
    echo 'Build Essentials'
    echo '#########################################################'
    sudo apt-get install -y build-essential
}

install_nano(){
    echo ''
    echo '#########################################################'
    echo 'nano'
    echo '#########################################################'
    sudo apt install -y nano
}

# Gnome Shell Session
install_gnome(){
    echo ''
    echo '#########################################################'
    echo 'Gnome Shell'
    echo '#########################################################'
    sudo apt install -y gnome-session
}

# Guake Terminal
install_guake(){
    echo ''
    echo '#########################################################'
    echo 'Guake Terminal'
    echo '#########################################################'
    sudo apt install -y guake
}

# Curl
install_curl(){
    echo ''
    echo '#########################################################'
    echo 'Curl'
    echo '#########################################################'
    sudo apt install -y curl
}

# Zsh
install_zsh(){
    echo ''
    echo '#########################################################'
    echo 'Zsh'
    echo '#########################################################'
    sudo apt install -y zsh
}

# Oh-My-Zsh
install_oh_my_zsh(){
    echo ''
    echo '#########################################################'
    echo 'Oh-My-Zsh'
    echo '#########################################################'
    curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sudo -E bash -
}

# Libinput Gestures
install_libinput_gestures(){
    echo ''
    echo '#########################################################'
    echo 'Libinput Gestures'
    echo '#########################################################'
    
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

# PostgreSQL
install_postgresql(){
    echo ''
    echo '#########################################################'
    echo 'PostgreSQL'
    echo '#########################################################'
    sudo apt-get install postgresql postgresql-contrib pgadmin3
}

# Node.js
install_node(){
    echo ''
    echo '#########################################################'
    echo 'Node.js'
    echo '#########################################################'
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
    sudo apt-get install -y nodejs
}

# TypeScript
install_typescript(){
    echo ''
    echo '#########################################################'
    echo 'TypeScript'
    echo '#########################################################'
    sudo npm install -g typescript
}

# TSLint
install_tslint(){
    echo ''
    echo '#########################################################'
    echo 'TSLint'
    echo '#########################################################'
    sudo npm install -g tslint
}

# Angular CLI
install_angular_cli(){
    echo ''
    echo '#########################################################'
    echo 'Angular CLI'
    echo '#########################################################'
    sudo npm install -g @angular/cli
}

# Tmux
install_tmux(){
    echo ''
    echo '#########################################################'
    echo 'Tmux'
    echo '#########################################################'
    sudo apt install -y tmux
}

# Zsh-Syntax-Highlighting
install_zsh_syntax_highlighting(){
    echo ''
    echo '#########################################################'
    echo 'Zsh-Syntax-Highlighting'
    echo '#########################################################'
    sudo apt install -y zsh-syntax-highlighting
}

# Visual Studio Code
# Installation of code not working
install_code(){
    # echo ''
    # echo '#########################################################'
    # echo 'Visual Studio Code'
    # echo '#########################################################'
    # curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    # sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    # sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    
    # sudo apt-get update
    # sudo apt-get install -y code
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
    code --install-extension esbenp.prettier-vscode
    code --install-extension formulahendry.code-runner
    code --install-extension howardzuo.vscode-npm-dependency
    code --install-extension joelday.docthis
    code --install-extension mrmlnc.vscode-scss
    code --install-extension ms-vscode.cpptools
    code --install-extension msjsdiag.debugger-for-chrome
    code --install-extension robertohuertasm.vscode-icons
    code --install-extension shakram02.bash-beautify
    code --install-extension sidneys1.gitconfig
    code --install-extension wayou.vscode-todo-highlight
    code --install-extension yycalm.linecount
    code --install-extension yzane.markdown-pdf
    
}

clone_scripts(){
    echo ''
    echo '#########################################################'
    echo 'cloning scripts'
    echo '#########################################################'
    
    cd ~;
    git clone https://github.com/nidzov/scripts.git
}

# This creates symlinks from ~/ to dotfiles dir
create_sysmbolic_links(){
    echo ''
    echo '#########################################################'
    echo 'creating symbolic links'
    echo '#########################################################'
    
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
    ln -s ~/dotfiles/code/settings.json ~/.config/Code/User/settings.json
    
    # This create symlinks to .config/Code/User/keybindings.json
    mv ~/.config/Code/User/keybindings.json $olddir
    ln -s ~/dotfiles/code/keybindings.json ~/.config/Code/User/keybindings.json
}