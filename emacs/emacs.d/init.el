(setq exec-path (cons "/opt/local/bin" exec-path))
(add-to-list 'load-path "~/.emacs.d")

(set-face-attribute 'default nil :height 160)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)
(global-auto-revert-mode 1)
(setq fill-column 80)
(setq tab-width 4)
(setq c-basic-offset 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq eshell-scroll-to-bottom-on-output t)
(setq-default show-trailing-whitespace t)
(column-number-mode 1)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings
                                  find-file-in-project
                                  undo-tree
                                  paredit autopair
                                  project
                                  goto-last-change
                                  clojure-mode midje-mode
                                  php-mode
                                  anything
                                  anything-config
                                  anything-match-plugin
                                  ack-and-a-half
                                  yasnippet yasnippet-bundle)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-hook 'clojure-mode-hook 'midje-mode)

(setq ffip-limit 10000)
(setq ffip-patterns '("*.clj", "*.goap", "*.body", "*.tt", "*.tt2", "*.pm",
                      "*.pl", "*.php", "*.t", "*.feature", "*.ini"))
(require 'find-file-in-project)

(setq auto-mode-alist (cons '("\\.body$" . sql-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.spec$" . sql-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))

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

;; (global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

;; Evil plugins
(add-to-list 'load-path "~/.emacs.d/evil-plugins/surround")
(require 'surround)
(global-surround-mode 1)

(add-to-list 'load-path "~/.emacs.d/evil-plugins/leader")
(setq evil-leader/leader ","
      evil-leader/in-all-states t)
(require 'evil-leader)
(evil-leader/set-key
  "," 'evil-buffer
  "e" 'eval-defun
  "b" 'anything-for-files
  "v" 'edit-init
  "w" 'save-buffer
  "t" 'anything-project)

;;;; Devel
(which-func-mode 1)

;; SQL
(require 'sqlplus)

;; Perl
(setq auto-mode-alist (cons '("\\.t$" . perl-mode) auto-mode-alist))

(add-hook 'cperl-mode-hook 'n-cperl-mode-hook t)
(defun n-cperl-mode-hook ()
  (setq cperl-indent-parens-as-block t
        cperl-indent-level 4
        cperl-close-paren-offset -4)
  (set-face-background 'cperl-array-face "black")
  (set-face-background 'cperl-hash-face "black"))

(require 'autopair)
(autopair-global-mode 1)

(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(defun close-all-buffers ()
  (interactive)
    (mapc 'kill-buffer (buffer-list)))

(load-theme 'tango-dark)

(add-hook 'php-mode-hook
          (lambda ()
            (defun ywb-php-lineup-arglist-intro (langelem)
              (save-excursion
                (goto-char (cdr langelem))
                (vector (+ (current-column) c-basic-offset))))
            (defun ywb-php-lineup-arglist-close (langelem)
              (save-excursion
                (goto-char (cdr langelem))
                (vector (current-column))))
            (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
            (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

(require 'anything-project)
(require 'anything-match-plugin)
(setq anything-for-files-prefered-list
  '(anything-c-source-ffap-line
    anything-c-source-ffap-guesser
    anything-c-source-buffers+
    anything-c-source-recentf
    anything-c-source-bookmarks
    anything-c-source-file-cache
    anything-c-source-files-in-current-dir+))

(require 'recentf)
(setq recentf-max-saved-items 100)
(add-to-list 'recentf-exclude "emacs.d")

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(defun ac-common-setup ()
  (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  (add-to-list 'ac-sources 'ac-source-yasnippet))
(ac-config-default)

(require 'flymake)
(push '(".+\\.t$" flymake-perl-init) flymake-allowed-file-name-masks)
(add-hook 'perl-mode-hook
	      (lambda () (flymake-mode t)))
