(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))

(eval-after-load 'js2-mode
  '(progn
     (require 'auto-complete)
     (require 'smartparens)
     (add-hook 'js2-mode-hook 'smartparens-mode)
     (add-hook 'js2-mode-hook 'auto-complete-mode)))

(provide 'maio-javascript)
