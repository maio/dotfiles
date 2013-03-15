(require 's)
(require 'typing-speed)
(require 'yasnippet)
(yas-global-mode 1)

(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.mustache$" . mustache-mode))

(eval-after-load "mustache-mode"
  '(add-hook 'mustache-mode-hook 'maio/run-prog-mode-hook))

(eval-after-load "feature-mode"
  '(add-hook 'feature-mode-hook 'flyspell-mode))

(require 'autopair)
(which-func-mode 1)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)
(add-hook 'prog-mode-hook 'autopair-on)
(add-hook 'html-mode-hook 'autopair-on)
(add-hook 'prog-mode-hook 'turn-on-typing-speed)

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
        (compilation-scroll-output t)
        (compile-command "make "))
    (cd (locate-dominating-file default-directory ".git"))
    (call-interactively 'compile)
    (with-current-buffer compilation-last-buffer
      (rename-buffer (concat "*" (s-trim compile-command) "*")))
    (cd old-path)))

(require 'maio-guard)
(provide 'maio-prog)
