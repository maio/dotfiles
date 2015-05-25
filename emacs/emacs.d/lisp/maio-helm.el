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
      helm-full-frame nil
      helm-cmd-t-cache-threshhold 1000000000000
      helm-etags-match-part-only nil)

(setq helm-locate-command
      (case system-type
        ('gnu/linux "locate -i -r %s")
        ('berkeley-unix "locate -i %s")
        ('windows-nt "es %s")
        ('darwin "mdfind -name %s %s")
        (t "locate %s")))

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

(require 'helm-backup)
(add-hook 'after-save-hook 'helm-backup-versioning)

(defun helm-set-default-directory (buffer-name directory)
  (let ((buffer (get-buffer buffer-name)))
    (when buffer
      (with-current-buffer buffer
        (setq default-directory directory)))))

(defun maio/helm-project ()
  (interactive)
  (helm-find-files-1 (expand-file-name "~/Projects/")))

(defun maio/helm-personal-project ()
  (interactive)
  (helm-find-files-1 (expand-file-name "~/Projects/personal/")))

(defun maio/helm-org ()
  (interactive)
  (helm-find-files-1 (expand-file-name "~/org/")))

(defun maio/helm-occur ()
  "Preconfigured helm for Occur."
  (interactive)
  (helm-occur-init-source)
  (let ((bufs (list (buffer-name (current-buffer)))))
    (helm-attrset 'moccur-buffers bufs helm-source-occur)
    (helm-set-local-variable 'helm-multi-occur-buffer-list bufs)
    (helm-set-local-variable
     'helm-multi-occur-buffer-tick
     (cl-loop for b in bufs
              collect (buffer-chars-modified-tick (get-buffer b)))))
  (helm :sources 'helm-source-occur
        :buffer "*helm occur*"
        :history 'regexp-search-ring
        :preselect (and (memq 'helm-source-occur helm-sources-using-default-as-input)
                        (format "%s:%d:" (buffer-name) (line-number-at-pos (point))))
        :truncate-lines t))

(require 'helm-terminal)
(global-set-key (kbd "<s-return>") 'helm-terminal)

(require 'helm-compile)
(global-set-key (kbd "C-x c c") 'helm-compile)

(require 'eshell)
(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history)))

(require 'rx)
(add-to-list 'display-buffer-alist
                    `(,(rx bos "*helm" (* not-newline) "*" eos)
                         (display-buffer-in-side-window)
                         (inhibit-same-window . t)
                         (window-height . 0.4)))

(provide 'maio-helm)
