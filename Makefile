update:
	@git submodule foreach git pull origin master

clean:
	@find . -name \*.elc | xargs rm
