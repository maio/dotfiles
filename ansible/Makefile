OS := $(shell uname)

ifeq ($(OS),Darwin)
	ANSIBLE_BIN := /opt/homebrew/bin/ansible-playbook
else
	# Linux
	ANSIBLE_BIN := /usr/bin/ansible-playbook
endif

ANSIBLE_BIN ?= /usr/bin/ansible-playbook

# Ubuntu's default sudo-rs rewrites the password prompt so ansible never
# recognizes it; use classic sudo when it's installed alongside
ifneq ($(wildcard /usr/bin/sudo.ws),)
	BECOME_EXE := -e ansible_become_exe=sudo.ws
endif

# Ask for the sudo password unless sudo works without one (e.g. in sandboxes)
ifneq ($(shell sudo -k -n true 2>/dev/null && echo yes),yes)
	ASK_BECOME_PASS := --ask-become-pass
endif

PLAYBOOK := $(ANSIBLE_BIN) -i localhost $(ASK_BECOME_PASS) $(BECOME_EXE) playbook.yml

# Groups are tags in playbook.yml
.PHONY: install install-dev

install: $(ANSIBLE_BIN)
	@$(PLAYBOOK) --tags=shell,ssh,cli,emacs

install-dev: $(ANSIBLE_BIN)
	@$(PLAYBOOK) --tags=dev

/usr/bin/ansible-playbook:
	sudo apt-get update
	sudo apt-get install -y ansible

/opt/homebrew/bin/ansible-playbook: /opt/homebrew/bin/brew
	@brew install ansible

/opt/homebrew/bin/brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

