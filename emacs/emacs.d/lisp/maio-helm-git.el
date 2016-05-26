(defun helm-ff-run-magit-status ()
  (interactive)
  (with-helm-alive-p
    (helm-quit-and-execute-action 'magit-status)))

(define-key helm-find-files-map (kbd "C-x g") 'helm-ff-run-magit-status)
(define-key helm-find-files-map (kbd "s-g") 'helm-ff-run-magit-status)

(use-package helm-ls-git
  :defer 3
  :config
  (global-set-key (kbd "s-t") 'helm-ls-git-ls)
  (setq helm-ls-git-default-sources '(helm-source-ls-git-buffers
                                      helm-source-ls-git)
        helm-ls-git-show-abs-or-relative 'relative)
  (define-key helm-find-files-map (kbd "s-t") 'helm-ff-run-browse-project))

(provide 'maio-helm-git)
