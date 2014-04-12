(setq magit-rewrite-inclusive nil
      magit-status-buffer-switch-function 'switch-to-buffer
      magit-diff-refine-hunk t
      magit-stage-all-confirm nil
      magit-default-tracking-name-function 'magit-default-tracking-name-branch-only)

(require 'maio-magit-notes)
(require 'magit)
(require 'git-rebase-mode)
(require 'git-commit-mode)

;; TODO: remove magit-insert-status-tags-line from magit-status-sections-hook

(defun maio-git-backup ()
  (interactive)
  (magit-git-command "tag -f backup" default-directory))

(defun maio-git-restore ()
  (interactive)
  (magit-reset-head-hard "backup"))

(defun maio-git-reset-hard-tracking ()
  (interactive)
  (when (yes-or-no-p "Discard all uncommitted changes?")
    (magit-reset-head-hard
     (magit-get-tracked-branch (magit-get-current-branch)))))

(defun maio-git-reset-hard-upstream-master ()
  (interactive)
  (magit-fetch "upstream")
  (when (yes-or-no-p "Discard all uncommitted changes?")
    (magit-reset-head-hard "upstream/master")))

(defadvice magit-toggle-section (after scroll-line-to-top () activate)
  (call-interactively 'evil-scroll-line-to-top))

(define-key magit-status-mode-map "G" 'magit-shell-command)
(add-hook 'git-commit-mode-hook 'flyspell-mode)
(add-hook 'git-commit-mode-hook 'turn-on-smartparens-mode)

(defun magit-blame-kill-commit-id (pos)
  (interactive "d")
  (let* ((chunk (get-text-property pos :blame))
         (commit-info (nth 3 chunk))
         (commit (plist-get commit-info :sha1)))
    (kill-new commit)
    (message commit)))

(with-eval-after-load 'magit-blame
  (define-key magit-blame-map (kbd "C-w") 'magit-blame-kill-commit-id)

  (defadvice magit-blame-mode (after evil-state () activate)
    (if magit-blame-mode
        (evil-emacs-state)
      (evil-normal-state))))

(provide 'maio-magit)
