init:
	@git config --global user.email "marian.schubert@gmail.com"
	@git config --global user.name "Marian Schubert"
	@git config --global rebase.autosquash true
	@git config --global pull.rebase true

install:
	@ln -sf `pwd`/shell/inputrc ~/.inputrc
	@# Emacs
	@rm -f ~/.emacs.d
	@ln -sf `pwd`/emacs/emacs-mini ~/.emacs-mini
	@ln -sf `pwd`/emacs/emacs ~/.emacs
	@ln -sf `pwd`/emacs/emacs.d ~/.emacs.d

update: clean
	@rm -rf emacs/emacs.d/elpa
	@git checkout emacs/emacs.d/elpa
	@emacs --batch -l emacs/emacs.d/init.el

clean:
	@find . -name \*.elc | xargs rm -f .noop
