# local
_rc_path ~/.local/bin

# editor
export EDITOR=vim
export VISUAL=vim

# go
_rc_path ~/.local/go/bin

# node
export N_PREFIX=~/.n
_rc_path $N_PREFIX/bin

# rust
_rc_path ~/.cargo/bin

# python
export PIPENV_VENV_IN_PROJECT=true
export PYENV_PYTHON=$PYENV_ROOT/shims/python
export PYENV_ROOT=~/.pyenv

_rc_path $PYENV_ROOT/bin
_rc_path $PYENV_ROOT/shims

