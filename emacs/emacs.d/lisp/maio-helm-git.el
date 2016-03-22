(defun helm-ff-run-magit-status ()
  (interactive)
  (with-helm-alive-p
    (helm-quit-and-execute-action 'magit-status)))

(define-key helm-find-files-map (kbd "C-x g") 'helm-ff-run-magit-status)
(define-key helm-find-files-map (kbd "s-g") 'helm-ff-run-magit-status)

(defun helm-ff-cmd-t (_candidate)
  (with-helm-default-directory helm-ff-default-directory
      (call-interactively 'helm-cmd-t)))

(defun helm-ff-run-cmd-t ()
  (interactive)
  (with-helm-alive-p
    (helm-quit-and-execute-action 'helm-ff-cmd-t)))

(define-key helm-find-files-map (kbd "s-t") 'helm-ff-run-cmd-t)

(provide 'maio-helm-git)
