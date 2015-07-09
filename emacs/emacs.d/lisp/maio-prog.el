(require 's)

(setq flycheck-display-errors-delay 0.1)

(global-subword-mode 1)

(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.mustache$" . mustache-mode))

(with-eval-after-load "mustache-mode"
  (add-hook 'mustache-mode-hook 'maio/run-prog-mode-hook))

(with-eval-after-load "feature-mode"
  (add-hook 'feature-mode-hook 'flyspell-mode))

(require 'smartparens)
(require 'smartparens-config)
(setq sp-highlight-pair-overlay nil
      sp-highlight-wrap-overlay nil
      sp-highlight-wrap-tag-overlay nil)
(setq-default sp-autoskip-closing-pair 'always)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)
(add-hook 'prog-mode-hook 'turn-on-smartparens-mode)
(add-hook 'prog-mode-hook 'idle-highlight-mode)
(add-hook 'html-mode-hook 'turn-on-smartparens-mode)
(add-hook 'groovy-mode-hook 'turn-on-smartparens-mode)

(defun maio-narrow-to-defun-clone ()
  (interactive)
  (message (which-function))
  (clone-indirect-buffer (which-function) t)
  (narrow-to-defun))

(setq show-paren-delay 0)
(show-paren-mode 1)

(setq whitespace-action '(auto-cleanup))
(setq whitespace-style '(face trailing lines-tail) whitespace-line-column 80)
(whitespace-mode)

(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))

  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

(setq ediff-split-window-function 'split-window-horizontally)

(provide 'maio-prog)
