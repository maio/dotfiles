(setq helm-su-or-sudo "sudo"
      helm-allow-skipping-current-buffer nil
      helm-M-x-requires-pattern 0
      helm-ff-transformer-show-only-basename nil
      helm-buffer-max-length 40
      helm-yank-symbol-first t)

(require 'helm-config)
(require 'helm-match-plugin)
(helm-mode 1)
(require 'maio-helm-git)

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
                   helm-c-source-buffer-not-found)
        :buffer "*helm maio*"))

(defun maio/helm-ls-git-only ()
  (interactive)
  (helm-set-sources '(helm-c-source-ls-git)))

(key-chord-define helm-map (kbd ";g") 'maio/helm-ls-git-only)

(provide 'maio-helm)
