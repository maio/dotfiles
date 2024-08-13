init:
	@git config --global user.email "marian.schubert@gmail.com"
	@git config --global user.name "Marian Schubert"
	@git config --global rebase.autoStash true
	@git config --global pull.rebase true

install-common:
	@ln -sf `pwd`/hooks/post-commit ./.git/hooks/post-commit
	@ln -sf `pwd`/shell/inputrc ~/.inputrc

install-linux: install-common

install-osx: install-common
	@rm -rf ~/.config/kitty && ln -sf `pwd`/kitty/config ~/.config/kitty
