;; Shell
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

(defun maio/setup-eshell ()
  (define-key eshell-mode-map (kbd "M-.") 'maio/insert-last-argument)
  (evil-define-key 'normal eshell-mode-map (kbd "RET") 'eshell-send-input)
  (evil-define-key 'normal eshell-mode-map "H" 'eshell-bol)
  (evil-define-key 'normal eshell-mode-map "L" 'move-end-of-line))

(set-face-attribute 'eshell-prompt nil :foreground "red" :weight 'bold)
(add-hook 'eshell-mode-hook 'maio/setup-eshell)

(require 'maio-shell-completion)
(provide 'maio-shell)