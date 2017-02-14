(defun helm-ff-run-magit-status ()
  (interactive)
  (with-helm-alive-p
    (helm-quit-and-execute-action 'magit-status)))

(define-key helm-find-files-map (kbd "C-x g") 'helm-ff-run-magit-status)
(define-key helm-find-files-map (kbd "s-g") 'helm-ff-run-magit-status)

(defun helm-ff-ag-project-root (_candidate)
  (with-helm-default-directory helm-ff-default-directory
      (helm-do-ag helm-ff-default-directory)))

(defun helm-ff-run-ag-project-root ()
  (interactive)
  (with-helm-alive-p
    (helm-exit-and-execute-action 'helm-ff-ag-project-root)))
(put 'helm-ff-run-ag-project-root 'helm-only t)

(use-package helm-ls-git
  :defer 3
  :config
  (global-set-key (kbd "s-t") 'helm-ls-git-ls)
  (setq helm-ls-git-default-sources '(helm-source-ls-git-buffers
                                      helm-source-ls-git)
        helm-ls-git-show-abs-or-relative 'relative)
  (define-key helm-find-files-map (kbd "s-t") 'helm-ff-run-browse-project)
  (define-key helm-find-files-map (kbd "s-/") 'helm-ff-run-ag-project-root))

(provide 'maio-helm-git)
