" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')


Plug 'jiangmiao/auto-pairs'     " Auto pairs for ( [ {

Plug 'joshdick/onedark.vim'     " Themes
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion

Plug 'sheerun/vim-polyglot' " syntax highlighting for various languages

Plug 'scrooloose/nerdtree'
Plug 'mhinz/vim-startify'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'justinmk/vim-sneak'

" Plug 'lervag/vimtex'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif


let g:coc_global_extensions=[
  \ 'coc-omnisharp',
  \ 'coc-json',
  \ 'coc-python',
  \ 'coc-snippets',
  \ 'coc-vimlsp',
  \ 'coc-java',
  \ 'coc-sh',
  \ 'coc-texlab',
  \]


" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Switch to your current theme
let g:airline_theme = 'onedark'

" Always show tabs
set showtabline=2

" We don't need to see things like -- INSERT -- anymore
set noshowmode
