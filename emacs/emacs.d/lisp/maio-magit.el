(setq magit-status-buffer-switch-function 'switch-to-buffer
      magit-diff-refine-hunk t
      magit-repository-directories-depth 2)

(with-eval-after-load 'magit
  (magit-auto-revert-mode 0)
  (define-key magit-status-mode-map (kbd "C-c M-j") 'cider-jack-in)
  (delete 'magit-insert-tags-header magit-status-headers-hook)
  (add-hook 'with-editor-mode-hook 'flyspell-mode)
  (add-hook 'with-editor-mode-hook 'evil-insert-state)
  (add-to-list 'magit-repository-directories (concat "/Users/" (getenv "USER") "/Projects/"))
  (add-to-list 'magit-diff-arguments "--patience")
  (add-to-list 'magit-no-confirm 'stage-all-changes))

(require 'magit)

(fullframe magit-status magit-mode-quit-window)
(fullframe magit-log magit-mode-quit-window)
(fullframe magit-show-commit magit-mode-quit-window)

(defadvice magit-section-toggle (after scroll-line-to-top () activate)
  (recenter 0))

(when evil-mode
  (define-key evil-normal-state-map (kbd "gl") 'magit-log-buffer-file))

(provide 'maio-magit)
