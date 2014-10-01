;;; -*- lexical-binding: t -*-

(setq eyebrowse-mode-line-separator " ")
(require 'eyebrowse)
(require 'dash)
(require 's)

(progn
  (let ((map eyebrowse-mode-map))
    (define-key map (kbd "C-'") 'eyebrowse-last-window-config)
    (define-key map (kbd "s-`") 'eyebrowse-last-window-config)
    (define-key map (kbd "C-\"") 'eyebrowse-close-window-config)
    (-map (lambda (n)
            (define-key map
              (kbd (s-concat
                    (if (ui-type-is-terminal) "M-" "s-")
                    (number-to-string n)))
              (lambda () (interactive)
                (eyebrowse-switch-to-window-config n)))) '(0 1 2 3 4 5 6))))

;;; eyebrowse new window setup
(progn
  (defvar eyebrowse-new-window-hook nil)

  (defun display-scratch-only ()
    (delete-other-windows)
    (switch-to-buffer "*scratch*"))

  (add-hook 'eyebrowse-new-window-hook 'display-scratch-only)

  (defadvice eyebrowse-switch-to-window-config (around handle-new-window-config (slot) activate)
    (let ((match (assq slot (eyebrowse-get 'window-configs))))
      ad-do-it
      (when (not match) (run-hooks 'eyebrowse-new-window-hook)))))

;;; eyebrowse build default windows
(progn
  (eyebrowse-mode t)
  (eyebrowse-switch-to-window-config 0)
  (eyebrowse-switch-to-window-config 4)
  (eyebrowse-switch-to-window-config 1))

(with-eval-after-load 'magit
  (defadvice magit-status (before eyebrowse-window-0 () activate)
    (when eyebrowse-mode
      (eyebrowse-switch-to-window-config 0)
      (delete-other-windows)))

  (defadvice magit-file-log (before eyebrowse-window-0 () activate)
    (when eyebrowse-mode
      (eyebrowse-switch-to-window-config 0)
      (delete-other-windows))))

(with-eval-after-load 'term
  (defadvice ansi-term (around eyebrowse-window-4 (program &optional new-buffer-name) activate)
    (if eyebrowse-mode
        (progn
          (let ((dir default-directory))
            (eyebrowse-switch-to-window-config 4)
            (if (in-mode? 'term-mode)
                (split-window-below)
              (delete-other-windows))
            (let ((default-directory dir))
              ad-do-it)))
      ad-do-it)))

(defadvice find-file (around eyebrowse-window-1 (filename &optional wildcards) activate)
  (if eyebrowse-mode
      (progn
        (let ((dir default-directory))
          (when (member (eyebrowse-get 'current-slot) '(0 4))
            (eyebrowse-switch-to-window-config 1))
          (let ((default-directory dir))
            ad-do-it)))
    ad-do-it))

(provide 'maio-eyebrowse)
