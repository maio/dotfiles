(require 'dired)
(require 'dash)

;; Make dired less verbose
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)

(evil-define-key 'normal dired-mode-map (kbd "K") 'dired-do-delete)

(provide 'maio-dired)
