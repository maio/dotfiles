(setq helm-candidate-number-limit 25
      helm-su-or-sudo "sudo"
      helm-allow-skipping-current-buffer nil
      helm-enable-shortcuts t)
(setq helm-mp-matching-method 'multi2)

(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)
(require 'helm-match-plugin)
(helm-mode 1)
(add-to-list 'load-path "~/.emacs.d/projectile")
(require 'helm-projectile)

(provide 'maio-helm)
