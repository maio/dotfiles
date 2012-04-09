(setq helm-idle-delay 0.3
      helm-quick-update t
      helm-candidate-number-limit 25
      helm-su-or-sudo "sudo"
      helm-allow-skipping-current-buffer nil)
(setq helm-mp-matching-method 'multi2)
(setq helm-M-x-requires-pattern 0)

(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)
(require 'helm-match-plugin)
(helm-mode 1)
(add-to-list 'load-path "~/.emacs.d/projectile")
(require 'helm-projectile)

(provide 'maio-helm)
