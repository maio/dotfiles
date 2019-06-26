;; UI
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(set-frame-font "Iosevka 18" nil t)
(toggle-frame-maximized)

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(global-auto-revert-mode t)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Theme
(use-package eink-theme
  :ensure t
  :config
  (load-theme 'eink t))

;; Keys
(cua-mode t)

(defun apply-ijkl-shortcuts (keymap)
  (define-key keymap (kbd "M-l") 'forward-word)
  (define-key keymap (kbd "M-j") 'backward-word)
  (define-key keymap (kbd "M-i") 'previous-line)
  (define-key keymap (kbd "M-k") 'next-line)
  (define-key keymap (kbd "M-n") 'left-char)
  (define-key keymap (kbd "M-m") 'right-char)
  (define-key keymap (kbd "M-u") 'move-beginning-of-line)
  (define-key keymap (kbd "M-o") 'move-end-of-line)
  (define-key keymap (kbd "M-,") 'beginning-of-defun)
  (define-key keymap (kbd "M-.") 'end-of-defun)
  (define-key keymap (kbd "M-f") 'scroll-up-command)
  (define-key keymap (kbd "M-w") 'scroll-down-command)
  (define-key keymap (kbd "M-SPC") 'isearch-forward)
  (define-key keymap (kbd "M-DEL") 'undo)
  (define-key keymap (kbd "C-s") 'save-buffer)
  (define-key keymap (kbd "M-y") 'kill-whole-line)
  (define-key keymap (kbd "M-d") 'kill-char-or-word)
  )

;;;;;; Page UP/DOWN
(setq scroll-error-top-bottom t)
;;;;;; Incremental search
(define-key isearch-mode-map (kbd "M-k") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "M-i") 'isearch-repeat-backward)

;;;; Duplicate line/region
(use-package duplicate-thing
  :ensure t
  :config
  (global-set-key (kbd "C-d") 'duplicate-thing))
;;;; Expand region
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "M-e") 'er/expand-region)
  (global-set-key (kbd "M-E") 'er/contract-region))
;;;; Comment
(use-package comment-dwim-2
  :ensure t
  :config
  (global-set-key (kbd "C-_") 'comment-dwim-2)
  (global-set-key (kbd "C-/") 'comment-dwim-2))
;;;; Add Selection for Next Occurence
(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "M-g") 'mc/mark-next-like-this-symbol))
;;;; Find buffer/file
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-S-n" . helm-find-files)
         ("C-e" . helm-mini))
  :bind (:map helm-map
	      ("M-i" . helm-previous-line)
	      ("M-k" . helm-next-line)
	      ("M-w" . helm-previous-page)
	      ("M-f" . helm-next-page)
	      :map helm-find-files-map
	      ("M-i" . helm-previous-line)
	      ("M-k" . helm-next-line)
	      ("M-j" . helm-find-files-up-one-level)
	      ("M-l" . helm-execute-persistent-action))
  :config (progn
	    (setq helm-buffers-fuzzy-matching t)
            (helm-mode 1)))

(apply-ijkl-shortcuts global-map)

;; My shortcuts
(global-set-key (kbd "M-`") 'other-window)
(define-prefix-command 'windows-map)
(global-set-key (kbd "C-w") 'windows-map)
(define-key windows-map "m" 'delete-other-windows)
(define-key windows-map "/" 'split-window-right)

;; TODO
(global-unset-key (kbd "M-h"))
(global-unset-key (kbd "C-x C-s"))
(global-unset-key (kbd "C-a"))

;; Packages
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-k") 'magit-status)
  (setq magit-diff-refine-hunk t)
  (add-hook 'with-editor-mode-hook 'flyspell-mode)
  (magit-auto-revert-mode -1)
  (apply-ijkl-shortcuts magit-revision-mode-map))

(use-package fullframe
  :ensure t
  :config
  (fullframe magit-status magit-mode-quit-window nil)
  (fullframe magit-show-commit magit-mode-bury-buffer nil))

(use-package smartparens
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook 'turn-on-smartparens-strict-mode))

(use-package org-brain
  :ensure t)

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

;; Functions
(defun kill-char-or-word ()
  (interactive)
  (cond
   ((looking-at (rx (char word)))
    (kill-word 1))
   ((looking-at (rx (char blank)))
    (forward-kill-whitespace))
   (t
    (delete-char 1))))

;; https://github.com/tarsius/killer/blob/ace0547944933440384ceeb5876b1f68c082d540/killer.el#L128
(defun forward-kill-whitespace ()
  "Kill all spaces and tabs after point."
  (interactive)
  (let ((orig-pos (point)))
    (kill-region (progn (skip-chars-forward " \t")
                        (constrain-to-field nil orig-pos))
                 orig-pos)))

;; Customizations
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-brain smartparens fullframe magit helm multiple-cursors comment-dwim-2 killer expand-region duplicate-thing eink-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
