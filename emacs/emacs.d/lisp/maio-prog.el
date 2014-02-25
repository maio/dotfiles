(require 's)
(require 'yasnippet)
(global-subword-mode 1)

(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.mustache$" . mustache-mode))

(eval-after-load "mustache-mode"
  '(add-hook 'mustache-mode-hook 'maio/run-prog-mode-hook))

(eval-after-load "feature-mode"
  '(add-hook 'feature-mode-hook 'flyspell-mode))

(require 'recompile-on-save)

(require 'smartparens)
(require 'smartparens-config)
(which-func-mode 1)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)
(add-hook 'prog-mode-hook 'turn-on-smartparens-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'html-mode-hook 'turn-on-smartparens-mode)

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

(defun maio/get-alternative-file (fname)
  (let ((ext (file-name-extension fname))
        (name (file-name-base fname))
        (dir (file-name-directory fname)))
    (cond ((string= ext "pm") (f-join dir (concat name ".t")))
          ((string= ext "t") (f-join dir (concat name ".pm")))
          ;; GOA API
          ((string= ext "body") (f-join dir "t" (concat name ".sql")))
          ((string= ext "sql") (f-join dir ".." (concat name ".body")))
          ;; Pherkin
          ((string= ext "feature") (f-join dir "step_definitions" (concat name "_steps.pl")))
          ((s-contains? "_steps" name) (f-join dir ".." (concat (s-replace "_steps" "" name) ".feature"))))))

(defun maio/find-alternative-file ()
  (interactive)
  (let ((afname (maio/get-alternative-file (buffer-file-name))))
    (if afname
        (find-file afname)
      (message "Alternative file has not been found"))))

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
