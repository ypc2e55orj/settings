"""
""" vim rc
"""

set encoding=utf-8
set title
set termguicolors
set hidden
set noshowmode
set number
set cursorline
set showtabline=2
set signcolumn=yes
set updatetime=100
set fillchars="vert:\u2502"
syntax enable
set mouse=a
set clipboard+=unnamedplus
set whichwrap=b,s,h,l,<,>,~,[,]
set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
filetype plugin indent on

nnoremap th gT
nnoremap tl gt
tnoremap <Esc> <C-\><C-n>
nnoremap <Silent> j gj
nnoremap <Silent> k gk
nnoremap <Silent> <Down> gj
nnoremap <Silent> <Up> gk
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>
