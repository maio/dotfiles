;; remove light background from diff added/removed faces
(custom-set-faces
 '(diff-added ((t (:inherit diff-changed :foreground "green4"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red3")))))

(with-eval-after-load 'magit
  (require 'maio-magit))

(defun maio/magit-status-bear ()
  (interactive)
  (let ((default-directory "/Users/maio/Projects/bear/"))
    (call-interactively 'magit-status))
  nil)

(defun maio/magit-status-aqe ()
  (interactive)
  (let ((default-directory "/Users/maio/Projects/aqe/"))
    (call-interactively 'magit-status))
  nil)

(global-set-key (kbd "C-x g j b") 'maio/magit-status-bear)
(global-set-key (kbd "C-x g j a") 'maio/magit-status-aqe)

(provide 'maio-git)
