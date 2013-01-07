(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.mustache$" . mustache-mode))

(eval-after-load 'slime
  '(setq slime-protocol-version 'ignore))

(eval-after-load "mustache-mode"
  '(add-hook 'mustache-mode-hook 'maio/run-prog-mode-hook))

(require 'autopair)
(which-func-mode 1)
(electric-pair-mode 0)
(electric-indent-mode 1)
(electric-layout-mode 1)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)
(add-hook 'prog-mode-hook 'autopair-on)

(defun maio-narrow-to-defun-clone ()
  (interactive)
  (message (which-function))
  (clone-indirect-buffer (which-function) t)
  (narrow-to-defun))

(setq whitespace-action '(auto-cleanup))
(setq whitespace-style '(face trailing lines-tail) whitespace-line-column 80)
(whitespace-mode)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(require 'mark-more-like-this)
(defun maio/mark-all-like-this ()
  (interactive)
  (evil-visual-char)
  (call-interactively 'mark-all-like-this)
  (evil-exchange-point-and-mark)
  (evil-normal-state))

(defun maio/mark-all-like-this-in-defun ()
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (narrow-to-defun)
      (call-interactively 'mark-all-like-this)))
  (evil-visual-char)
  (evil-exchange-point-and-mark)
  (evil-normal-state))

(defun maio/compile-in-git-root ()
  (interactive)
  (let ((old-path default-directory)
        (compilation-scroll-output t))
    (cd (locate-dominating-file default-directory ".git"))
    (call-interactively 'compile)
    (cd old-path)))

(require 'maio-guard)
(provide 'maio-prog)
