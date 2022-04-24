_rc_add_path() { [[ -d $1 ]] && export PATH=$1:$PATH }

# local
_rc_add_path ~/.local/bin

# editor
export EDITOR=vim
export VISUAL=vim

# go
_rc_add_path ~/.local/go/bin

# haskell
_rc_add_path ~/.cabal/bin $
_rc_add_path ~/.ghcup/bin
(builtin command -v stack >/dev/null) && _rc_add_path $(stack path --compiler-bin)

# jvm
[[ -f ~/.sdkman/bin/sdkman-init.sh ]] && source ~/.sdkman/bin/sdkman-init.sh

# node
_rc_add_path ~/.n/bin

# ros2 galactic
[[ -f /opt/ros/galactic/setup.zsh ]] && source /opt/ros/galactic/setup.zsh

# rust
_rc_add_path ~/.cargo/bin

# python
export PIPENV_VENV_IN_PROJECT=true
export PYENV_ROOT=~/.pyenv
export PYENV_PYTHON=$PYENV_ROOT/shims/python
_rc_add_path $PYENV_ROOT/bin
_rc_add_path $PYENV_ROOT/shims

# passerine
_rc_add_path ~/.aspen/bin
