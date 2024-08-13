OS := $(shell uname)

ifeq ($(OS),Darwin)
	ANSIBLE_BIN := /opt/homebrew/bin/ansible-playbook
else
	# Linux
	ANSIBLE_BIN := /usr/bin/ansible-playbook
endif

ANSIBLE_BIN ?= /usr/bin/ansible-playbook

install: $(ANSIBLE_BIN)
	@$(ANSIBLE_BIN) -i localhost --tags=$(OS) playbook.yml

/usr/bin/ansible-playbook:
	sudo apt-get install ansible

/opt/homebrew/bin/ansible-playbook: /opt/homebrew/bin/brew
	@brew install ansible

/opt/homebrew/bin/brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

