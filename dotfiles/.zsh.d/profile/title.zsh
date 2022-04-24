_rc_title_precmd() { print -Pn "\e]2; %~ %#\a" }
add-zsh-hook precmd _rc_title_precmd
