(require 'dired)
(require 'wdired)

(evil-define-key 'normal dired-mode-map "K" 'dired-do-delete)
(key-chord-define wdired-mode-map ";w" 'wdired-finish-edit)

(provide 'maio-dired)
