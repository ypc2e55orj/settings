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

    export SSH_AUTH_SOCK=/tmp/windows-ssh-agent-$RANDOM.sock
    (socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork 2>&1 &)

    [[ $HOST = "" ]] && export GDK_SCALE=2 QT_SCALE_FACTOR=2
fi
