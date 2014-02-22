(require 'maio-util)

(defun my-add-space-after-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (insert "  ")
    (left-char 1)))

(eval-after-load 'compile
  '(pushnew '(erlang "(\\([^ \n]+\\), line \\([0-9]+\\))" 1 2) compilation-error-regexp-alist-alist))

(eval-after-load 'erlang
  '(progn
     (require 'erlang-eunit)
     (add-to-list 'auto-mode-alist '("rebar\\.config\\'" . erlang-mode))
     (add-hook 'erlang-mode-hook 'turn-on-smartparens-mode)
     (add-hook 'erlang-mode-hook 'maio/setup-tab-indent)
     (add-hook 'erlang-mode-hook 'turn-on-sackspace)
     (add-hook 'erlang-mode-hook 'flycheck-mode)
     (add-hook 'erlang-mode-hook 'maio/run-prog-mode-hook)
     (add-hook 'erlang-shell-mode-hook 'turn-on-smartparens-mode)
     (define-key erlang-mode-map (kbd "M-r") 'raise-exp)
     (define-key erlang-mode-map (kbd "C-x m t") 'erlang-eunit-compile-and-run-module-tests)
     (sp-local-pair 'erlang-mode "(" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-local-pair 'erlang-mode "{" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-local-pair 'erlang-mode "[" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-with-modes '(erlang-mode)
       (sp-local-pair "<" ">"))))

(provide 'maio-erlang)
