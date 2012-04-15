(require 'maio-leader)

(setq maio/leader-action-alist
      '((?w . force-save-buffer)
        (?, . other-buffer-or-window)
        (?b . helm-mini)
        (?k . kill-current-buffer)
        (?t . helm-c-etags-select)
        (?f . helm-git)
        (?r . helm-resume)
        (?v . edit-init)
        (?e . my-eval-defun)
        (?a . ack-and-a-half)
        (?1 . delete-other-windows)
        (?g . magit-status)))

(global-set-key (kbd "M-x") 'helm-M-x)

(provide 'maio-keys)
