(require 's)
(require 'maio-util)

(setq flycheck-display-errors-delay 0.1
      ediff-split-window-function 'split-window-horizontally)

(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.mustache$" . mustache-mode))
(add-to-list 'auto-mode-alist '("\\.sls$" . yaml-mode))

(add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)

(use-package subword
  :defer 1
  :config
  (global-subword-mode 1))

(use-package paren
  :defer 1
  :config
  (setq show-paren-delay 0)
  (show-paren-mode 1))

(use-package nlinum-relative
  :defer 1)

(use-package whitespace
  :defer 1
  :config
  (setq whitespace-action '(auto-cleanup))
  (setq whitespace-style '(face trailing lines-tail) whitespace-line-column 80)
  (whitespace-mode))

(use-package compile
  :defer t
  :config
  (ignore-errors
    (require 'ansi-color)
    (defun my-colorize-compilation-buffer ()
      (when (eq major-mode 'compilation-mode)
        (ansi-color-apply-on-region compilation-filter-start (point-max))))

    (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer)))

(use-package mustache-mode
  :defer t
  :config
  (add-hook 'mustache-mode-hook 'maio/run-prog-mode-hook))

(use-package feature-mode
  :defer t
  :config
  (add-hook 'feature-mode-hook 'flyspell-mode))

(use-package smartparens
  :defer 1
  :config
  (require 'smartparens-config)
  (setq sp-highlight-pair-overlay nil
        sp-highlight-wrap-overlay nil
        sp-highlight-wrap-tag-overlay nil)
  (setq-default sp-autoskip-closing-pair 'always)
  (add-hook 'prog-mode-hook 'turn-on-smartparens-mode)
  (add-hook 'html-mode-hook 'turn-on-smartparens-mode)
  (add-hook 'groovy-mode-hook 'turn-on-smartparens-mode)
  (when evil-mode
    (defadvice sp-down-sexp (before evil-jumps activate) (evil-set-jump))
    (defadvice sp-backward-up-sexp (before evil-jumps activate) (evil-set-jump))
    (defadvice sp-next-sexp (before evil-jumps activate) (evil-set-jump))
    (defadvice sp-backward-sexp (before evil-jumps activate) (evil-set-jump))))

(use-package idle-highlight-mode
  :defer 1
  :config
  (idle-highlight-mode 1)
  (add-hook 'prog-mode-hook 'idle-highlight-mode))

(add-hook 'prog-mode-hook 'show-trailing-whitespace)

(use-package flycheck
  :defer t
  :config
  (flycheck-package-setup))

(use-package flycheck-package
  :defer t)

(use-package yasnippet
  :defer 1
  :config
  (yas-global-mode 1))

(provide 'maio-prog)
