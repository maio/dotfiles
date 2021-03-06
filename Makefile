init:
	@git config --global user.email "marian.schubert@gmail.com"
	@git config --global user.name "Marian Schubert"
	@git config --global rebase.autosquash true
	@git config --global pull.rebase true
	@git config --global alias.exec '!exec '

install:
	@ln -sf `pwd`/hooks/post-commit ./.git/hooks/post-commit
	@ln -sf `pwd`/shell/inputrc ~/.inputrc
	@ln -sf `pwd`/kitty/config ~/.config/kitty
	@ln -sf `pwd`/idea/ideavimrc ~/.ideavimrc
