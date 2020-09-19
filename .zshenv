export ZDOTDIR=~/.zsh.d
# n
export N_PREFIX=~/.n
## PATH
# n (node)
export PATH=$N_PREFIX/bin:$PATH
# cabal (haskell)
export PATH=~/.cabal/bin:$PATH
# ghcup (haskell)
export PATH=~/.ghcup/bin:$PATH
# stack (haskell)
export PATH=$(~/.local/bin/stack path --compiler-bin):$PATH
# cargo (rust)
export PATH=~/.cargo/bin:$PATH
# user local
export PATH=~/.local/bin:$PATH
