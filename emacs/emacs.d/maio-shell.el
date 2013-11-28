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

(evil-define-key 'normal term-raw-map "i" 'maio/term-enter)
(evil-define-key 'normal term-raw-map [return] 'maio/term-enter)

(defun maio/setup-eshell ()
  (define-key eshell-mode-map [remap eshell-pcomplete] 'helm-esh-pcomplete)
  (define-key eshell-mode-map (kbd "M-.") 'maio/insert-last-argument))

(add-hook 'shell-mode-hook 'font-lock-mode)
(add-hook 'term-mode-hook 'font-lock-mode)
(set-face-attribute 'eshell-prompt nil :foreground "red" :weight 'bold)
(add-hook 'eshell-mode-hook 'maio/setup-eshell)

(provide 'maio-shell)
