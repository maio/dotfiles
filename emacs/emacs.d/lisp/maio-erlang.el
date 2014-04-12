(require 'maio-util)
(ensure-package 'erlang)
(ensure-package 'smartparens)
(ensure-package 'sackspace)
(ensure-package 'flycheck)

(defun my-add-space-after-sexp-insertion (id action _context)
  (when (eq action 'insert)
    (insert "  ")
    (left-char 1)))

(with-eval-after-load 'compile
  (pushnew '(erlang "(\\([^ \n]+\\), line \\([0-9]+\\))" 1 2) compilation-error-regexp-alist-alist))

(defun setup-erlang-tab-indent ()
  (setq tab-width 4
        erlang-indent-level 4
        erlang-argument-indent 4
        erlang-indent-guard 4
        indent-tabs-mode t
        erlang-tab-always-indent t))

(defadvice erlang-compile (before save-buffer () activate)
  (when (buffer-modified-p) (save-buffer)))

(defadvice erlang-eunit-compile-and-run-module-tests (before save-buffer () activate)
  (when (buffer-modified-p) (save-buffer)))

(with-eval-after-load 'erlang
  (require 'erlang-eunit)
  (require 'smartparens)
  (add-to-list 'auto-mode-alist '("rebar\\.config\\'" . erlang-mode))
  (add-hook 'erlang-mode-hook 'turn-on-smartparens-mode)
  (add-hook 'erlang-mode-hook 'turn-on-sackspace)
  (add-hook 'erlang-mode-hook 'setup-erlang-tab-indent)
  (add-hook 'erlang-mode-hook 'flycheck-mode)
  (add-hook 'erlang-mode-hook 'yas-minor-mode-on)
  (add-hook 'erlang-mode-hook 'maio/run-prog-mode-hook)
  (add-hook 'erlang-shell-mode-hook 'turn-on-smartparens-mode)
  (define-key erlang-mode-map (kbd "C-c C-c") 'erlang-eunit-compile-and-run-module-tests)
  (define-key erlang-mode-map (kbd "M-r") 'raise-exp)
  (define-key erlang-mode-map (kbd "C-x m t") 'erlang-eunit-compile-and-run-module-tests)
  (evil-define-key 'normal erlang-mode-map "gs" 'erlang-shell-display)
  (define-key erlang-mode-map (kbd "SPC") 'maio/electric-space)
  (add-hook 'erlang-shell-mode-hook
            (lambda () (define-key erlang-shell-mode-map (kbd "SPC") 'maio/electric-space)))
  (sp-with-modes '(erlang-mode)
    (sp-local-pair "<" ">")))

(provide 'maio-erlang)
