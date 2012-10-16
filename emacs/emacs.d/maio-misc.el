(add-to-list 'exec-path "/opt/local/bin")
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
(when (system-type-is-gnu)
  (setq x-select-enable-clipboard t)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))
(setq require-final-newline nil)

(setq extended-command-history
      (list "helm-do-grep"
            "recompile-my-files"
            "magit-blame-mode"))

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

;; enable copy/paste in terminal
(unless window-system
  (when (getenv "DISPLAY")
    (defun xsel-cut-function (text &optional push)
      (with-temp-buffer
        (insert text)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    (defun xsel-paste-function ()
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output)))
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)))

(provide 'maio-misc)
