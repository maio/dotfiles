(setq js3-auto-indent-p t)
(setq js3-enter-indents-newline t)
(setq js3-indent-on-enter-key t)

(eval-after-load 'js3-mode
  '(progn
     (add-hook 'js3-mode-hook 'autopair-on)
     (add-hook 'js3-mode-hook 'auto-complete-mode)
     (key-chord-define js3-mode-map ";;" 'maio/electric-semicolon)))

(provide 'maio-javascript)
