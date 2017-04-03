(require 's)

(defun with-color-red (text)
  (propertize text 'font-lock-face '(:foreground "red" :weight bold)))

(use-package helm-projectile
  :defer t
  :config
  (setq projectile-mode-line
        '(:eval (if (file-remote-p default-directory)
                    ""
                  (let* ((name (projectile-project-name))
                         (text (format " [%s]" name)))
                    (if (s-contains? "QuickFix" name)
                        (with-color-red text)
                      text)))))
  (setq projectile-enable-caching t
        projectile-switch-project-action 'magit-status)
  (global-set-key (kbd "s-t") 'helm-projectile))

(provide 'maio-projectile)
