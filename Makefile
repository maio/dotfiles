init:
	@git submodule init
	@git submodule update
	@git config --global user.email "marian.schubert@gmail.com"
	@git config --global user.name "Marian Schubert"
	@git config --global rebase.autosquash true

install:
	@ln -sf `pwd`/shell/inputrc ~/.inputrc
	@# Emacs
	@rm -f ~/.emacs.d
	@ln -sf `pwd`/emacs/emacs ~/.emacs
	@ln -sf `pwd`/emacs/emacs.d ~/.emacs.d


update: clean
	@git submodule foreach git pull origin master
	@rm -rf emacs/emacs.d/elpa

clean:
	@find . -name \*.elc | xargs rm -f .noop
