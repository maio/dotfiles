(add-to-list 'load-path "~/.emacs.d")
(require 'cl)   ;; required by yasnippet - try to kill this sometime
(require 'maio-util)

(require-and-exec 'package
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
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
                       sackspace
                       undo-tree
                       auto-complete
                       ace-jump-mode
                       goto-chg
                       clojure-mode
                       feature-mode
                       mustache-mode
                       yaml-mode
                       php-mode
                       js3-mode
                       nrepl
                       ac-nrepl
                       dired-details
                       flycheck
                       flymake-cursor
                       diminish
                       bookmark+
                       diff-hl
                       autopair
                       mark-multiple
                       multiple-cursors
                       key-chord
                       powerline
                       yasnippet
                       helm
                       evil
                       surround)))
    (dolist (package my-packages)
      (when (not (package-installed-p package))
        (package-install package)))))

(require 'auto-compile)
(auto-compile-on-load-mode 1)
(auto-compile-on-save-mode 1)

(require 'maio-key-chord)
(require 'maio-ui)
(require 'maio-misc)
(require 'maio-evil)
(require 'maio-shell)
(require 'maio-php)
(require 'maio-perl)
(require 'maio-python)
(require 'maio-clojure)
(require 'maio-javascript)
(require 'maio-modeline)
(require 'maio-completion)
(require 'maio-prog)
(require 'maio-sql)
(require 'maio-org)
(require 'maio-git)
(require 'maio-helm)
(require 'maio-bookmark)
(require 'maio-dired)
(require 'maio-keys)
(require 'maio-multiple-cursors)
(require 'git-grep)

(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(regular-mode)
(savehist-mode 1)
