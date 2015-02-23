(require 'multiple-cursors)

(when evil-mode
  (defadvice mc/mark-all-like-this-dwim (before emacs-state () activate)
    (evil-emacs-state))

  (add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state)
  (define-key mc/keymap [escape] 'mc/keyboard-quit)
  (define-key evil-normal-state-map (kbd "M-;") 'mc/mark-all-like-this-dwim)
  (define-key evil-insert-state-map (kbd "M-;") 'mc/mark-all-like-this-dwim))

(provide 'maio-multiple-cursors)
