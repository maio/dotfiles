install:
	@rm -rf ~/.local/share/fonts
	@ln -sf $(shell cd ..; pwd)/fonts ~/.local/share/fonts
	@fc-cache -f -v
	$(MAKE) -C ../ansible install
