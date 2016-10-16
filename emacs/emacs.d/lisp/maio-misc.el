(defalias 'yes-or-no-p 'y-or-n-p)

(setenv "RLWRAP" "")
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)
(global-auto-revert-mode 1)
(setq undo-limit 800000)
(setq fill-column 80)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq standard-indent 4)
(setq tab-width 4)
(setq yaml-indent-offset 2)
(setq-default indent-tabs-mode nil)
(setq-default cursor-in-non-selected-windows nil)
(setq-default line-spacing 0)
(column-number-mode 1)
(setq tramp-default-method "sshx")
(setq ring-bell-function 'ignore)
(setq ido-use-filename-at-point nil)
(setq require-final-newline nil)
(setq next-line-add-newlines nil)
(setq recentf-max-saved-items 100)
(setq help-at-pt-display-when-idle t)
(setq-default compilation-scroll-output t)
(add-hook 'compilation-start-hook
          (lambda (process) (setq compilation-scroll-output t)))
(help-at-pt-set-timer)
(delete-selection-mode 1)
(setq shift-select-mode t)
(setq initial-scratch-message nil)
(setq blink-matching-paren nil)
(setq remember-notes-initial-major-mode 'org-mode)
(setq recenter-positions '(top middle bottom))

(defun maio/indent ()
  (setq indent-line-function 'indent-relative-maybe))
(add-hook 'text-mode-hook 'maio/indent)
(add-hook 'sql-mode-hook 'maio/indent)
(add-hook 'yaml-mode-hook (lambda () (setq indent-line-function 'yaml-indent-line)))

(use-package wgrep
  :init
  (setq wgrep-auto-save-buffer t)
  :defer 5
  :config
  (add-hook 'ag-mode-hook 'wgrep-ag-setup)
  (add-hook 'ag-mode-hook 'wgrep-change-to-wgrep-mode)
  (add-hook 'helm-ag-mode-hook 'wgrep-ag-setup)
  (add-hook 'helm-ag-mode-hook 'wgrep-change-to-wgrep-mode))

(use-package wgrep-ag
  :after wgrep)

(use-package fullframe
  :defer t)

(use-package htmlize
  :defer t)

;; (setq debug-on-quit t)
;; (setq debug-on-error t)

(put 'narrow-to-region 'disabled nil)
(setq mouse-wheel-follow-mouse 't)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq redisplay-dont-pause t
      scroll-margin 0
      scroll-step 1
      scroll-preserve-screen-position 1)

;; Use UTF-8 dammit
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; (hl-line-mode nil)

;; enable recentf mode (+ make it work with ido)
(use-package recentf
  :defer 1
  :config
  (setq ido-use-virtual-buffers t)
  (recentf-mode 1))

(use-package ido
  :commands (ido-switch-buffer)
  :defer 1
  :config
  (recentf-mode 1))

(provide 'maio-misc)
