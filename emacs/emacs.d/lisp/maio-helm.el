(require 'cl-lib)

(setq helm-su-or-sudo "sudo"
      helm-allow-skipping-current-buffer nil
      helm-yank-symbol-first t
      helm-ff-auto-update-initial-value nil
      helm-idle-delay 0.1
      helm-input-idle-delay 0.05
      helm-display-header-line nil
      helm-ff-maximum-candidate-to-decorate 0
      helm-display-buffer-default-size 10
      helm-buffer-max-length 60
      helm-truncate-lines t
      helm-buffer-details-flag nil
      helm-mp-highlight-delay nil
      helm-full-frame nil
      helm-cmd-t-cache-threshhold 1000000000000
      helm-etags-match-part-only 'all
      helm-ag-use-agignore t
      helm-split-window-default-side 'below
      helm-ag-insert-at-point nil
      helm-prevent-escaping-from-minibuffer nil)

(setq helm-grep-default-command "ag --vimgrep %p %f"
      helm-grep-default-recurse-command "ag --vimgrep %p %f")

(use-package helm
  :defer 1
  :init
  (setq helm-locate-command
        (cl-case system-type
          ('gnu/linux "locate -i -r %s")
          ('berkeley-unix "locate -i %s")
          ('windows-nt "es %s")
          ('darwin "mdfind -name %s %s")
          (t "locate %s")))
  :config
  (helm-mode 1)
  (require 'helm-config)
  (require 'maio-helm-git)
  (global-set-key (kbd "C-x c v") 'maio/find-config-file)
  (global-set-key (kbd "C-x c c") 'helm-compile)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "s-b") 'helm-mini)
  (global-set-key [remap bookmark-jump] 'helm-bookmarks))

(use-package helm-compile
  :ensure nil
  :commands (helm-compile)
  :bind ("C-x c c" . helm-compile))

(use-package helm-terminal
  :ensure nil
  :commands (helm-terminal)
  :bind ("<s-return>" . helm-terminal))

(use-package helm-descbinds
  :after helm)

(defun helm-delete-other-windows ()
  (interactive)
  (with-helm-alive-p
    (with-helm-window
      (delete-other-windows))))
(put 'helm-delete-other-windows 'helm-only t)

(use-package helm-files
  :ensure nil
  :commands (helm-find-files-1)
  :bind (("C-x c v" . maio/find-config-file)
         ("C-x g p" . maio/helm-project)
         ("s-p" . maio/helm-project))
  :config
  (define-key helm-find-files-map " " 'helm-execute-persistent-action)
  (define-key helm-find-files-map (kbd "<s-backspace>") 'helm-ff-run-delete-file)
  (define-key helm-map (kbd "s-1") 'helm-delete-other-windows)
  (define-key helm-map (kbd "<s-return>") (lambda () (interactive) (helm-select-nth-action 1)))

  (define-key helm-find-files-map (kbd "C-s")
    '(lambda ()
       (interactive)
       (helm-exit-and-execute-action 'helm-do-ag)))
  (define-key helm-find-files-map (kbd "C-x C-j")
    '(lambda ()
       (interactive)
       (helm-exit-and-execute-action 'helm-point-file-in-dired)))
  (define-key helm-read-file-map " " 'helm-execute-persistent-action))

(use-package helm-backup
  :defer 1
  :config
  (add-hook 'after-save-hook 'helm-backup-versioning))

(use-package savehist
  :defer 1
  :config
  (add-to-list 'savehist-additional-variables 'extended-command-history)
  (add-to-list 'savehist-additional-variables 'compile-history))

(defun helm-set-default-directory (buffer-name directory)
  (let ((buffer (get-buffer buffer-name)))
    (when buffer
      (with-current-buffer buffer
        (setq default-directory directory)))))

(defun maio/helm-project ()
  (interactive)
  (require 'helm)
  (helm-find-files-1 (expand-file-name "~/Projects/")))

(defun maio/helm-do-ag-project-dir ()
  (interactive)
  (let ((default-directory (helm-ag--project-root)))
    (call-interactively 'helm-do-ag)))

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

(use-package eshell
  :defer t
  :config
  (add-hook 'eshell-mode-hook
            (lambda ()
              (define-key eshell-mode-map (kbd "M-r") 'helm-eshell-history))))

(use-package helm-dash
  :defer t)

(use-package helm-cmd-t
  :defer t)

(use-package helm-ag
  :defer t)

(provide 'maio-helm)
