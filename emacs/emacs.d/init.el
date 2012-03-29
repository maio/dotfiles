(add-to-list 'load-path "~/.emacs.d")
(require 'maio-util)

(require-and-exec 'package
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (let ((my-packages '(starter-kit
                       starter-kit-lisp
                       starter-kit-bindings
                       undo-tree
                       autopair
                       goto-last-change
                       clojure-mode midje-mode
                       anything
                       anything-config
                       anything-match-plugin
                       ack-and-a-half
                       flymake
                       flymake-cursor
                       rainbow-mode
                       diminish
                       zenburn-theme
                       popup
                       fuzzy
                       multi-eshell
                       yasnippet yasnippet-bundle)))
    (dolist (package my-packages)
      (when (not (package-installed-p package))
        (package-install package)))))

(require 'maio-misc)
(require 'maio-evil)
(require 'maio-shell)
(require 'maio-php)
(require 'maio-perl)
(require 'feature-mode)
(require 'perltidy)
(require 'maio-modeline)
(require 'maio-completion)
;; (require 'maio-anything)
(require 'maio-prog)
(require 'maio-git)
(require 'maio-helm)

(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(load-theme 'cofi-dark t)

