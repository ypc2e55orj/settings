## env
# user local
PATH=~/.local/bin:$PATH
# n (node)
export N_PREFIX=~/.n
PATH=$N_PREFIX/bin:$PATH
# cabal (haskell)
PATH=~/.cabal/bin:$PATH
# ghcup (haskell)
PATH=~/.ghcup/bin:$PATH
# stack (haskell)
(builtin command -v stack > /dev/null) && PATH=$(stack path --compiler-bin):$PATH
# cargo (rust)
PATH=~/.cargo/bin:$PATH
# pipenv (python)
export PYENV_ROOT=$HOME/.pyenv
export PYENV_PYTHON=$PYENV_ROOT/shims/python
# pyenv (python)
export PIPENV_VENV_IN_PROJECT=true
PATH=$PYENV_ROOT/bin:$PATH
(builtin command -v pyenv > /dev/null) && eval $(pyenv init --path)
# go
PATH=~/.local/go/bin:$PATH
export PATH

# WSL only settings
if (uname -r | grep WSL > /dev/null);then
    # DISPLAY
    export DISPLAY=${WSL_HOST_IP:=$(cat /etc/resolv.conf | awk /^nameserver/'{print $2}')}:0.0
    export LIBGL_ALWAYS_INDIRECT=1
    # SCALE (xps13 only)
    if [ $HOST = xps13 ];then
        export GDK_SCALE=2
        export QT_SCALE_FACTOR=2
    fi
    # PULSE_SERVER
    export PULSE_SERVER=tcp:$WSL_HOST_IP
    # SSH_AUTH_SOCK (stream-connector, Windows SSH Agent to WSL socket)
    [ -e /tmp/windows-ssh-agent.sock ] && export SSH_AUTH_SOCK=/tmp/windows-ssh-agent.sock
    # Input method
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMMmodule=fcitx
    (fcitx-autostart > /dev/null 2>&1 &) 
fi

# fpath
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

# zsh history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

export EDITOR=vim
export VISUAL=vim

# SDKMAN (jvm toolchain)
SDKMAN_DIR=~/.sdkman
[ -s $SDKMAN_DIR/bin/sdkman-init.sh ] && source $SDKMAN_DIR/bin/sdkman-init.sh

## zsh compile
[ ! -e $ZDOTDIR/.zshrc.zwc -o $ZDOTDIR/.zshrc.zwc -ot $ZDOTDIR/.zshrc ] && zcompile $ZDOTDIR/.zshrc

## autoload functions
autoload -Uz compinit colors vcs_info add-zsh-hook;
compinit; colors;

## options
setopt prompt_subst auto_menu auto_list auto_cd extended_history hist_ignore_dups hist_save_no_dups hist_reduce_blanks share_history

## load zsh plugins
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## zsh style
# uppercase and lowercase are not distinguished
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#  highlight
zstyle ':completion:*' menu select
# display format
zstyle ':vcs_info:*' formats "[%F{cyan}%c%u%b%f]"
# strange status
zstyle ':vcs_info:*' actionformats "%F{red}%a%f"
# check changes
zstyle ':vcs_info:*' check-for-changes true
# ustagedstr
zstyle ':vcs_info:*' unstagedstr "%F{magenta}"
# stagedstr
zstyle ':vcs_info:*' stagedstr "%F{green}"

## keybind
bindkey -e

## PROMPT
add-zsh-hook precmd vcs_info

_prompt_precmd() {
    local exit_code=$?
    local exit_color
    [ $exit_code -eq 0 ] && exit_color="%F{cyan}" || exit_color="%F{magenta}"

    local new_line
    [ $#PWD -lt $[$(tput cols) / 2] ] && new_line="" || new_line=" "$'\n'" "

    PROMPT=" %~$new_line$vcs_info_msg_0_ $exit_color%#%f "
    RPROMPT=" $(date +"%H:%M:%S") "
}
add-zsh-hook precmd _prompt_precmd

_title_precmd() {
    print -Pn "\e]2; %~ %#\a"
}
add-zsh-hook precmd _title_precmd

## load Solarized LS_COLORS
[ ! -e ~/.dir_colors ] && curl -Ss https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark > ~/.dir_colors
eval $(dircolors ~/.dir_colors)

## alias
_check_gnu() {
    $1 --version | grep -i gnu > /dev/null
}
# ls
if _check_gnu ls;then
    alias ls="ls --human-readable --sort=extension --color=auto"
    alias l="ls"
    alias la="ls -a"
    alias ll="ls -l"
    alias lla="ls -la"
fi
# df
if _check_gnu df;then
    alias df="df --human-readable"
fi
# grep
if _check_gnu grep;then
    alias grep="grep --color=auto"
fi
