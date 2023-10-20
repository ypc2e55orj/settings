let g:lightline = {}
let g:lightline.tab = {}
let g:lightline.tabline = {}

" colorscheme
let g:lightline.colorscheme = 'solarized'

" statusline
let g:lightline.subseparator = {
            \ 'left': "\u2502",
            \ 'right': "\u2502"
            \ }

let g:lightline.active = {
            \ 'left': [
            \ ['mode', 'paste'],
            \ ['fugitive', 'filename', 'readonly', 'modified']
            \ ],
            \ 'right': [
            \ ['lineinfo'],
            \ ['percent'],
            \ ['ale_checking', 'ale_ok', 'filetype', 'fileformat', 'fileencoding', 'ale_warnings', 'ale_errors']
            \ ]
            \ }

let g:lightline.component_function =  {
            \ 'fugitive': 'LightlineFugitive',
            \ 'filename': 'LightlineFilename',
            \ 'ale_checking': 'lightline#ale#checking',
            \ 'ale_ok': 'lightline#ale#ok',
            \ 'filetype': 'LightlineFiletype',
            \ 'fileformat': 'LightlineFileformat',
            \ }

let g:lightline.component_expand = {
            \ 'ale_warnings': 'lightline#ale#warnings',
            \ 'ale_errors': 'lightline#ale#errors'
            \ }

let g:lightline.component_type = {
            \ 'ale_warnings': 'warning',
            \ 'ale_errors': 'error'
            \ }

function! LightlineFugitive()
    let l:git_branch = fugitive#head()

    return strlen(l:git_branch) ? "\ue0a0" .. ' ' .. l:git_branch : ''
endfunction

function! LightlineFilename()
    return winwidth(0) > 150 ? substitute(expand('%:p'), expand('$HOME'), '~', '&') : expand('%:t')
endfunction

function! LightlineFileformat()
    return  WebDevIconsGetFileFormatSymbol() .. ' ' .. &fileformat
endfunction

function! LightlineFiletype()
    return strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() .. ' ' .. &filetype : 'no ft'
endfunction

" tabline
let g:lightline.tabline_separator = {
            \ 'left': ' '
            \ }

let g:lightline.tabline_subseparator = g:lightline.subseparator

let g:lightline.tab.active =  ['tabnum', 'tabdevicon', 'filename', 'modified']

let g:lightline.tab.inactive = g:lightline.tab.active

let g:lightline.tabline.right = [['']]

let g:lightline.tab_component_function = {
            \ 'tabdevicon': 'LightlineTabDevIcon'
            \ }

function! LightlineTabDevIcon(count)
    return WebDevIconsGetFileTypeSymbol(lightline#tab#filename(a:count))
endfunction

" lightline-ale
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071" .. " "
let g:lightline#ale#indicator_errors = "\uf05e" .. " "
let g:lightline#ale#indicator_ok = "\uf00c"
