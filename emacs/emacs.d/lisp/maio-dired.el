(eval-after-load 'dired
  '(evil-define-key 'normal dired-mode-map "K" 'dired-do-delete))
(eval-after-load 'wdired
  '(key-chord-define wdired-mode-map ";w" 'wdired-finish-edit))

(provide 'maio-dired)
