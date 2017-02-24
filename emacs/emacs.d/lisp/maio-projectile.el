(use-package helm-projectile
  :defer t
  :config
  (setq projectile-enable-caching t
        projectile-switch-project-action 'magit-status)
  (global-set-key (kbd "s-t") 'helm-projectile))

(provide 'maio-projectile)
