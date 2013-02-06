(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; make multiple cursors (kind of) work with evil

(defadvice mc/mark-next-like-this (before force-emacs-mode () activate)
  (when (not (evil-emacs-state-p)) (evil-emacs-state)))

(defadvice evil-emacs-state (around preserve-visual-selection () activate)
  (if (evil-visual-state-p)
      (progn
        ad-do-it
        (transient-mark-mode t)
        (exchange-point-and-mark)
        (exchange-point-and-mark))
    ad-do-it))

(add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state)

(provide 'maio-multiple-cursors)
