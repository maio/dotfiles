(require 's)
(require 'yasnippet)
(yas-global-mode 1)
(global-subword-mode 1)

(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.mustache$" . mustache-mode))

(eval-after-load "mustache-mode"
  '(add-hook 'mustache-mode-hook 'maio/run-prog-mode-hook))

(eval-after-load "feature-mode"
  '(add-hook 'feature-mode-hook 'flyspell-mode))

(require 'smartparens)
(require 'smartparens-config)
(which-func-mode 1)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)
(add-hook 'prog-mode-hook 'smartparens-mode)
(add-hook 'html-mode-hook 'smartparens-mode)

(defun maio-narrow-to-defun-clone ()
  (interactive)
  (message (which-function))
  (clone-indirect-buffer (which-function) t)
  (narrow-to-defun))

(setq show-paren-delay 0)
(show-paren-mode 1)

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

(defun maio/find-alternative-file ()
  (interactive)
  (let ((ext (file-name-extension (buffer-file-name)))
        (name (file-name-base (buffer-file-name)))
        (dir (file-name-directory (buffer-file-name))))
    (cond ((string= ext "pm") (find-file (s-concat dir "/t/" name ".t")))
          ((string= ext "t") (find-file (s-concat dir "/../" name ".pm")))
          ;; GOA API
          ((string= ext "body") (find-file (s-concat dir "/t/" name ".sql")))
          ((string= ext "sql") (find-file (s-concat dir "/../" name ".body")))
          (t (message "Alternative file has not been found")))))

;; make backward kill word delete whitespaces first
(require 'paredit)
(defadvice paredit-backward-kill-word (around kill-empty-lines-first () activate)
  (if (maio/looking-at-empty-line?)
      (c-hungry-delete-backwards)
    ad-do-it))

(require 'subword)
(defadvice subword-backward-kill (around kill-empty-lines-first (arg) activate)
  (if (maio/looking-at-empty-line?)
      (c-hungry-delete-backwards)
    ad-do-it))

(require 'maio-guard)
(provide 'maio-prog)
