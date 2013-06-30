(require 'auto-complete)
(require 'smartparens)

(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))

(eval-after-load 'js2-mode
  '(progn
     (add-hook 'js2-mode-hook 'smartparens-mode)
     (add-hook 'js2-mode-hook 'auto-complete-mode)
     (key-chord-define js2-mode-map ";;" 'maio/electric-semicolon)))

(provide 'maio-javascript)
