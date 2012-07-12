;; Shell
(require 'term)
(setq eshell-scroll-to-bottom-on-output t)
(setq ansi-color-for-comint-mode t)
(setq comint-prompt-read-only nil)
(setq eshell-glob-case-insensitive t)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (define-key eshell-mode-map [remap pcomplete] 'helm-esh-pcomplete)))

(setenv "PATH"
        (concat "/opt/local/bin:/opt/perl/bin:/usr/local/bin:"
                (getenv "PATH")))

(define-key term-raw-map escreen-prefix-char escreen-map)

(defun maio/term-enter ()
  (interactive)
  (call-interactively 'evil-goto-line)
  (call-interactively 'end-of-line)
  (evil-emacs-state))

(evil-define-key 'normal term-raw-map (kbd "i") 'maio/term-enter)
(evil-define-key 'normal term-raw-map (kbd "RET") 'maio/term-enter)

(provide 'maio-shell)
