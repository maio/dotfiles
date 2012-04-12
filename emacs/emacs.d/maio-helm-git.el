(require 'helm)
(require 'magit)

(defun git-root-dir ()
  (magit-git-string "rev-parse" "--show-toplevel"))

(defun git-file-full-path (name)
  (expand-file-name name (git-root-dir)))

(defun find-git-file (name)
  (find-file (git-file-full-path name)))

(defun helm-c-git-list ()
  (magit-git-lines "ls-files"))

(defvar helm-c-source-git-list
  `((name . "Git files")
    (candidates . helm-c-git-list)
    (volatile)
    (keymap . ,helm-generic-files-map)
    (help-message . helm-generic-file-help-message)
    (mode-line . helm-generic-file-mode-line-string)
    (match helm-c-match-on-basename)
    (type . file)
    (action . (lambda (candidate)
                (find-git-file candidate))))
  "Helm source definition")

(defun helm-git ()
  (interactive)
  (helm :sources '(helm-c-source-git-list)))

(provide 'maio-helm-git)
