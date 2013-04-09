(require 'magit)
(require 'diff-hl)

(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
(setq magit-rewrite-inclusive nil)
(setq magit-status-buffer-switch-function 'switch-to-buffer)

(defvar story-history nil)

(defun maio-current-story ()
  (nth 0 story-history))

(defun maio-read-story-string ()
  (interactive)
  (read-string (concat "Story (" (maio-current-story) "): ") "" 'story-history (maio-current-story)))

(defun maio-get-first-word (s)
  (first (split-string s " ")))

(defun maio-git-amend ()
  (interactive)
  (magit-log-edit '4))

(defun maio-git-submit ()
  (interactive)
  (let ((story (maio-read-story-string)))
    (when (not (magit-section-action (item info)
                 ((commit)
                  (message "Going to submit current commit")
                  (magit-run-git "publish" info (maio-get-first-word story)))))
      (message "Going to submit all pending commits")
      (magit-run-git "submit" (maio-get-first-word story)))))

;; remove light background from diff added/removed faces
(custom-set-faces
 '(diff-added ((t (:inherit diff-changed :foreground "green4"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red3")))))

(defadvice magit-toggle-section (after scroll-line-to-top () activate)
  (call-interactively 'evil-scroll-line-to-top))

(add-hook 'magit-commit-mode-hook 'turn-on-flyspell)

(define-key magit-status-mode-map "p" 'maio-git-submit)
(define-key magit-status-mode-map "G" 'magit-shell-command)
(key-chord-define magit-status-mode-map "ca" 'maio-git-amend)
(key-chord-define magit-status-mode-map "cc" 'magit-log-edit)

(provide 'maio-git)
