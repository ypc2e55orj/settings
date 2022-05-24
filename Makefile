CURL = curl --proto '=https' --tlsv1.2 -LSfs 

.PHONY: install dir_colors rust jdk haskell go python
install: ~/.dir_colors
	zsh -c 'rm -rf ~/.zshenv ~/.zsh.d && cp -rv dotfiles/.* ~'

dir_colors: ~/.dir_colors
~/.dir_colors:
	$(CURL) https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark > ~/.dir_colors

rust: ~/.rustup
~/.rustup:
	$(CURL) https://sh.rustup.rs | sh

jdk: ~/.sdkman
~/.sdkman:
	sudo apt update && sudo apt install -y zip unzip
	$(CURL) https://get.sdkman.io | bash

haskell: ~/.ghcup ~/.local/bin/stack
~/.ghcup:
	$(CURL) https://get-ghcup.haskell.org | sh

~/.local/bin/stack: ~/.local/bin
	$(CURL) https://get.haskellstack.org -o /tmp/haskellstack.sh
	sh /tmp/haskellstack.sh -d ~/.local/bin
	rm /tmp/haskellstack.sh

go: ~/.local/bin/go
~/.local/bin/go: ~/.local/bin
	$(CURL) https://go.dev/dl/go1.18.2.linux-amd64.tar.gz -o /tmp/go.tar.gz
	tar -xf /tmp/go.tar.gz -C /tmp
	cp /tmp/go/bin/* ~/.local/bin
	rm -r /tmp/go
	rm /tmp/go.tar.gz

python: ~/.pyenv
~/.pyenv:
	sudo apt update && sudo apt install -y make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
	$(CURL) https://pyenv.run | bash

~/.local/bin:
	mkdir -p ~/.local/bin
