#! /usrr/bin/env bash

# Lazy stuff
alias di="sudo dnf install"      #
alias dcu="dnf check-update"     #
alias sdu="sudo dnf update"      #
alias clean="sudo dnf clean all" #
alias di="dnf info"              #

alias counthere="ls -lAh | wc -l" #

alias dotfiles="code ~/dev/dotfiles"             #
alias zshconfig="code ~/dev/dotfiles/zsh/.zshrc" #

alias yt="yt-dlp -ic"                      #
alias yta="yt-dlp -xic --audio-format mp3" #
alias de="trans -d :de"                    #
alias en="trans -d :en"                    #
alias sr="trans -d :sr"                    #

alias l='ls -lFh'   # size,show type,human readable
alias la='ls -lAFh' # long list,show almost all,show type,human readable
alias lr='ls -tRFh' # sorted by date,recursive,show type,human readable
alias lt='ls -ltFh' # long list,sorted by date,show type,human readable
alias ll='ls -l'    # long list
alias grep='grep --color'

alias dud='du -d 1 -h'
alias duf='du -sh *'
alias h='history'

alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

# zsh is able to auto-do some kungfoo
# depends on the SUFFIX :)
autoload -Uz is-at-least
if is-at-least 4.2.0; then
    # open browser on urls
    if [[ -n "$BROWSER" ]]; then
        _browser_fts=(htm html de org net com at cx nl se dk)
        for ft in $_browser_fts; do alias -s $ft='$BROWSER'; done
    fi

    _editor_fts=(cpp cxx cc c hh h inl asc txt TXT tex)
    for ft in $_editor_fts; do alias -s $ft='$EDITOR'; done

    if [[ -n "$XIVIEWER" ]]; then
        _image_fts=(jpg jpeg png gif mng tiff tif xpm)
        for ft in $_image_fts; do alias -s $ft='$XIVIEWER'; done
    fi

    _media_fts=(ape avi flv m4a mkv mov mp3 mpeg mpg ogg ogm rm wav webm)
    for ft in $_media_fts; do alias -s $ft=mplayer; done

    #read documents
    alias -s pdf=acroread
    alias -s ps=gv
    alias -s dvi=xdvi
    alias -s chm=xchm
    alias -s djvu=djview

    #list whats inside packed file
    alias -s zip="unzip -l"
    alias -s rar="unrar l"
    alias -s tar="tar tf"
    alias -s tar.gz="echo "
    alias -s ace="unace l"
fi
