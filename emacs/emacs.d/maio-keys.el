(require 'maio-leader)

(setq maio/leader-action-alist
      '((?w . force-save-buffer)
        (?, . other-buffer-or-window)
        (?b . helm-mini)
        (?k . kill-current-buffer)
        (?t . helm-c-etags-select)
        (?f . helm-git-find-files)
        (?r . helm-resume)
        (?s . helm-occur)
        (?v . find-config-file)
        (?e . my-eval-defun)
        (?n . maio-narrow-to-defun-clone)
        (?a . ack-and-a-half)
        (?1 . delete-other-windows)
        (?g . magit-status)))

(global-set-key (kbd "M-x") 'helm-M-x)
(define-key evil-normal-state-map (kbd "RET") 'midje-check-fact)

(provide 'maio-keys)
