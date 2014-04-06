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
                       s
                       dash
                       undo-tree
                       git-rebase-mode
                       ace-jump-mode
                       company
                       readline-complete
                       goto-chg
                       erlang
                       recompile-on-save
                       clojure-mode
                       clojure-test-mode
                       clojure-cheatsheet
                       cider
                       midje-mode
                       feature-mode
                       mustache-mode
                       yaml-mode
                       php-mode
                       js2-mode
                       json-mode
                       web-mode
                       haskell-mode
                       rpm-spec-mode
                       ag
                       puppet-mode
                       shell-switcher
                       dired-details
                       flycheck
                       flymake-cursor
                       diminish
                       bookmark+
                       smartparens
                       iedit
                       smartrep
                       sackspace
                       yasnippet
                       htmlize
                       helm
                       helm-descbinds
                       helm-git-grep
                       wgrep
                       evil
                       evil-numbers
                       surround
                       xclip
                       expand-region
                       gist)))
    (dolist (package my-packages)
      (ensure-package package))))

(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

(require 'maio-modeline)
(require 'maio-ui)
(require 'maio-misc)
(require 'maio-evil)
(require 'maio-shell)
(require 'maio-eshell)
(require 'maio-web)
(require 'maio-perl)
(require 'maio-python)
(require 'maio-erlang)
(require 'maio-clojure)
(require 'maio-javascript)
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
(require 'maio-experiments)
(require 'maio-local nil t)

(regular-mode)
(savehist-mode 1)
