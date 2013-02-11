(require 'magit)
(require 'maio-key-chord)

(key-chord-mode 1)
(key-chord-define-global (kbd ",,") 'evil-buffer)
(key-chord-define-global (kbd ",;") 'other-window)
(key-chord-define-global (kbd ";w") 'force-save-buffer)
(key-chord-define-global (kbd ";b") 'maio/helm)
(key-chord-define-global (kbd ";k") 'kill-current-buffer)
(key-chord-define-global (kbd ";t") 'helm-c-etags-select)
(key-chord-define-global (kbd ";r") 'helm-resume)
(key-chord-define-global (kbd ";x") 'helm-M-x)
(key-chord-define-global (kbd ";s") 'helm-occur)
(define-key evil-normal-state-map (kbd "/") 'helm-occur)
(key-chord-define-global (kbd ";v") 'maio/find-config-file)
(key-chord-define-global (kbd ";n") 'maio-narrow-to-defun-clone)
(key-chord-define-global (kbd ";1") 'delete-other-windows)
(key-chord-define-global (kbd ";g") 'magit-status)
(key-chord-define-global (kbd "GG") 'guard-or-goto-guard)
(key-chord-define-global (kbd ";q") 'delete-window)
(key-chord-define-global (kbd ";*") 'maio/goto-scratch-buffer)

(key-chord-define lisp-mode-shared-map (kbd ";e") 'my-eval-defun)
(key-chord-define sqlplus-mode-map (kbd ";e") 'sqlplus-send-current)
(evil-define-key 'normal lisp-mode-shared-map (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)

(key-chord-define evil-insert-state-map (kbd "jk") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "M-<backspace>") 'backward-kill-word)
(define-key evil-motion-state-map "gl" 'magit-file-log)
(define-key evil-normal-state-map (kbd "RET") 'maio/newline-above)
(define-key isearch-mode-map (kbd "C-g") 'isearch-abort)
(evil-define-key 'normal cperl-mode-map (kbd "K") 'cperl-perldoc-at-point)

;; guard
(define-key evil-motion-state-map "gm" 'guard-notify-message-show)
(evil-define-key 'normal compilation-minor-mode-map (kbd "RET") 'compile-goto-error)
(evil-define-key 'normal compilation-minor-mode-map (kbd "q") 'quit-window)
(define-key evil-normal-state-map "ge" 'guard-goto-first-error)
(define-key evil-insert-state-map (kbd "C-y")
  (lambda ()
    (interactive)
    (insert (substring-no-properties (car kill-ring)))))

(defun maio/electric-semicolon ()
  (interactive)
  (call-interactively 'end-of-line)
  (when (not (looking-back ";"))
    (insert ";")
    (indent-according-to-mode)))

(defun maio/electric-space ()
  (interactive)
  (cond ((looking-back "(\\|{")
         (insert "  ")
         (backward-char))
        (t (insert " "))))

(defun maio/electric-return ()
  (interactive)
  (cond ((looking-back "(\\|{")
         (newline-and-indent)
         (call-interactively 'evil-open-above))
        (t (newline-and-indent))))

(defun maio/newline-above ()
  (interactive)
  (save-excursion (evil-first-non-blank) (newline-and-indent)))

(defun maio/makefile-newline ()
  (interactive)
  (insert "\\")
  (newline-and-indent))

(eval-after-load 'make-mode
  '(define-key makefile-gmake-mode-map (kbd "C-j") 'maio/makefile-newline))

(provide 'maio-keys)
