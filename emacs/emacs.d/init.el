(add-to-list 'load-path "~/.emacs.d")
(require 'maio-util)

(require-and-exec 'package
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (let ((my-packages '(starter-kit
                       starter-kit-lisp
                       undo-tree
                       autopair
                       ace-jump-mode
                       goto-last-change
                       slime
                       clojure-mode
                       midje-mode
                       ack-and-a-half
                       flymake
                       flymake-cursor
                       rainbow-mode
                       diminish
                       popup
                       fuzzy
                       multi-eshell
                       yasnippet yasnippet-bundle)))
    (dolist (package my-packages)
      (when (not (package-installed-p package))
        (package-install package)))))

(require 'maio-ui)
(require 'maio-misc)
(require 'maio-evil)
(require 'maio-shell)
(require 'maio-php)
(require 'maio-perl)
(require 'feature-mode)
(require 'perltidy)
(require 'maio-modeline)
(require 'maio-completion)
(require 'maio-prog)
(require 'maio-sql)
(require 'maio-org)
(require 'maio-git)
(require 'maio-helm)
(require 'maio-keys)

(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

