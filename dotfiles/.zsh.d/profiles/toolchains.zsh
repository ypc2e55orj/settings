# local
_rc_path ~/.local/bin

# editor
export EDITOR=vim
export VISUAL=vim

# go
_rc_path ~/.local/go/bin

# haskell
_rc_path ~/.cabal/bin
_rc_path ~/.ghcup/bin

_rc_path "$(_rc_execute stack path --compiler-bin)"

# jvm
_rc_source ~/.sdkman/bin/sdkman-init.sh

# node
_rc_path ~/.n/bin

# ros2 galactic
_rc_source /opt/ros/galactic/setup.zsh

# rust
_rc_path ~/.cargo/bin

# python
export PIPENV_VENV_IN_PROJECT=true
export PYENV_PYTHON=$PYENV_ROOT/shims/python
export PYENV_ROOT=~/.pyenv

_rc_path $PYENV_ROOT/bin
_rc_path $PYENV_ROOT/shims

# passerine
_rc_path ~/.aspen/bin

# php
_rc_path ~/.phpenv/bin
eval "$(_rc_execute phpenv init -)"
