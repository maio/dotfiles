(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(require 'maio-util)

(require-and-exec 'package
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (let ((my-packages '(auto-compile
                       starter-kit
                       starter-kit-lisp
                       starter-kit-eshell
                       s
                       dash
                       popup
                       undo-tree
                       git-rebase-mode
                       auto-complete
                       ace-jump-mode
                       goto-chg
                       erlang
                       clojure-mode
                       clojure-test-mode
                       clojure-cheatsheet
                       cider
                       ac-nrepl
                       midje-mode
                       feature-mode
                       mustache-mode
                       yaml-mode
                       php-mode
                       js2-mode
                       web-mode
                       haskell-mode
                       ag
                       eimp
                       puppet-mode
                       shell-switcher
                       dired-details
                       flycheck
                       flymake-cursor
                       diminish
                       bookmark+
                       diff-hl
                       smartparens
                       iedit
                       sackspace
                       yasnippet
                       helm
                       helm-descbinds
                       helm-swoop
                       helm-git-grep
                       wgrep
                       dizzee
                       evil
                       evil-numbers
                       surround
                       xclip
                       expand-region
                       gist)))
    (dolist (package my-packages)
      (when (not (package-installed-p package))
        (package-install package)))))

(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

(require 'maio-ui)
(require 'maio-misc)
(require 'maio-evil)
(require 'maio-shell)
(require 'maio-php)
(require 'maio-web)
(require 'maio-perl)
(require 'maio-python)
(require 'maio-erlang)
(require 'maio-clojure)
(require 'maio-javascript)
(require 'maio-modeline)
(require 'maio-prog)
(require 'maio-completion)
(require 'maio-sql)
(require 'maio-org)
(require 'maio-git)
(require 'maio-helm)
(require 'maio-bookmark)
(require 'maio-dired)
(require 'maio-erc)
(require 'maio-keys)
(require 'maio-iedit)
(require 'maio-clipboard)
(require 'maio-modes)
(require 'maio-local nil t)

(regular-mode)
(savehist-mode 1)
