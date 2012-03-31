(setq magit-rewrite-inclusive nil)
(setq magit-status-buffer-switch-function 'switch-to-buffer)

(eval-after-load "magit"
  '(define-key magit-log-edit-mode-map (leader "w") 'magit-log-edit-commit))

(provide 'maio-git)
