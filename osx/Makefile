install:
	@ln -sf `pwd`/private.xml "/Users/$(USER)/Library/Application Support/Karabiner/private.xml"
	@cp fonts/* /Library/Fonts/
	@mkdir -p ~/Library/KeyBindings
	@ln -sf `pwd`/DefaultKeyBinding.dict "/Users/$(USER)/Library/KeyBindings/DefaultKeyBinding.dict"
	@mkdir -p ~/Desktop/Screenshots
	@defaults write com.apple.screencapture location ~/Desktop/Screenshots

/usr/local/bin/brew:
	@yes | ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

/usr/local/bin/ansible: /usr/local/bin/brew
	@brew install ansible

ansible: /usr/local/bin/ansible
	@ansible-playbook --ask-sudo-pass -i localhost playbook.yml
