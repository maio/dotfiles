install:
	@ln -sf `pwd`/private.xml "/Users/maio/Library/Application Support/KeyRemap4MacBook/private.xml"
	@mkdir -p ~/Library/KeyBindings
	@ln -sf `pwd`/DefaultKeyBinding.dict "/Users/maio/Library/KeyBindings/DefaultKeyBinding.dict"

/usr/local/bin/brew:
	@yes | ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

/usr/local/bin/ansible: /usr/local/bin/brew
	@brew install ansible

ansible: /usr/local/bin/ansible
	@ansible-playbook --ask-sudo-pass -i localhost playbook.yml
