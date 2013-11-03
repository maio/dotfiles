(eval-after-load 'auto-complete
  '(progn
     (add-to-list 'ac-modes 'erlang-mode)
     (add-to-list 'ac-modes 'erlang-shell-mode)))

(eval-after-load 'erlang
  '(progn
     (add-hook 'erlang-mode-hook 'flycheck-mode)
     (add-hook 'erlang-mode-hook 'turn-on-smartparens-mode)
     (add-hook 'erlang-shell-mode-hook 'turn-on-smartparens-mode)
     (sp-with-modes '(erlang-mode)
       (sp-local-pair "<" ">"))))

(provide 'maio-erlang)
