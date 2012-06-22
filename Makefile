update: clean
	@git submodule foreach git pull origin master
	@rm -rf emacs/emacs.d/elpa

clean:
	@find . -name \*.elc | xargs rm
