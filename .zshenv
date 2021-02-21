export ZDOTDIR=~/.zsh.d

## PATH
# user local
PATH=~/.local/bin:$PATH
# n (node)
export N_PREFIX=~/.n
PATH=$N_PREFIX/bin:$PATH
# cabal (haskell)
PATH=~/.cabal/bin:$PATH
# ghcup (haskell)
PATH=~/.ghcup/bin:$PATH
# stack (haskell)
if (builtin command -v stack > /dev/null);then
    PATH=$(stack path --compiler-bin):$PATH
fi
# cargo (rust)
PATH=~/.cargo/bin:$PATH

export PATH

## SDKMAN
export SDKMAN_DIR=~/.sdkman

## LOCAL
export LANG=ja_JP.UTF-8

## WSL2
if (uname -r | grep "WSL2" > /dev/null);then
    # DISPLAY
    export DISPLAY=$(cat /etc/resolv.conf | awk /nameserver/'{print $2}'):0.0
    # IME(fcitx)
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMModule=fcitx
fi
