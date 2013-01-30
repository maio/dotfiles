(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(setq ac-ignore-case nil)
(setq ac-use-menu-map t)
(setq ac-auto-start 5)
(setq ac-quick-help-delay 1)

(provide 'maio-completion)
