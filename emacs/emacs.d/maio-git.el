(setq magit-rewrite-inclusive nil)
(setq magit-status-buffer-switch-function 'switch-to-buffer)

;; TODO: bind to some key (probably under P?)
(defun magit-publish ()
  (interactive)
  (magit-section-action (item info)
    ((commit)
       (magit-run-git "publish" info)))))

(provide 'maio-git)
