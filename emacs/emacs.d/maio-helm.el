(setq helm-su-or-sudo "sudo"
      helm-allow-skipping-current-buffer nil
      helm-yank-symbol-first t
      helm-input-idle-delay 0.1
      helm-ff-auto-update-initial-value nil
      helm-ff-maximum-candidate-to-decorate 0)

(require 'helm-config)
(require 'helm-match-plugin)
(helm-mode 1)
(require 'maio-helm-git)

(define-key helm-find-files-map (kbd "C-c SPC") 'helm-ff-run-toggle-auto-update)
(define-key helm-find-files-map " " 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-c SPC") 'helm-ff-run-toggle-auto-update)
(define-key helm-read-file-map " " 'helm-execute-persistent-action)

(require 'helm-buffers)
(add-to-list 'helm-boring-buffer-regexp-list "\\*nrepl-events")
(add-to-list 'helm-boring-buffer-regexp-list "\\*nrepl-connection")

(defun helm-set-default-directory (buffer-name directory)
  (let ((buffer (get-buffer buffer-name)))
    (when buffer
      (with-current-buffer buffer
        (setq default-directory directory)))))

(defun maio/helm ()
  (interactive)
  (helm-set-default-directory "*helm maio*" default-directory)
  (helm :sources '(helm-c-source-buffers-list
                   helm-c-source-bookmarks
                   helm-c-source-recentf
                   helm-c-source-ls-git
                   helm-c-source-buffer-not-found)
        :buffer "*helm maio*"))

(require 'helm-compile)
(key-chord-define-global ";c" 'helm-compile)

(provide 'maio-helm)
