(setq helm-su-or-sudo "sudo"
      helm-allow-skipping-current-buffer nil
      helm-yank-symbol-first t
      helm-ff-auto-update-initial-value nil
      helm-idle-delay 0.1
      helm-input-idle-delay 0.1
      helm-ff-maximum-candidate-to-decorate 0
      helm-buffer-max-length 60
      helm-truncate-lines t
      helm-buffer-details-flag nil
      helm-mp-highlight-delay nil
      helm-full-frame nil)

(require 'helm-config)
(require 'helm-match-plugin)
(helm-mode 1)
(require 'maio-helm-git)
(require 'helm-descbinds)

(require 'savehist)
(add-to-list 'savehist-additional-variables 'extended-command-history)

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
  (helm :sources '(helm-c-source-ls-git
                   helm-c-source-buffer-not-found)
        :buffer "*helm maio*"))

(defun maio/helm-occur ()
  "Same as helm-occur expect it uses regexp-search-ring

This way it's possible to use evil-search-next."
  (interactive)
  (setq helm-multi-occur-buffer-list (list (buffer-name (current-buffer))))
  (setq isearch-forward t)
  (helm-occur-init-source)
  (helm-attrset 'name "Occur" helm-source-occur)
  (helm :sources 'helm-source-occur
        :buffer "*helm occur*"
        :history 'regexp-search-ring))

(require 'helm-compile)
(global-set-key (kbd "C-x c c") 'helm-compile)

(require 'eshell)
(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)))

(provide 'maio-helm)
