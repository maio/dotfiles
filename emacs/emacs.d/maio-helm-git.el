(add-to-list 'load-path "~/.emacs.d/helm-ls-git")
(require 'helm-ls-git)

;; source - https://github.com/lewang/helm-cmd-t/blob/master/helm-cmd-t.el
(defun helm-git-grep (cache-buffer &optional globs)
  (interactive (list (current-buffer)
                     (read-string "OnlyExt(e.g. *.rb *.erb): " "*")))
  (let* ((helm-c-grep-default-command "git grep -n%cH --full-name -e %p %f")
         helm-c-grep-default-recurse-command
         (globs (list "--" globs))
         (default-directory (helm-ls-git-root-dir))
         ;; Expand filename of each candidate with the git root dir.
         ;; The filename will be in the help-echo prop.
         (helm-c-grep-default-directory-fn `(lambda () (helm-ls-git-root-dir))))
    (helm-do-grep-1 globs)))

(provide 'maio-helm-git)
