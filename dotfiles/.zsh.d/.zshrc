HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

# autoload functions
autoload -Uz compinit colors vcs_info add-zsh-hook;
compinit; colors; add-zsh-hook precmd vcs_info;

# options
setopt prompt_subst auto_menu auto_list auto_cd extended_history hist_ignore_dups hist_save_no_dups hist_reduce_blanks share_history

# keybind
bindkey -e

source $ZDOTDIR/plugins/plugins.zsh
for profile in $ZDOTDIR/profile/*.zsh; do source $profile; done
