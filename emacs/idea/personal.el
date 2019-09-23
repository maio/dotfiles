(use-package clojure-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.joke\\'" . clojure-mode)))

(use-package dired-subtree
  :ensure t
  :config
  (setq dired-subtree-use-backgrounds nil
	dired-subtree-cycle-depth 3)
  (define-key dired-mode-map (kbd "TAB") 'dired-subtree-toggle)
  (add-hook 'dired-mode-hook 'dired-hide-details-mode))

