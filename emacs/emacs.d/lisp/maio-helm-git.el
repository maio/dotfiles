(defun helm-ff-run-magit-status ()
  (interactive)
  (with-helm-alive-p
    (helm-quit-and-execute-action 'magit-status)))

(define-key helm-find-files-map (kbd "C-x g") 'helm-ff-run-magit-status)

(provide 'maio-helm-git)
