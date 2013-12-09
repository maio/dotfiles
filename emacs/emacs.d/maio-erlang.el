(require 'sackspace)

(eval-after-load 'auto-complete
  '(progn
     (add-to-list 'ac-modes 'erlang-mode)
     (add-to-list 'ac-modes 'erlang-shell-mode)))

(defun my-add-space-after-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (insert "  ")
    (left-char 1)))

(eval-after-load 'erlang
  '(progn
     (add-to-list 'auto-mode-alist '("rebar\\.config\\'" . erlang-mode))
     (add-hook 'erlang-mode-hook 'turn-on-smartparens-mode)
     (add-hook 'erlang-mode-hook 'idle-highlight-mode)
     (add-hook 'erlang-mode-hook 'maio/setup-tab-indent)
     (add-hook 'erlang-mode-hook 'turn-on-sackspace)
     (add-hook 'erlang-mode-hook 'flycheck-mode)
     (add-hook 'erlang-shell-mode-hook 'turn-on-smartparens-mode)
     (sp-local-pair 'erlang-mode "(" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-local-pair 'erlang-mode "{" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-local-pair 'erlang-mode "[" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-with-modes '(erlang-mode)
       (sp-local-pair "<" ">"))))

(provide 'maio-erlang)
