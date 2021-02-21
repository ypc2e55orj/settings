export ZDOTDIR=~/.zsh.d

## PATH
# n (node)
export N_PREFIX=~/.n
PATH=$N_PREFIX/bin:$PATH
# cabal (haskell)
PATH=~/.cabal/bin:$PATH
# ghcup (haskell)
PATH=~/.ghcup/bin:$PATH
# stack (haskell)
if (builtin command -v ~/.local/bin/stack > /dev/null);then
    PATH=$(~/.local/bin/stack path --compiler-bin):$PATH
fi
# cargo (rust)
PATH=~/.cargo/bin:$PATH
# user local
PATH=~/.local/bin:$PATH

export PATH

## WSL2
if (uname -r | grep "WSL2" > /dev/null);then
    # DISPLAY
    export DISPLAY=$(cat /etc/resolv.conf | awk /nameserver/'{print $2}'):0.0
    # IME(fcitx)
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMModule=fcitx
    fcitx > /dev/null 2>&1 &
fi

## LOCAL
export LANG=ja_JP.UTF-8
