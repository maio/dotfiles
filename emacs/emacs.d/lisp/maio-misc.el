(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/bin")
(setenv "PATH" (concat "~/bin" ":" (getenv "PATH")))
(setenv "RLWRAP" "")
(setenv "PAGER" "cat")
(set-face-attribute 'default nil :height 150)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)
(global-auto-revert-mode 1)
(setq fill-column 80)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq standard-indent 4)
(setq tab-width 4)
(setq yaml-indent-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default truncate-lines t)
(setq-default cursor-in-non-selected-windows nil)
(column-number-mode 1)
(idle-highlight-mode 1)
(setq tramp-default-method "sshx")
(setq ring-bell-function 'ignore)
(setq split-height-threshold nil)
(setq ido-use-filename-at-point nil)
(setq require-final-newline nil)
(setq next-line-add-newlines nil)
(setq recentf-max-saved-items 100)
(setq truncate-lines t)
(setq gc-cons-threshold 20000000)
(setq help-at-pt-display-when-idle t)
(setq-default compilation-scroll-output t)
(add-hook 'compilation-start-hook
          (lambda (process) (setq compilation-scroll-output t)))
(help-at-pt-set-timer)

(defun maio/indent ()
  (setq indent-line-function 'indent-relative-maybe))
(add-hook 'text-mode-hook 'maio/indent)
(add-hook 'sql-mode-hook 'maio/indent)

;; (setq debug-on-quit t)
;; (setq debug-on-error t)

(put 'narrow-to-region 'disabled nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq scroll-step           1
      scroll-conservatively 10000)

;; Use UTF-8 dammit
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
(hl-line-mode nil)

(provide 'maio-misc)
