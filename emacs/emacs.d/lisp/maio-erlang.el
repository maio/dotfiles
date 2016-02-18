(require 'maio-util)

(use-package erlang
  :defer t
  :config
  (message "ERLANG")
  (ensure-package 'smartparens)
  (ensure-package 'flycheck)
  (require 'erlang-eunit)

  (add-to-list 'auto-mode-alist '("rebar\\.config\\'" . erlang-mode))
  (add-hook 'erlang-mode-hook 'turn-on-smartparens-mode)
  (add-hook 'erlang-mode-hook 'flycheck-mode)
  (add-hook 'erlang-mode-hook 'maio/run-prog-mode-hook)
  (add-hook 'erlang-shell-mode-hook 'turn-on-smartparens-mode)
  (define-key erlang-mode-map (kbd "C-c C-c") 'erlang-eunit-compile-and-run-module-tests)
  (define-key erlang-mode-map (kbd "s-s") 'erlang-eunit-compile-and-run-module-tests)
  (define-key erlang-mode-map (kbd "C-j") 'newline-and-indent)
  (define-key erlang-mode-map (kbd "M-r") 'raise-exp)
  (define-key erlang-mode-map (kbd "C-x m t") 'erlang-eunit-compile-and-run-module-tests)
  (when evil-mode
    (evil-define-key 'normal erlang-mode-map "gs" 'erlang-shell-display)
    (evil-define-key 'normal erlang-mode-map "K" 'erlang-man-function))

  (with-eval-after-load 'smartparens
    (sp-with-modes '(erlang-mode) (sp-local-pair "<<\"" "\">>"))))

(provide 'maio-erlang)
