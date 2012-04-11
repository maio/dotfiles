;; Shell
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

(provide 'maio-shell)
