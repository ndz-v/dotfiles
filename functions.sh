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

# Thunderbird
install_thunderbird(){
    echo ''
    echo '#########################################################'
    echo 'Thunderbird'
    echo '#########################################################'
    sudo apt install -y thunderbird
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
    
    sudo chown -R $USER .oh-my-zsh;
    #Powerline Fonts
    sudo apt-get install fonts-powerline;
}

change_shell(){
    echo ''
    echo '#########################################################'
    echo 'Change Shell To Zsh'
    echo '#########################################################'
    sudo chsh -s /bin/zsh
}

# Libinput Gestures
install_libinput_gestures(){
    echo ''
    echo '#########################################################'
    echo 'Libinput Gestures'
    echo '#########################################################'
    
    cd ~ || exit;
    sudo gpasswd -a $USER input
    sudo apt install xdotool wmctrl libinput-tools
    git clone http://github.com/bulletmark/libinput-gestures
    cd libinput-gestures || exit;
    sudo ./libinput-gestures-setup install
    libinput-gestures-setup start
    libinput-gestures-setup autostart
    cd ~ || exit;
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
    source ~/.bashrc;
    
    # npm packages to be in user profile
    # create a directory for global installations
    mkdir ~/.npm-global;
    # configure npm to use the new directory path
    npm config set prefix '~/.npm-global'
    
    # prepend the export to bashrc
    echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc;
    source ~/.bashrc;
    sudo chown -R '$USER:$(id -gn $USER)' ~/.config;
    source ~/.bashrc;
}

# TypeScript
install_typescript(){
    echo ''
    echo '#########################################################'
    echo 'TypeScript'
    echo '#########################################################'
    npm install -g typescript
}

# TSLint
install_tslint(){
    echo ''
    echo '#########################################################'
    echo 'TSLint'
    echo '#########################################################'
    npm install -g tslint
}

# Angular CLI
install_angular_cli(){
    echo ''
    echo '#########################################################'
    echo 'Angular CLI'
    echo '#########################################################'
    npm install -g @angular/cli
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
install_vscode_extensions(){
    apt-get install shellcheck
    
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
            wayou.vscode-todo-highlight
            yycalm.linecount
            yzane.markdown-pdf
        )
        echo '\nVS Code extensions: \n'
        for extension in ${extensions[*]}
        do
            printf 'Installing %s\n' $extension
            code --install-extension $extension
        done
    else
        printf '\nVisual Studio Code is not installed.\nPlease install VS Code from: %s\n\n' $url
    fi
    
    
}

clone_scripts(){
    echo ''
    echo '#########################################################'
    echo 'cloning scripts'
    echo '#########################################################'
    
    cd ~ || exit;
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
    files='.zshrc .nanorc .gitconfig .aliases'
    
    echo 'Creating $olddir for backup of any existing dotfiles in ~'
    mkdir -p $olddir
    echo '...complete.'
    
    echo 'Changing to the $dir directory'
    cd $dir || exit;
    echo '...complete.'
    
    for file in $files; do
        echo 'Moving existing dotfiles from ~ to $olddir'
        mv ~/$file ~/dotfiles_old/
        echo 'Creating symlink to $file in home directory.'
        ln -s $dir/$file ~/$file
    done
    
    # This create symlinks to .config/Code/User/settings.json
    mv ~/.config/Code/User/settings.json $olddir
    ln -s ~/dotfiles/code/settings.json ~/.config/Code/User/settings.json
    
    # This create symlinks to .config/Code/User/keybindings.json
    mv ~/.config/Code/User/keybindings.json $olddir
    ln -s ~/dotfiles/code/keybindings.json ~/.config/Code/User/keybindings.json
}