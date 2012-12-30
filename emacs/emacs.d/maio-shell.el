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

(defun maio/term-enter ()
  (interactive)
  (goto-char (point-max))
  (evil-insert-state))

(evil-define-key 'normal term-raw-map (kbd "i") 'maio/term-enter)
(evil-define-key 'normal term-raw-map [return] 'maio/term-enter)

;; for some weird reason it needs to be in hook
(add-hook 'eshell-mode-hook
          '(lambda ()
             (evil-define-key 'normal eshell-mode-map [return] 'maio/term-enter)
             (custom-set-faces
              '(eshell-prompt ((t (:foreground "dark gray" :weight bold)))))))

(provide 'maio-shell)
