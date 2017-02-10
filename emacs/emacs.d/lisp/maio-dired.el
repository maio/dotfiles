(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "z") 'dired-get-size)
  (when evil-mode
    (evil-define-key 'normal dired-mode-map "K" 'dired-do-delete)))

(defun dired-get-size ()
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message
       "Size of all marked files: %s"
       (progn
         (re-search-backward "\\(^[ 0-9.,]+[A-Za-z]+\\).*total$")
         (match-string 1))))))

(use-package dired-subtree
  :defer t
  :init
  (setq dired-subtree-use-backgrounds nil))
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "<tab>") 'dired-subtree-toggle))

(add-hook 'dired-mode-hook 'dired-hide-details-mode)

(provide 'maio-dired)
