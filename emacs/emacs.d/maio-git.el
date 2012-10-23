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

(provide 'maio-git)
