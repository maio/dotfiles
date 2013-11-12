(require 'sackspace)

(eval-after-load 'auto-complete
  '(progn
     (add-to-list 'ac-modes 'erlang-mode)
     (add-to-list 'ac-modes 'erlang-shell-mode)))

(defun maio/erlang-indent-work ()
  (turn-on-sackspace)
  (setq indent-tabs-mode t)
  (setq indent-line-function 'tab-to-tab-stop)
  (let ((my-tab-width 4))
    (setq tab-width my-tab-width)
    (set (make-local-variable 'tab-stop-list)
         (number-sequence my-tab-width 200 my-tab-width))))

(defun my-add-space-after-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (insert "  ")
    (left-char 1)))

(eval-after-load 'erlang
  '(progn
     (add-to-list 'auto-mode-alist '("rebar\\.config\\'" . erlang-mode))
     (add-hook 'erlang-mode-hook 'turn-on-smartparens-mode)
     (add-hook 'erlang-mode-hook 'idle-highlight-mode)
     (add-hook 'erlang-mode-hook 'maio/erlang-indent-work)
     (add-hook 'erlang-shell-mode-hook 'turn-on-smartparens-mode)
     (sp-local-pair 'erlang-mode "(" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-local-pair 'erlang-mode "{" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-local-pair 'erlang-mode "[" nil :post-handlers '(:add my-add-space-after-sexp-insertion))
     (sp-with-modes '(erlang-mode)
       (sp-local-pair "<" ">"))))

(provide 'maio-erlang)
