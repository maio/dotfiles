;;; -*- lexical-binding: t -*-

(setq eyebrowse-mode-line-separator " ")
(require 'eyebrowse)
(require 'dash)

(progn
  (let ((map eyebrowse-mode-map))
    (define-key map (kbd "C-'") 'eyebrowse-last-window-config)
    (define-key map (kbd "C-\"") 'eyebrowse-close-window-config)
    (define-key map (kbd "s-j") 'eyebrowse-next-window-config)
    (define-key map (kbd "s-k") 'eyebrowse-prev-window-config)
    (-map (lambda (n)
            (define-key map (kbd (s-concat "C-" (number-to-string n)))
              (lambda () (interactive)
                (eyebrowse-switch-to-window-config n)))) '(1 2 3 4 5 6))))

;;; eyebrowse new window setup
(progn
  (defvar eyebrowse-new-window-hook nil)

  (defun display-scratch-only ()
    (delete-other-windows)
    (switch-to-buffer "*scratch*"))

  (add-hook 'eyebrowse-new-window-hook 'display-scratch-only)

  (defadvice eyebrowse-switch-to-window-config (around handle-new-window-config (slot) activate)
    (let ((match (assq slot eyebrowse-window-configs)))
      ad-do-it
      (when (not match) (run-hooks 'eyebrowse-new-window-hook)))))

;;; eyebrowse build default windows
(progn
  (eyebrowse-switch-to-window-config 0)
  (eyebrowse-switch-to-window-config 4)
  (eyebrowse-switch-to-window-config 1))

(with-eval-after-load 'magit
  (defadvice magit-status (before eyebrowse-window-0 () activate)
    (eyebrowse-switch-to-window-config 0)
    (delete-other-windows))

  (defadvice magit-file-log (before eyebrowse-window-0 () activate)
    (eyebrowse-switch-to-window-config 0)
    (delete-other-windows)))

(with-eval-after-load 'term
  (defadvice ansi-term (around eyebrowse-window-4 (program &optional new-buffer-name) activate)
    (let ((dir default-directory))
      (eyebrowse-switch-to-window-config 4)
      (if (in-mode? 'term-mode)
          (split-window-below)
        (delete-other-windows))
      (let ((default-directory dir))
        ad-do-it))))

(defadvice find-file (around eyebrowse-window-1 (filename &optional wildcards) activate)
  (let ((dir default-directory))
    (when (member eyebrowse-current-slot '(1 4))
      (eyebrowse-switch-to-window-config 1))
    (let ((default-directory dir))
      ad-do-it)))

(eyebrowse-mode t)

(provide 'maio-eyebrowse)
