;; Shell
(require 'term)
(require 'shell)
(require 'eshell)
(setq ansi-color-for-comint-mode t)
(setq comint-prompt-read-only t)
(setq eshell-cmpl-ignore-case t)

(require 'shell-switcher)
(shell-switcher-mode)

(setenv "PATH"
        (concat "/opt/local/bin:/opt/perl/bin:/usr/local/bin:"
                (getenv "PATH")))

(defun maio/insert-last-argument ()
  (interactive)
  (insert (first (last eshell-last-arguments))))

(defun maio/term-enter ()
  (interactive)
  (goto-char (point-max))
  (evil-insert-state))

(defun eshell/clear ()
  "04Dec2001 - sailor, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun eshell/serve ()
  (interactive)
  (start-process "serve" (format "*serve %s*" default-directory) "python" "-m" "SimpleHTTPServer")
  (browse-url "http://localhost:8000/")
  "Server started at http://localhost:8000/")

(defun eshell/rr (&rest commands)
  (interactive)
  (save-window-excursion
    (let ((max-mini-window-height 0))
      (with-output-to-string (shell-command (s-join " " commands) standard-output)))))

(evil-define-key 'normal term-raw-map "i" 'maio/term-enter)
(evil-define-key 'normal term-raw-map [return] 'maio/term-enter)

(defun maio/setup-eshell ()
  (define-key eshell-mode-map (kbd "M-.") 'maio/insert-last-argument)
  (evil-define-key 'normal eshell-mode-map (kbd "RET") 'eshell-send-input))

(defadvice eshell-send-input (after evil-normal-state () activate)
  (evil-normal-state))

(add-hook 'shell-mode-hook 'font-lock-mode)
(add-hook 'term-mode-hook 'font-lock-mode)
(set-face-attribute 'eshell-prompt nil :foreground "red" :weight 'bold)
(add-hook 'eshell-mode-hook 'maio/setup-eshell)

(require 'maio-shell-completion)
(provide 'maio-shell)
