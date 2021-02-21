## zsh compile
if [ ! -e "${ZDOTDIR}/.zshrc.zwc" -o "${ZDOTDIR}/.zshrc.zwc" -ot "${ZDOTDIR}/.zshrc" ];then
    zcompile ${ZDOTDIR}/.zshrc
fi

## fpath
fpath=(${ZDOTDIR}/plugins/zsh-completions/src $fpath)

## autoload functions
autoload -Uz compinit colors vcs_info add-zsh-hook;
compinit; colors;

## options
setopt prompt_subst auto_menu auto_list auto_cd extended_history hist_ignore_dups hist_save_no_dups hist_reduce_blanks share_history

## load zsh plugins installed by pacman
source "${ZDOTDIR}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${ZDOTDIR}/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

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

    PROMPT="%K{black} %~${new_line}${vcs_info_msg_0_} ${exit_color}%#%f %k"
    RPROMPT="%K{black} $(date +"%H:%M:%S") %k"
}
add-zsh-hook precmd _prompt_precmd

## load Solarized LS_COLORS
if [ ! -e "~/.dir_colors" ];then
    curl -Ss https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark > ~/.dir_colors
fi
eval $(dircolors ~/.dir_colors)

## zsh variable
# HIST
HISTFILE=${ZDOTDIR}/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

## alias
# ls
alias ls="ls --human-readable --sort=extension --color=auto"
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
# df
alias df="df --human-readable"
# grep
alias grep="grep --color=auto"
