(use-package helm-projectile
  :defer t
  :config
  (setq projectile-enable-caching t)
  (global-set-key (kbd "s-t") 'helm-projectile))

(provide 'maio-projectile)
