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
    (cd (projectile-get-project-root))
    (compile "make guard")
    (other-buffer-or-window)
    (rename-buffer "*guard*")
    (other-buffer-or-window)
    (cd old-path)))

(provide 'maio-guard)
