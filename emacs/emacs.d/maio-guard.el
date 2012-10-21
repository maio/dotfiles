(setq-default compilation-scroll-output t)
(require 'compile)

;; phpunit errors
(add-to-list 'compilation-error-regexp-alist
             '("^\\(.*?\\):\\([0-9]+\\)$" 1 2))

(defun guard ()
  (interactive)
  (server-start)
  (let ((old-path default-directory)
        (compilation-scroll-output t))
    (cd (helm-ls-git-root-dir))
    (compile "make guard")
    (other-buffer-or-window)
    (rename-buffer "*guard*")
    (other-buffer-or-window)
    (cd old-path)))

(defun guard-or-goto-guard ()
  (interactive)
  (if (get-buffer "*guard*")
      (progn
        (switch-to-buffer-other-window "*guard*")
        (end-of-buffer))
    (guard)))

(provide 'maio-guard)
