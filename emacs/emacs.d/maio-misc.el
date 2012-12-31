(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "~/bin")
(setenv "PATH" (concat "~/bin" ":" (getenv "PATH")))
(set-face-attribute 'default nil :height 150)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)
(global-auto-revert-mode 1)
(setq fill-column 80)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(column-number-mode 1)
(idle-highlight-mode 1)
(setq ring-bell-function 'ignore)
(setq split-height-threshold nil)
(setq ido-use-filename-at-point nil)
(setq autopair-blink nil)
(setq require-final-newline nil)
(setq next-line-add-newlines nil)
(setq tramp-verbose 2)

(setq extended-command-history
;; (setq debug-on-quit t)
;; (setq debug-on-error t)

      (list "customize-group"
            "maio/compile-in-git-root"
            "maio/copy-file-name-to-clipboard"
            "magit-blame-mode"
            "kill-all-buffers"))

(put 'narrow-to-region 'disabled nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
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
