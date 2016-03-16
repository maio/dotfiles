(setq magit-status-buffer-switch-function 'switch-to-buffer
      magit-diff-refine-hunk t
      magit-revert-buffers nil
      magit-repository-directories-depth 2)

(with-eval-after-load 'magit
  (magit-auto-revert-mode 0)
  (delete 'magit-insert-tags-header magit-status-headers-hook)
  (add-hook 'with-editor-mode-hook 'flyspell-mode)
  (add-to-list 'magit-repository-directories "/Users/maio/Projects/")
  (add-to-list 'magit-diff-arguments "--patience")
  (add-to-list 'magit-no-confirm 'stage-all-changes))

(require 'magit)

(fullframe magit-status magit-mode-quit-window)
(fullframe magit-log magit-mode-quit-window)

(defun maio-git-reset-master-to-origin ()
  (interactive)
  (magit-run-git "fetch" "origin")
  (magit-run-git "pull" "." "origin/master:master"))

(defun maio-git-reset-hard-origin-master ()
  (interactive)
  (magit-fetch "origin")
  (when (yes-or-no-p "Discard all uncommitted changes?")
    (magit-reset-hard "origin/master")))

(defadvice magit-section-toggle (after scroll-line-to-top () activate)
  (recenter 0))

(when evil-mode
  (define-key evil-normal-state-map (kbd "gl") 'magit-log-buffer-file))

(provide 'maio-magit)
