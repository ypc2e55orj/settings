"""
""" load dein
"""

" dein variables
let s:dein = $HOME .. '/.local/share/nvim/dein'
let s:dein_root = s:dein .. '/repos/github.com/Shougo/dein.vim'
let s:plugin = $HOME .. '/.config/nvim/plugin.toml'

" if dein.vim is not installed
if !isdirectory(s:dein)
    " install dein.vim
    call system('git clone https://github.com/Shougo/dein.vim ' .. s:dein_root)
endif

" load dein.vim
execute 'set runtimepath+=' .. s:dein_root

if dein#load_state(s:dein)
    call dein#begin(s:dein)

    " load plugin.toml
    call dein#load_toml(s:plugin, {'lazy': 0})

    " remove plugins not in the list
    call map(dein#check_clean(), "delete(v:val, 'rf')")
    call dein#recache_runtimepath()

    if dein#check_install()
        " install
        call dein#install()
        " UpdateRemotePlugins
        call dein#remote_plugins()
    endif

    call dein#end()
    call dein#save_state()
endif
