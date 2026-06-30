init:
	@git config --global user.email "marian.schubert@gmail.com"
	@git config --global user.name "Marian Schubert"
	@git config --global rebase.autoStash true
	@git config --global rebase.autosquash true
	@git config --global pull.rebase true

install-common:
	@ln -sf `pwd`/hooks/post-commit ./.git/hooks/post-commit
	@ln -sf `pwd`/shell/inputrc ~/.inputrc
	@rm -rf ~/.config/herdr/config.toml && ln -sf `pwd`/herdr/config.toml ~/.config/herdr/config.toml

install-linux: install-common

install-osx: install-common
	@rm -rf ~/.config/ghostty && ln -sf `pwd`/ghostty ~/.config/ghostty
