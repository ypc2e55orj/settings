augroup DeolConfig
    autocmd!
    autocmd FileType deol call s:deol_config()
augroup END

function! s:deol_config() abort
    setlocal nonumber nocursorcolumn signcolumn=no
endfunction
