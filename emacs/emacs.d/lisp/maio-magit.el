(setq magit-rewrite-inclusive nil
      magit-status-buffer-switch-function 'switch-to-buffer
      magit-diff-refine-hunk t
      magit-stage-all-confirm nil
      magit-default-tracking-name-function 'magit-default-tracking-name-branch-only
      magit-process-connection-type 0
      magit-diff-options '("--patience"))

(require 'maio-magit-notes)
(require 'magit)
(require 'git-rebase-mode)
(require 'git-commit-mode)

;; no need for tags line
(remove-hook 'magit-status-sections-hook 'magit-insert-status-tags-line)

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

(add-hook 'git-commit-mode-hook 'flyspell-mode)
(add-hook 'git-commit-mode-hook 'turn-on-smartparens-mode)

(defun magit-blame-kill-commit-id (pos)
  (interactive "d")
  (let* ((chunk (get-text-property pos :blame))
         (commit-info (nth 3 chunk))
         (commit (plist-get commit-info :sha1)))
    (kill-new commit)
    (message commit)))

(defun magit-blame-mark-commit (pos)
  ;; mark commit - requires modification of magit-refresh-marked-commits-in-buffer
  ;;
  ;; equal doesn't work because commit is fully qualified here and
  ;; log uses abbreviations so it's required to use s-starts-with?
  (interactive "d")
  (let* ((chunk (get-text-property pos :blame))
         (commit-info (nth 3 chunk))
         (commit (plist-get commit-info :sha1)))
    (progn
      (setq magit-marked-commit commit)
      (magit-refresh-marked-commits))
    (message (concat "Marked " commit))))

(with-eval-after-load 'magit-blame
  (define-key magit-blame-map (kbd "C-w") 'magit-blame-kill-commit-id)
  (define-key magit-blame-map (kbd ".") 'magit-blame-mark-commit)

  (defadvice magit-blame-mode (after evil-state () activate)
    (if magit-blame-mode
        (progn
          (evil-emacs-state)
          (recenter))
      (evil-normal-state))))

(provide 'maio-magit)
