(add-to-list 'load-path "~/.emacs.d")

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings
                                  paredit project
                                  goto-last-change
                                  clojure-mode midje-mode
                                  php-mode
                                  yasnippet yasnippet-bundle)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-hook 'clojure-mode-hook 'midje-mode)

(setq ffip-patterns '("*.clj", "*.goap", "*.body", "*.tt", "*.tt2", "*.pm", "*.pl", "*.php", "*.t"))
(setq ffip-limit 10000)

(setq auto-mode-alist (cons '("\\.t$" . perl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.body$" . sql-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.spec$" . sql-mode) auto-mode-alist))

(defun edit-init () (interactive) (find-file "~/.emacs.d/init.el"))

(require 'feature-mode)

; VIM emulation
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
(setq evil-move-cursor-back nil)
(define-key evil-insert-state-map "\C-c" 'evil-force-normal-state)
(define-key evil-normal-state-map ",b" 'switch-to-buffer)
(define-key evil-normal-state-map ",," 'evil-buffer)
(define-key evil-normal-state-map ",v" 'edit-init)
(define-key evil-normal-state-map ",w" 'evil-write)
(define-key evil-normal-state-map ",t" 'find-file-in-project)
(define-key evil-motion-state-map (kbd "TAB") "%")
