.PHONY: install
install:
	zsh -c 'rm -rf ~/.zshenv ~/.zsh.d && cp -rv dotfiles/.* ~'
