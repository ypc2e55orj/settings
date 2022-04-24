if (uname -r | grep WSL > /dev/null);then
    export DISPLAY=${WSL_HOST_IP:=$(cat /etc/resolv.conf | awk /^nameserver/'{print $2}')}:0.0
    export LIBGL_ALWAYS_INDIRECT=1

    export PULSE_SERVER=tcp:$WSL_HOST_IP

    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMMmodule=fcitx
    (builtin command -v fcitx-autostart > /dev/null) && \
        (fcitx-autostart > /dev/null 2>&1 &)

    [[ -e /tmp/windows-ssh-agent.sock ]] && export SSH_AUTH_SOCK=/tmp/windows-ssh-agent.sock

    [[ $HOST = "" ]] && export GDK_SCALE=2 QT_SCALE_FACTOR=2
fi
