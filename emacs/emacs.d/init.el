(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/magit/lisp")
(require 'maio-util)

(setq use-package-always-ensure t)

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

  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  (let ((my-packages '(auto-compile
                       better-defaults
                       elisp-slime-nav
                       f
                       s
                       dash
                       undo-tree
                       ace-jump-mode
                       readline-complete
                       goto-chg
                       scratch
                       recompile-on-save
                       clojure-cheatsheet
                       discover-clj-refactor
                       eink-theme
                       feature-mode
                       markdown-mode
                       mustache-mode
                       yaml-mode
                       php-mode
                       js2-mode
                       js2-refactor
                       nodejs-repl
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
                       bookmark+
                       smartparens
                       org-present
                       iedit
                       evil-iedit-state
                       evil-cleverparens
                       rainbow-mode
                       fullframe
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
                       git-timemachine
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
(require 'maio-experiments)
(require 'maio-dojo)

(regular-mode)
(savehist-mode 1)
