(add-to-list 'load-path "~/.emacs.d")
(require 'advice)     ; required by ido (until they fix dependencies)
(require 'maio-util)

;; things for backwards compatibility - try to remove them in future
(defvar hippie-expand-try-functions-list '())
(put 'modeline 'face-alias 'mode-line)

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
                       s
                       popup
                       undo-tree
                       auto-complete
                       ace-jump-mode
                       goto-last-change
                       clojure-mode
                       js3-mode
                       nrepl
                       ack-and-a-half
                       flycheck
                       diminish
                       fuzzy
                       escreen
                       autopair
                       mark-multiple
                       key-chord
                       xclip
                       solarized-theme
                       yasnippet
                       yasnippet-bundle)))
    (dolist (package my-packages)
      (when (not (package-installed-p package))
        (package-install package)))))

(require 'maio-ui)
(require 'maio-misc)
(require 'maio-evil)
(require 'maio-shell)
(require 'maio-php)
(require 'maio-perl)
(require 'maio-python)
(require 'maio-clojure)
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

(regular-mode)
(toggle-fullscreen)
(desktop-save-mode 1)
(savehist-mode 1)
