(add-hook 'clojure-mode-hook 'eldoc-mode)
(add-hook 'nrepl-mode-hook 'autopair-on)

(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(provide 'maio-clojure)
