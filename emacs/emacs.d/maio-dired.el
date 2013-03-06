(require 'dired)
(require 'wdired)

(evil-define-key 'normal dired-mode-map (kbd "K") 'dired-do-delete)
(key-chord-define wdired-mode-map (kbd ";w") 'wdired-finish-edit)

(provide 'maio-dired)
