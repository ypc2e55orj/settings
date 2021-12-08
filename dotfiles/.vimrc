"""
""" vim rc
"""
set encoding=utf-8
set title
set hidden
set noshowmode
set number
set showtabline=2
set cursorline
set updatetime=100
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

set list
set listchars=space:･,trail:*,tab:<->

syntax enable

highlight SpecialKey cterm=NONE ctermfg=10
highlight NonText cterm=NONE ctermfg=10
highlight CursorLineNr cterm=NONE ctermbg=0
highlight CursorLine cterm=NONE ctermbg=0

augroup VimrcAutocmd
    autocmd!
    autocmd BufWrite * :silent! :%s/\(\s\|\t\)\+$//g
augroup END

