" auto-install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'scrooloose/nerdtree'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'nvim-treesitter/nvim-treesitter', {'branch' : '0.5-compat'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch' : '0.5-compat'}
    Plug 'jiangmiao/auto-pairs'     " Auto pairs for ( [ {
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
    Plug 'mhinz/vim-startify'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot' " syntax highlighting for various languages
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
