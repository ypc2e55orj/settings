HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

# autoload functions
autoload -Uz \
    add-zsh-hook \
    colors \
    compinit bashcompinit \
    vcs_info

add-zsh-hook precmd vcs_info
colors
compinit; bashcompinit

# options
setopt \
    auto_cd \
    auto_list \
    auto_menu \
    extended_history \
    hist_ignore_dups \
    hist_reduce_blanks \
    hist_save_no_dups \
    prompt_subst \
    share_history

# keybind
bindkey -e

# rc
_rc_path() { [[ -d $1 ]] && export PATH=$1:$PATH }
_rc_execute() { (command -v "$1" >/dev/null) && $@ }
_rc_source() { [[ -f $1 ]] && source "$1" }

source $ZDOTDIR/plugins/plugins.zsh
for profile in $ZDOTDIR/profiles/*.zsh; do source $profile; done
