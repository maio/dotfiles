(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/magit/lisp")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(require 'maio-util)

(require-and-exec 'package
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (package-initialize)
  ;; (add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (let ((my-packages '(auto-compile
                       better-defaults
                       elisp-slime-nav
                       f
                       s
                       dash
                       undo-tree
                       ace-jump-mode
                       company
                       readline-complete
                       goto-chg
                       scratch
                       erlang
                       recompile-on-save
                       clojure-mode
                       clojure-cheatsheet
                       cider
                       clj-refactor
                       discover-clj-refactor
                       feature-mode
                       markdown-mode
                       mustache-mode
                       yaml-mode
                       php-mode
                       js2-mode
                       js2-refactor
                       json-mode
                       web-mode
                       less-css-mode
                       rpm-spec-mode
                       ag
                       idle-highlight-mode
                       paredit
                       puppet-mode
                       groovy-mode
                       dired-details
                       flycheck
                       diminish
                       bookmark+
                       smartparens
                       org-present
                       iedit
                       evil-iedit-state
                       rainbow-mode
                       fullframe
                       sackspace
                       yasnippet
                       htmlize
                       draft-mode
                       helm
                       helm-descbinds
                       helm-git-grep
                       helm-cmd-t
                       helm-ag
                       helm-backup
                       wgrep
                       wgrep-ag
                       evil
                       evil-numbers
                       evil-surround
                       evil-nerd-commenter
                       xclip
                       prodigy
                       magit
                       orgit
                       gist)))
    (dolist (package my-packages)
      (ensure-package package))))

(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

(require 'maio-local nil t)
(require 'maio-modeline)
(require 'maio-ui)
(require 'maio-faces)
(require 'maio-misc)
(require 'maio-evil)
(require 'maio-shell)
(require 'maio-eshell)
(require 'maio-lisp)
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
(require 'maio-multiple-cursors)
(require 'maio-clipboard)
(require 'maio-modes)
(require 'maio-experiments)
(require 'maio-dojo)

(regular-mode)
(savehist-mode 1)
