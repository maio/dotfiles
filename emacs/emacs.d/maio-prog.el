(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook 'eldoc-mode)

(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))

(eval-after-load 'slime
  '(setq slime-protocol-version 'ignore))

(require 'autopair)
(which-func-mode 1)
(electric-pair-mode 0)
(electric-indent-mode 1)
(electric-layout-mode 1)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)

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

(require 'maio-guard)
(provide 'maio-prog)
