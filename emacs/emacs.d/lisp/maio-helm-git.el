(add-to-list 'load-path "~/.emacs.d/lisp/helm-ls-git")
(require 'helm-ls-git)
(setq helm-ls-git-show-abs-or-relative 'relative)

(defun helm-ff-run-magit-status ()
  (interactive)
  (with-helm-alive-p
    (helm-quit-and-execute-action 'magit-status)))

(define-key helm-find-files-map (kbd "C-x g") 'helm-ff-run-magit-status)

(provide 'maio-helm-git)
