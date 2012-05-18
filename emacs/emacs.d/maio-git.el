(setq magit-rewrite-inclusive nil)
(setq magit-status-buffer-switch-function 'switch-to-buffer)

(defun maio-git-submit ()
  (interactive)
  (when (not (magit-section-action (item info)
               ((commit)
                (message "Going to submit current commit")
                (magit-run-git "publish" info))))
    (message "Going to submit all pending commits")
    (magit-run-git "submit")))

(provide 'maio-git)
