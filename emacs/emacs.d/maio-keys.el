(require 'magit)
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global (kbd ",,") 'other-buffer-or-window)
(key-chord-define-global (kbd ";w") 'force-save-buffer)
(key-chord-define-global (kbd ";b") 'maio/helm-mini)
(key-chord-define-global (kbd ";k") 'kill-current-buffer)
(key-chord-define-global (kbd ";t") 'helm-c-etags-select)
(key-chord-define-global (kbd ";r") 'helm-resume)
(key-chord-define-global (kbd ";x") 'helm-M-x)
(key-chord-define-global (kbd ";s") 'helm-occur)
(key-chord-define-global (kbd ";v") 'find-config-file)
(key-chord-define-global (kbd ";e") 'my-eval-defun)
(key-chord-define-global (kbd ";n") 'maio-narrow-to-defun-clone)
(key-chord-define-global (kbd ";a") 'helm-git-grep)
(key-chord-define-global (kbd ";1") 'delete-other-windows)
(key-chord-define-global (kbd ";g") 'magit-status)
(key-chord-define-global (kbd "GG") 'guard-or-goto-guard)
(key-chord-define-global (kbd ";q") 'delete-window)

(define-key evil-motion-state-map "gl" 'magit-file-log)
(define-key magit-status-mode-map (kbd "p") 'maio-git-submit)
(define-key evil-normal-state-map (kbd "RET")
  (lambda ()
    (interactive) (save-excursion (evil-first-non-blank) (newline-and-indent))))
(key-chord-define magit-status-mode-map (kbd ";a") 'maio-git-amend)
(key-chord-define magit-log-edit-mode-map (kbd ";a") 'magit-log-edit-toggle-amending)
(define-key isearch-mode-map (kbd "C-g") 'isearch-abort)
(evil-define-key 'normal nrepl-mode-map (kbd "RET") 'nrepl-return)
(defadvice nrepl-return (after normal-state () activate) (evil-normal-state))
(evil-define-key 'normal nrepl-mode-map (kbd "(")
  (lambda () (interactive) (insert "(") (evil-insert-state)))

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

(defun maio/makefile-newline ()
  (interactive)
  (insert "\\")
  (newline-and-indent))

(eval-after-load 'make-mode
  '(define-key makefile-gmake-mode-map (kbd "C-j") 'maio/makefile-newline))

(provide 'maio-keys)
