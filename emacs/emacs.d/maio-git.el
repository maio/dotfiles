(require 'magit)
(require 'git-rebase-mode)
(require 'diff-hl)
(require 'gist)

(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(setq magit-rewrite-inclusive nil)
(setq magit-status-buffer-switch-function 'switch-to-buffer)
(setq magit-diff-refine-hunk t)

(defvar story-history nil)

(defun maio-current-story ()
  (nth 0 story-history))

(defun maio-read-story-string ()
  (interactive)
  (read-string (concat "Story (" (maio-current-story) "): ") "" 'story-history (maio-current-story)))

(defun maio-get-first-word (s)
  (first (s-split-words s)))

(defun maio-git-amend ()
  (interactive)
  (magit-log-edit '4))

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
    (magit-reset-head-hard "origin/master")))

;; remove light background from diff added/removed faces
(custom-set-faces
 '(diff-added ((t (:inherit diff-changed :foreground "green4"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red3")))))

(defadvice magit-toggle-section (after scroll-line-to-top () activate)
  (call-interactively 'evil-scroll-line-to-top))

(add-hook 'magit-commit-mode-hook 'turn-on-flyspell)

(define-key magit-status-mode-map "p" 'maio-git-submit)
(define-key magit-status-mode-map "G" 'magit-shell-command)
(key-chord-define magit-status-mode-map "rj" 'maio-gerrit-cr-ok)
(key-chord-define magit-status-mode-map "rk" 'maio-gerrit-cr-no-submit)
(key-chord-define magit-status-mode-map "xo" 'maio-git-reset-hard-origin)
(key-chord-define gist-mode-map ";w" 'gist-mode-save-buffer)
(key-chord-define git-rebase-mode-map ";w" 'server-edit)
(defun maio/commit-commit ()
  (interactive)
  (git-commit-commit)
  (delete-window)
  (call-interactively 'magit-status))
(key-chord-define git-commit-mode-map ";w" 'maio/commit-commit)

(provide 'maio-git)
