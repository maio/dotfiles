OS := $(shell uname)

ifeq ($(OS),Darwin)
	ANSIBLE_BIN := /usr/local/bin/ansible-playbook
else
	# Linux
	ANSIBLE_BIN := /usr/bin/ansible-playbook
endif

ANSIBLE_BIN ?= /usr/bin/ansible-playbook

install: $(ANSIBLE_BIN)
	@$(ANSIBLE_BIN) -i localhost --tags=$(OS) playbook.yml

/usr/bin/ansible-playbook:
	sudo apt-get install ansible

/usr/local/bin/ansible-playbook: /usr/local/bin/brew
	@brew install ansible

/usr/local/bin/brew:
	@yes | ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
