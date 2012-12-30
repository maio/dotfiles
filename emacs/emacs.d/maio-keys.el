(require 'magit)
(require 'key-chord)
(setq key-chord-one-key-delay 0.2)

;; custom key-chord-define
(defun key-chord-define (keymap keys command)
  (if (/= 2 (length keys))
      (error "Key-chord keys must have two elements"))
  ;; Exotic chars in a string are >255 but define-key wants 128..255 for those
  (let ((key1 (logand 255 (aref keys 0)))
        (key2 (logand 255 (aref keys 1))))
    (if (eq key1 key2)
        (define-key keymap (vector 'key-chord key1 key2) command)
      (define-key keymap (vector 'key-chord key1 key2) command))))

(key-chord-mode 1)
(key-chord-define-global (kbd ",,") 'evil-buffer)
(key-chord-define-global (kbd ";w") 'force-save-buffer)
(key-chord-define-global (kbd ";b") 'maio/helm-mini)
(key-chord-define-global (kbd ";k") 'kill-current-buffer)
(key-chord-define-global (kbd ";t") 'helm-c-etags-select)
(key-chord-define-global (kbd ";r") 'helm-resume)
(key-chord-define-global (kbd ";x") 'helm-M-x)
(key-chord-define-global (kbd ";s") 'helm-occur)
(key-chord-define-global (kbd ";v") 'find-config-file)
(key-chord-define-global (kbd ";n") 'maio-narrow-to-defun-clone)
(key-chord-define-global (kbd ";a") 'helm-git-grep)
(key-chord-define-global (kbd ";1") 'delete-other-windows)
(key-chord-define-global (kbd ";g") 'magit-status)
(key-chord-define-global (kbd "GG") 'guard-or-goto-guard)
(key-chord-define-global (kbd ";q") 'delete-window)

(key-chord-define lisp-mode-shared-map (kbd ";e") 'my-eval-defun)

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

(evil-define-command cofi/evil-maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p))
        (entry-key ?j)
        (exit-key ?k))
    (insert entry-key)
    (let ((evt (read-event (format "Insert %c to exit insert state" exit-key) nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt exit-key))
          (delete-char -1)
          (set-buffer-modified-p modified)
          (push 'escape unread-command-events))
       (t (push evt unread-command-events))))))

(define-key evil-insert-state-map (kbd "j") 'cofi/evil-maybe-exit)

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
