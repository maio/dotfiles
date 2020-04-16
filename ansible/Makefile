OS := $(shell uname)

ifeq ($(OS),Darwin)
	ANSIBLE_BIN := /usr/local/bin/ansible
else
	# Linux
	ANSIBLE_BIN := /usr/bin/ansible
endif

ANSIBLE_BIN ?= /usr/bin/ansible-playbook

ansible: $(ANSIBLE_BIN)
	@ansible-playbook -i localhost --tags=$(OS) playbook.yml

/usr/bin/ansible-playbook:
	sudo apt-get install ansible

/usr/local/bin/ansible: /usr/local/bin/brew
	@brew install ansible

/usr/local/bin/brew:
	@yes | ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
