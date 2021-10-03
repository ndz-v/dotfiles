
"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/


source $HOME/.config/nvim/plug-config/plugins.vim " Plugins
source $HOME/.config/nvim/plug-config/airline.vim " airline

source $HOME/dev/dotfiles/nvim/lua-config/lsp_config.lua
source $HOME/dev/dotfiles/nvim/lua-config/treesitter_config.lua

source $HOME/dev/dotfiles/nvim/lua-config/signature.lua



colorscheme material
syntax enable                           " Enables syntax highlighing
set number                              " Line numbers
set relativenumber                      " Relative line numbers
set autoindent                          " Good auto indent
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set encoding=utf-8                      " The encoding displayed
set pumheight=50                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler                           " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=0                        " Always display the status line
set cursorline                          " Enable highlighting of the current line
set ignorecase                          " ignore case
set smartcase                           " but don't ignore it, when search string contains uppercase letters
set completeopt=menuone,noselect
set showtabline=4                       " Always show tabs
" set nobackup                           " This is recommended by coc
" set nowritebackup                      " This is recommended by coc
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set updatetime=100                      " Faster completion
set timeoutlen=100                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set incsearch
set guifont=Hack\ Nerd\ Font\ Mono\

" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" " You can't stop me
" cmap w!! w !sudo tee %

let g:python3_host_prog = '/usr/bin/python3'
let g:tex_flavor = 'lualatex'

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
map <F2> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <silent> <C-PageDown> :bn<CR> " Next buffer
nnoremap <silent> <C-PageUp> :bp<CR> " Previous buffer
" let g:ranger_map_keys = 0
" map <C-f> :Ranger<CR>

noremap <F3> :Autoformat<CR>
au BufWrite * :Autoformat

let mapleader = ","


nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
