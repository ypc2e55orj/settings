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
