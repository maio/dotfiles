(with-eval-after-load 'dired
  (when evil-mode
    (evil-define-key 'normal dired-mode-map "K" 'dired-do-delete)))

(use-package dired-subtree
  :defer t
  :config
  (setq dired-subtree-use-backgrounds nil)
  (define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(provide 'maio-dired)
