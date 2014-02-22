(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))

(eval-after-load 'js2-mode
  '(progn
     (require 'smartparens)
     (add-hook 'js2-mode-hook 'smartparens-mode)))

(provide 'maio-javascript)
