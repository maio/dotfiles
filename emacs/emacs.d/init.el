(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/lisp/magit/lisp")
(require 'maio-util)

(setq use-package-always-ensure t)

(require-and-exec 'package
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
  (package-initialize)
  ;; (add-to-list 'package-archives
  ;;              '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  ;; (add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
  (when (not package-archive-contents)
    (package-refresh-contents))

  (unless (package-installed-p 'use-package)
    (package-install 'use-package))

  (let ((my-packages '(auto-compile
                       better-defaults
                       f
                       s
                       dash

                       ace-jump-mode
                       recompile-on-save
                       eink-theme
                       rpm-spec-mode
                       scratch
                       ag
                       idle-highlight-mode
                       puppet-mode
                       dired-details
                       bookmark+
                       org-present
                       iedit
                       rainbow-mode
                       draft-mode
                       xclip
                       prodigy

                       ;; clojure
                       clojure-cheatsheet
                       discover-clj-refactor

                       ;; prog
                       feature-mode
                       mustache-mode
                       yaml-mode
                       groovy-mode
                       paredit
                       smartparens
                       elisp-slime-nav
                       swift-mode

                       ;; web
                       web-mode
                       php-mode
                       less-css-mode
                       markdown-mode

                       ;; git
                       magit
                       orgit
                       git-timemachine
                       gist

                       ;; evil
                       evil
                       evil-numbers
                       evil-surround
                       evil-iedit-state
                       evil-cleverparens
                       evil-nerd-commenter
                       goto-chg
                       undo-tree

                       )))
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
(require 'read-some-code)

(regular-mode)
(savehist-mode 1)
