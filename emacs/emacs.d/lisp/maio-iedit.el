(setq iedit-toggle-key-default (kbd "M-;"))

(require 'iedit)

(when evil-mode
  (define-key evil-normal-state-map iedit-toggle-key-default 'iedit-mode))

(provide 'maio-iedit)
