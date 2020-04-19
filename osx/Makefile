install:
	@ln -sf `pwd`/karabiner.json "/Users/$(USER)/.config/karabiner/karabiner.json"
	$(MAKE) install-fonts
	@mkdir -p ~/Library/KeyBindings
	@ln -sf `pwd`/DefaultKeyBinding.dict "/Users/$(USER)/Library/KeyBindings/DefaultKeyBinding.dict"
	@mkdir -p ~/Desktop/Screenshots
	@defaults write com.apple.screencapture location ~/Desktop/Screenshots
	@defaults write com.apple.dock expose-animation-duration -float 0
	@defaults -currentHost write -globalDomain AppleFontSmoothing -int 0

install-fonts:
	@cp ../fonts/* /Library/Fonts/

