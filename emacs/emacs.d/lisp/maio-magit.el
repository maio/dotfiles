(setq magit-rewrite-inclusive nil)
(setq magit-status-buffer-switch-function 'switch-to-buffer)
(setq magit-diff-refine-hunk t)
(setq magit-stage-all-confirm nil)

(require 'maio-magit-notes)
(require 'magit)
(require 'git-rebase-mode)
(require 'git-commit-mode)

;; magit fixes
(defun magit-copy-item-as-kill ()
  "Copy sha1 of commit at point into kill ring."
  (interactive)
  (magit-section-action (item info "copy")
    ((untracked file)
     (kill-new info))
    ((commit)
     (kill-new info)
     (message "%s" info))))

(defvar story-history nil)

(defun maio-current-story ()
  (nth 0 story-history))

(defun maio-read-story-string ()
  (interactive)
  (read-string (concat "Story (" (maio-current-story) "): ") "" 'story-history (maio-current-story)))

(defun maio-get-first-word (s)
  (first (s-split-words s)))

(defun maio-gerrit-cr (cr)
  (magit-section-action (item info "review")
    ((commit)
     (message (concat "CodeReview " cr))
     (shell-command (concat "ssh gerrit gerrit review " info " --code-review " cr)))))

(defun maio-gerrit-cr-ok () (interactive) (maio-gerrit-cr "+2"))
(defun maio-gerrit-cr-no-submit () (interactive) (maio-gerrit-cr "-2"))

(defun maio-git-submit ()
  (interactive)
  (let ((story (maio-get-first-word (maio-read-story-string)))
        (section (magit-current-section)))
    (if (string= "commit" (magit-section-type section))
        (progn
          (message "Going to submit current commit")
          (magit-run-git "publish" (magit-section-info section) story))
      (progn
        (message "Going to submit all pending commits")
        (magit-run-git "submit" story)))))

(defun maio-git-reset-hard-origin ()
  (interactive)
  (when (yes-or-no-p "Discard all uncommitted changes?")
    (magit-reset-head-hard
     (magit-get-tracked-branch (magit-get-current-branch)))))

(defun maio-git-reset-hard-upstream ()
  (interactive)
  (magit-fetch "upstream")
  (when (yes-or-no-p "Discard all uncommitted changes?")
    (magit-reset-head-hard "upstream/master")))

(defadvice magit-toggle-section (after scroll-line-to-top () activate)
  (call-interactively 'evil-scroll-line-to-top))

(define-key magit-status-mode-map "G" 'magit-shell-command)
(key-chord-define magit-status-mode-map "rp" 'maio-git-submit)
(key-chord-define magit-status-mode-map "rj" 'maio-gerrit-cr-ok)
(key-chord-define magit-status-mode-map "rk" 'maio-gerrit-cr-no-submit)
(key-chord-define magit-status-mode-map "xo" 'maio-git-reset-hard-origin)
(key-chord-define magit-status-mode-map "xu" 'maio-git-reset-hard-upstream)
(key-chord-define magit-status-mode-map ";w" 'magit-edit-branch-notes-file)
(key-chord-define git-commit-mode-map ";w" 'git-commit-commit)
(key-chord-define git-rebase-mode-map ";w" 'git-rebase-server-edit)
(add-hook 'git-commit-mode-hook 'flyspell-mode)
(add-hook 'git-commit-mode-hook 'flyspell-buffer)

(provide 'maio-magit)
