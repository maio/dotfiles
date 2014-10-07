;; Shell
(require 'eshell)
(setq ansi-color-for-comint-mode t)
(setq comint-prompt-read-only t)
(setq eshell-cmpl-ignore-case t)

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

(defun maio/setup-eshell ()
  (define-key eshell-mode-map (kbd "M-.") 'maio/insert-last-argument)
  (set-face-attribute 'eshell-prompt nil :foreground "black" :weight 'bold)
  (evil-define-key 'normal eshell-mode-map (kbd "RET") 'eshell-send-input)
  (evil-define-key 'normal eshell-mode-map "H" 'eshell-bol)
  (evil-define-key 'normal eshell-mode-map "L" 'move-end-of-line))

(add-hook 'eshell-mode-hook 'maio/setup-eshell)

(defun maio/ansi-term ()
  (interactive)
  (ansi-term "/usr/local/bin/bash"))

(require 'eyebrowse)
(defadvice term-sentinel (around auto-close-term-buffer-window (proc msg) activate)
  (if (memq (process-status proc) '(signal exit))
      (let ((buffer (process-buffer proc)))
        ad-do-it
        (kill-buffer buffer)
        (if (window-parent)
            (delete-window)
          (when eyebrowse-mode (eyebrowse-close-window-config))))
    ad-do-it))

(defun term-char-mode-refocus ()
  (interactive)
  (term-char-mode)
  ;; move cursor to real position as seen by terminal char mode
  (term-send-raw-string ""))

(defun term-clear-buffer ()
  (interactive)
  (clear-comint-buffer)
  ;; without C-l it breaks sometimes (only one line is visible)
  (term-send-raw-string (kbd "C-l")))

(with-eval-after-load 'term
  (defadvice term-line-mode (after evil-normal-state () activate) (evil-normal-state))
  (defadvice term-char-mode (after evil-emacs-state () activate) (evil-emacs-state))
  (evil-define-key 'normal term-mode-map "i" 'term-char-mode-refocus)
  (evil-define-key 'normal term-mode-map [escape] 'term-char-mode-refocus)
  (evil-define-key 'emacs term-raw-map [escape] 'term-line-mode)
  (define-key term-raw-escape-map (kbd "C-y") 'term-paste)
  (define-key term-raw-map (kbd "s-v") 'term-paste)
  (define-key term-raw-map (kbd "s-l") 'term-clear-buffer))

(provide 'maio-shell)
