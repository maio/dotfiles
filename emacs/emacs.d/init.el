(add-to-list 'load-path "~/.emacs.d")

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings
                                  paredit clojure-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

; VIM emulation
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(define-key evil-insert-state-map "\C-c" 'evil-force-normal-state)
(define-key evil-normal-state-map ",b" 'switch-to-buffer)
(define-key evil-normal-state-map ",," 'evil-buffer)
(define-key evil-insert-state-map ",w" 'evil-write)
(define-key evil-normal-state-map ",w" 'evil-write)
(define-key evil-motion-state-map (kbd "TAB") "%")
