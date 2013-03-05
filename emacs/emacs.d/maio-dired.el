(require 'dired)
(require 'dash)

(evil-define-key 'normal dired-mode-map (kbd "K") 'dired-do-delete)

(provide 'maio-dired)
