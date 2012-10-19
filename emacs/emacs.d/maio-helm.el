(setq helm-su-or-sudo "sudo"
      helm-allow-skipping-current-buffer nil
      helm-M-x-requires-pattern 0
      helm-ff-transformer-show-only-basename nil
      helm-buffer-max-length 40)

(add-to-list 'load-path "~/.emacs.d/helm")
(require 'helm-config)
(require 'helm-match-plugin)
(helm-mode 0)
(require 'maio-helm-git)

(provide 'maio-helm)
