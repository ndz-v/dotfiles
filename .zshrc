#!/usr/bin/env bash
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/$USER/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
###-begin-ng-completion###
#

# ng command completion script
#   This command supports 3 cases.
#   1. (Default case) It prints a common completion initialisation for both Bash and Zsh.
#      It is the result of either calling "ng completion" or "ng completion -a".
#   2. Produce Bash-only completion: "ng completion -b" or "ng completion --bash".
#   3. Produce Zsh-only completion: "ng completion -z" or "ng completion --zsh".
#
# Usage: . <(ng completion --bash) # place it appropriately in .bashrc or
#        . <(ng completion --zsh) # find a spot for it in .zshrc
#
_ng_completion () {
    local words cword opts
    read -Ac words
    read -cn cword
    let cword-=1
    
    case $words[cword] in
        ng|help) opts="--version -v b build completion doc e e2e eject g generate get help l lint n new s serve server set t test v version xi18n" ;;
        b|build) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --environment --extract-css --extract-licenses --i18n-file --i18n-format --locale --missing-translation --named-chunks --output-hashing --output-path --poll --preserve-symlinks --progress --show-circular-dependencies --sourcemaps --stats-json --target --vendor-chunk --verbose --watch -a -aot -bh -buildOptimizer -cc -d -dop -e -ec -extractLicenses -i18nFile -i18nFormat -locale -missingTranslation -nc -oh -op -poll -pr -preserveSymlinks -scd -sm -statsJson -t -v -vc -w" ;;
        completion) opts="--all --bash --zsh -a -b -z" ;;
        doc) opts="--search -s" ;;
        e|e2e) opts="--aot --app --base-href --build-optimizer --common-chunk --config --delete-output-path --deploy-url --disable-host-check --element-explorer --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --missing-translation --named-chunks --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --serve --serve-path --show-circular-dependencies --sourcemaps --specs --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch --webdriver-update -H -a -aot -bh -buildOptimizer -c -cc -d -disableHostCheck -dop -e -ec -ee -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -missingTranslation -nc -o -oh -op -p -pc -poll -pr -preserveSymlinks -s -scd -servePath -sm -sp -ssl -sslCert -sslKey -t -v -vc -w -wu" ;;
        eject) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --environment --extract-css --extract-licenses --force --i18n-file --i18n-format --locale --missing-translation --named-chunks --output-hashing --output-path --poll --preserve-symlinks --progress --show-circular-dependencies --sourcemaps --target --vendor-chunk --verbose --watch -a -aot -bh -buildOptimizer -cc -d -dop -e -ec -extractLicenses -force -i18nFile -i18nFormat -locale -missingTranslation -nc -oh -op -poll -pr -preserveSymlinks -scd -sm -t -v -vc -w" ;;
        g|generate) opts="service component directive pipe class guard interface enum module --app --collection --dry-run --force --lint-fix -a -c -d -f -lf" ;;
        get) opts="--global -global" ;;
        help) opts="--short -s" ;;
        l|lint) opts="--fix --force --format --type-check -fix -force -t -typeCheck" ;;
        n|new) opts="--collection --dry-run --link-cli --skip-commit --skip-git --skip-install --verbose -c -d -lc -sc -sg -si -v" ;;
        s|serve|server) opts="--aot --app --base-href --build-optimizer --common-chunk --delete-output-path --deploy-url --disable-host-check --environment --extract-css --extract-licenses --hmr --host --i18n-file --i18n-format --live-reload --locale --missing-translation --named-chunks --open --output-hashing --output-path --poll --port --preserve-symlinks --progress --proxy-config --public-host --serve-path --show-circular-dependencies --sourcemaps --ssl --ssl-cert --ssl-key --target --vendor-chunk --verbose --watch -H -a -aot -bh -buildOptimizer -cc -d -disableHostCheck -dop -e -ec -extractLicenses -hmr -i18nFile -i18nFormat -live-reload-client -locale -lr -missingTranslation -nc -o -oh -op -p -pc -poll -pr -preserveSymlinks -scd -servePath -sm -ssl -sslCert -sslKey -t -v -vc -w" ;;
        set) opts="--global -g" ;;
        t|test) opts="--app --browsers --code-coverage --colors --config --environment --log-level --poll --port --progress --reporters --single-run --sourcemaps --watch -a -browsers -c -cc -colors -e -logLevel -poll -port -progress -reporters -sm -sr -w" ;;
        --version|-v|v|version) opts="--verbose -verbose" ;;
        xi18n) opts="--app --i18n-format --locale --out-file --output-path --progress --verbose -a -f -l -of -op -progress -verbose" ;;
        *) opts="" ;;
    esac
    
    setopt shwordsplit
    reply=($opts)
    unset shwordsplit
}

compctl -K _ng_completion ng
###-end-ng-completion###

export PATH=/home/$USER/scripts:$PATH
export PATH=~/.npm-global/bin:$PATH
source ~/.aliases


##########################
# zsh-syntax-highlitning # must always be the last line
##########################

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
