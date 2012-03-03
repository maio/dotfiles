(add-to-list 'load-path "~/.emacs.d")

(setq make-backup-files nil)
(setq auto-save-default nil)
(global-auto-revert-mode 1)
(setq fill-column 80)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings
                                  undo-tree
                                  paredit autopair
                                  project
                                  goto-last-change
                                  clojure-mode midje-mode
                                  php-mode
                                  yasnippet yasnippet-bundle)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-hook 'clojure-mode-hook 'midje-mode)

(setq ffip-limit 10000)
(setq ffip-patterns '("*.clj", "*.goap", "*.body", "*.tt", "*.tt2", "*.pm",
                      "*.pl", "*.php", "*.t", "*.feature"))

(setq auto-mode-alist (cons '("\\.body$" . sql-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.spec$" . sql-mode) auto-mode-alist))

(defun edit-init () (interactive) (find-file "~/.emacs.d/init.el"))

(require 'feature-mode)

;; VIM emulation
(add-to-list 'load-path "~/.emacs.d/evil")
(setq evil-move-cursor-back nil)
(setq evil-want-C-u-scroll t)
(require 'evil)
(evil-mode 1)
(define-key evil-emacs-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-motion-state-map (kbd "TAB") "%")
(define-key evil-motion-state-map (kbd "gp") "`[V`]")
(define-key evil-normal-state-map "H" 'evil-first-non-blank)
(define-key evil-normal-state-map "L" 'evil-last-non-blank)
(define-key evil-normal-state-map (kbd "C-w") 'delete-trailing-whitespace)
(define-key evil-normal-state-map (kbd "C-SPC") 'comment-or-uncomment-region-or-line)

(define-key evil-motion-state-map (kbd "C-v") 'evil-visual-char)
(define-key evil-motion-state-map "v" 'evil-visual-block)

(global-set-key (kbd "RET") 'newline-and-indent)

;; Evil plugins
(add-to-list 'load-path "~/.emacs.d/evil-plugins/surround")
(require 'surround)
(global-surround-mode 1)

(add-to-list 'load-path "~/.emacs.d/evil-plugins/leader")
(setq evil-leader/leader ","
      ;;evil-leader/non-normal-prefix ""
      evil-leader/in-all-states t)
(require 'evil-leader)
(evil-leader/set-key
  "," 'evil-buffer
  "b" 'switch-to-buffer
  "v" 'edit-init
  "w" 'save-buffer
  "t" 'find-file-in-project)

;;;; Devel
(which-func-mode 1)

;; SQL
(require 'sqlplus)

;; Perl
(setq auto-mode-alist (cons '("\\.t$" . perl-mode) auto-mode-alist))
(defalias 'perl-mode 'cperl-mode)

(add-hook 'cperl-mode-hook 'n-cperl-mode-hook t)
(defun n-cperl-mode-hook ()
  (setq cperl-indent-parens-as-block t
        cperl-indent-level 4
        cperl-close-paren-offset -4)
  (set-face-background 'cperl-array-face "black")
  (set-face-background 'cperl-hash-face "black"))

(require 'autopair)
(autopair-global-mode)
