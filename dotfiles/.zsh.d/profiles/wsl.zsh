# wsl interop workaround
# https://github.com/microsoft/WSL/issues/7174#issuecomment-940163080
_rc_fix_interop() {
    ps -o ppid= -p ${1:-$$} | read ppid
    [[ $(ps -o cmd= $ppid) = "/init" ]] && echo $ppid || _rc_fix_interop $ppid
}

if (uname -r | grep WSL > /dev/null);then
    export WSL_INTEROP="/run/WSL/$(_rc_fix_interop)_interop"

    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMMmodule=fcitx

    (_rc_execute fcitx-autostart > /dev/null 2>&1 &)

    [[ -e /tmp/windows-ssh-agent.sock ]] && export SSH_AUTH_SOCK=/tmp/windows-ssh-agent.sock

    [[ $HOST = "" ]] && export GDK_SCALE=2 QT_SCALE_FACTOR=2
fi
