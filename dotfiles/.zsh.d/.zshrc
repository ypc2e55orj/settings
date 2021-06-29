## env
# if macOS
if (uname -a | grep Darwin > /dev/null);then
   PATH=/opt/macports/bin:$PATH
   PATH=/opt/macports/libexec/gnubin:$PATH
fi
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
if (builtin command -v stack > /dev/null);then
    PATH=$(stack path --compiler-bin):$PATH
fi
# cargo (rust)
PATH=~/.cargo/bin:$PATH
# pyenv (python)
export PYENV_ROOT=$HOME/.pyenv
PATH=$PYENV_ROOT/bin:$PATH
if (builtin command -v pyenv > /dev/null);then
    eval $(pyenv init --path)
fi
# pipenv (python)
export PYENV_PYTHON=$PYENV_ROOT/shims/python

export PATH

# SDKMAN (jvm toolchain)
SDKMAN_DIR=~/.sdkman
if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ];then
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi
# DISPLAY, SSH_AUTH_SOCK (WSL)
if (uname -r | grep WSL > /dev/null);then
    # SSH_AUTH_SOCK (ssh-agent, wsl)
    if [ -e /tmp/windows-ssh-agent.sock ];then
        export SSH_AUTH_SOCK=/tmp/windows-ssh-agent.sock
    fi
    # Input Method
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMMmodule=fcitx
    (fcitx-autostart > /dev/null 2>&1 &) 
fi

## zsh compile
if [ ! -e "$ZDOTDIR/.zshrc.zwc" -o "$ZDOTDIR/.zshrc.zwc" -ot "$ZDOTDIR/.zshrc" ];then
    zcompile $ZDOTDIR/.zshrc
fi

## fpath
fpath=($ZDOTDIR/plugins/zsh-completions/src $fpath)

## zsh history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

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
    # exit code
    local exit_code=$?
    # exit color
    if [ ! $exit_code -eq 0 ];then
        local exit_color="%F{magenta}"
    else
        local exit_color="%F{cyan}"
    fi

    # current directory
    local _pwd=$(pwd)
    # terminal half width
    local half_width=$(( $(tput cols) / 2 ))

    # current directory character counts > terminal half width
    if [ ${#_pwd} -ge $half_width ];then
        # \n
        local new_line=" "$'\n'" "
    else
        local new_line=""
    fi

    PROMPT=" %~$new_line$vcs_info_msg_0_ $exit_color%#%f "
    RPROMPT=" $(date +"%H:%M:%S") "
}
add-zsh-hook precmd _prompt_precmd

_title_precmd() {
    print -Pn "\e]2; %~ %#\a"
}
add-zsh-hook precmd _title_precmd

## load Solarized LS_COLORS
if [ ! -e ~/.dir_colors ];then
    curl -Ss https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark > ~/.dir_colors
fi
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
