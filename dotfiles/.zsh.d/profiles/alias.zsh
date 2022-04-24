_rc_check_gnu() { $1 --version | grep -i gnu > /dev/null }

if _rc_check_gnu ls; then
    alias ls="ls --human-readable --sort=extension --color=auto"
    alias l="ls"
    alias la="ls -a"
    alias ll="ls -l"
    alias lla="ls -la"
fi

if _rc_check_gnu df; then
    alias df="df --human-readable"
fi

if _rc_check_gnu grep; then
    alias grep="grep --color=auto"
fi
