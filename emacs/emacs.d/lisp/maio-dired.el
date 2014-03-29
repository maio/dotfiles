(with-eval-after-load 'dired
  (evil-define-key 'normal dired-mode-map "K" 'dired-do-delete))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(provide 'maio-dired)
