install:
	@ln -sf `pwd`/private.xml "/Users/maio/Library/Application Support/KeyRemap4MacBook/private.xml"

/usr/local/bin/brew:
	@yes | ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

/usr/local/bin/ansible: /usr/local/bin/brew
	@brew install ansible

ansible: /usr/local/bin/ansible
	@ansible-playbook -i localhost playbook.yml
