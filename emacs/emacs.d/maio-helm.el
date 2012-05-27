(setq helm-su-or-sudo "sudo"
      helm-allow-skipping-current-buffer nil
      helm-M-x-requires-pattern 0
      helm-ff-transformer-show-only-basename nil)

(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)
(require 'helm-match-plugin)
(helm-mode 1)
(add-to-list 'load-path "~/.emacs.d/projectile")
(require 'helm-projectile)
(require 'maio-helm-git)

(provide 'maio-helm)
