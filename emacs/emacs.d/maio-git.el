(setq magit-rewrite-inclusive nil)
(setq magit-status-buffer-switch-function 'switch-to-buffer)

;; TODO: bind to some key (probably under P?)
(defun maio-git-submit ()
  (interactive)
  (when (not (magit-section-action (item info)
               ((commit)
                (magit-run-git "publish" info))))
    (magit-run-git "submit")))

(provide 'maio-git)
