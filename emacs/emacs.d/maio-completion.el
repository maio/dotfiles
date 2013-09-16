(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(setq-default ac-sources
              '(ac-source-yasnippet
                ac-source-abbrev
                ac-source-dictionary
                ac-source-words-in-same-mode-buffers))

(setq ac-ignore-case nil)
(setq ac-use-menu-map t)
(setq ac-auto-start 3)
(setq ac-auto-show-menu nil)
(setq ac-quick-help-delay 1)
(setq ac-dwim t)

(define-key ac-completing-map "\r" nil)
(define-key ac-completing-map [return] nil)

(add-hook 'comint-mode-hook 'auto-complete-mode)

(provide 'maio-completion)
