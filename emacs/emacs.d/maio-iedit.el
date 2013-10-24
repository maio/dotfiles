(setq iedit-toggle-key-default (kbd "M-;"))

(require 'iedit)

(define-key evil-normal-state-map iedit-toggle-key-default 'iedit-mode)

(provide 'maio-iedit)
