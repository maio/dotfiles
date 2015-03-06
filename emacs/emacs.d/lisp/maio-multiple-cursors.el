(require 'multiple-cursors)

(when evil-mode
  (defun mc/restore-normal-state ()
    (message "OUT")
    (evil-force-normal-state)
    (remove-hook 'multiple-cursors-mode-disabled-hook 'mc/restore-normal-state))

  (defun mc/insert-state ()
    (message "IN")
    ;; (deactivate-mark)
    (when (evil-normal-state-p)
      (add-hook 'multiple-cursors-mode-disabled-hook 'mc/restore-normal-state)
      (evil-insert-state)))

  (add-hook 'multiple-cursors-mode-enabled-hook 'mc/insert-state)
  (add-hook 'multiple-cursors-mode-disabled-hook 'deactivate-mark)

  (define-key mc/keymap [escape] 'mc/keyboard-quit)
  (define-key evil-normal-state-map (kbd "M-;") 'mc/mark-all-like-this-dwim)
  (define-key evil-insert-state-map (kbd "M-;") 'mc/mark-all-like-this-dwim))

(provide 'maio-multiple-cursors)
