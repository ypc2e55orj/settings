let g:ale_completion_enabled = 0

let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_insert_leave = 1

let g:ale_sign_error = "\uf05e"
let g:ale_sign_warning = "\uf071"

let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'

let g:ale_echo_msg_format = '[%linter%]: [%severity%] %s'

let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'javascript': ['prettier', 'eslint'],
            \ 'typescript': ['prettier', 'tslint'],
            \ 'yaml': ['prettier'],
            \ 'json': ['prettier'],
            \ 'markdown': ['prettier'],
            \ 'html': ['prettier'],
            \ 'css': ['prettier'],
            \ 'rust': ['rustfmt'],
            \ 'c': ['clang-format'],
            \ 'haskell': ['stylish-haskell', 'hlint']
            \ }

let g:ale_fix_on_save = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
