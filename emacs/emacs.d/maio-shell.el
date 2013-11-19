;; Shell
(require 'term)
(require 'shell)
(setq ansi-color-for-comint-mode t)
(setq comint-prompt-read-only t)
(setq eshell-cmpl-ignore-case t)

(require 'shell-switcher)
(shell-switcher-mode)

(setenv "PATH"
        (concat "/opt/local/bin:/opt/perl/bin:/usr/local/bin:"
                (getenv "PATH")))

(defun maio/term-enter ()
  (interactive)
  (goto-char (point-max))
  (evil-insert-state))

(defun eshell/clear ()
  "04Dec2001 - sailor, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(evil-define-key 'normal term-raw-map "i" 'maio/term-enter)
(evil-define-key 'normal term-raw-map [return] 'maio/term-enter)

(add-hook 'shell-mode-hook 'font-lock-mode)
(add-hook 'term-mode-hook 'font-lock-mode)

(provide 'maio-shell)
