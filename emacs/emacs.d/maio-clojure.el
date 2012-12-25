(add-hook 'clojure-mode-hook 'eldoc-mode)
(add-hook 'nrepl-mode-hook 'autopair-on)

(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(evil-define-key 'normal nrepl-mode-map (kbd "RET") 'nrepl-return)
(defadvice nrepl-return (after normal-state () activate) (evil-normal-state))
(evil-define-key 'normal nrepl-mode-map (kbd "(")
  (lambda () (interactive) (insert "(") (evil-insert-state)))

(provide 'maio-clojure)
