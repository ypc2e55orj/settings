_rc_prompt_precmd() {
    local exit_code=$?

    local exit_color
    [[ $exit_code -eq 0 ]] && exit_color="%F{cyan}" || exit_color="%F{magenta}"

    local new_line
    [[ $#PWD -lt $[$(tput cols) / 2] ]] && new_line="" || new_line=" "$'\n'" "

    local venv
    [[ -z $VIRTUAL_ENV ]] && venv="" || venv="venv($(basename $(dirname $VIRTUAL_ENV))) "

    PROMPT=" $venv%~$new_line$vcs_info_msg_0_ $exit_color%#%f "
    RPROMPT=" $(date +"%H:%M:%S") "
}
add-zsh-hook precmd _rc_prompt_precmd
