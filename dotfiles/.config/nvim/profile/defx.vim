augroup DefxConfig
    autocmd!
    autocmd FileType defx call s:defx_config()
augroup END

function! s:defx_config() abort
    setlocal nonumber nocursorcolumn signcolumn=no

    " oepn file in new tab
    nnoremap <silent><buffer><expr> <CR>
                \ defx#do_action('open', 'tabnew')
    nnoremap <silent><buffer><expr> l
                \ defx#do_action('open', 'tabnew')

    " back previous directory
    nnoremap <silent><buffer><expr> <BS>
                \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> h
                \ defx#do_action('cd', ['..'])

    " oepn or close tree
    nnoremap <silent><buffer><expr> o
                \ defx#do_action('open_or_close_tree')

    " up
    nnoremap <silent><buffer><expr> k
                \ line('.') == 1 ? 'G' : 'k'

    " down
    nnoremap <silent><buffer><expr> j
                \ line('.') == line('$')
                \ ? 'gg' : 'j'

    " make file
    nnoremap <silent><buffer><expr> mf
                \ defx#do_action('new_file')

    " make directory
    nnoremap <silent><buffer><expr> md
                \ defx#do_action('new_directory')

    " delete
    nnoremap <silent><buffer><expr> rm
                \ defx#do_action('remove')

    " rename
    nnoremap <silent><buffer><expr> mv
                \ defx#do_action('rename')

    " toggle ignore files
    nnoremap <silent><buffer><expr> .
                \ defx#do_action('toggle_ignored_files')

    " yank path
    nnoremap <silent><buffer><expr> y
                \ defx#do_action('yank_path')

    " mouse
    nnoremap <silent><buffer><expr> <2-LeftMouse>
                \ line('.') == 1 ?
                \ defx#do_action('cd', ['..']) :
                \ defx#do_action('open', 'tabnew')

    nnoremap <silent><buffer><expr> <RightMouse>
                \ defx#do_action('open_or_close_tree')
endfunction

call defx#custom#option('_', {
            \ 'auto_cd': v:true,
            \ 'root_marker': '> ',
            \ 'show_ignored_files': v:true,
            \ 'columns': 'indent:icons:filename:type',
            \ })

call defx#custom#column('indent', {
            \ 'indent': ' ',
            \ })

command! -nargs=* -range -bar -complete=customlist,defx#util#complete
            \ D
            \ call s:defx_adjust_winwidth(<q-args>)

function! s:defx_adjust_winwidth(args)
    call defx#custom#column('filename', {
                \ 'min_width': winwidth(0),
                \ 'max_width': winwidth(0),
                \ })
    call defx#util#call_defx('Defx', a:args)
endfunction
