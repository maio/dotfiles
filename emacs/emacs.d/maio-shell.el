;; Shell
(setq eshell-scroll-to-bottom-on-output t)
(setq ansi-color-for-comint-mode t)
(setq comint-prompt-read-only nil)

(setenv "PATH"
        (concat "/opt/local/bin:/opt/perl/bin:/usr/local/bin:"
                (getenv "PATH")))

(provide 'maio-shell)
