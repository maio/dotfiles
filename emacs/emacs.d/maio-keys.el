(require 'magit)
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global (kbd ",,") 'other-buffer-or-window)
(key-chord-define-global (kbd ",w") 'force-save-buffer)
(key-chord-define-global (kbd ",b") 'helm-mini)
(key-chord-define-global (kbd ",k") 'kill-current-buffer)
(key-chord-define-global (kbd ",t") 'helm-c-etags-select)
(key-chord-define-global (kbd ",f") 'helm-ls-git-ls)
(key-chord-define-global (kbd ",r") 'helm-resume)
(key-chord-define-global (kbd ",x") 'helm-M-x)
(key-chord-define-global (kbd ",s") 'helm-occur)
(key-chord-define-global (kbd ",v") 'find-config-file)
(key-chord-define-global (kbd ",e") 'my-eval-defun)
(key-chord-define-global (kbd ",n") 'maio-narrow-to-defun-clone)
(key-chord-define-global (kbd ",a") 'ack-and-a-half)
(key-chord-define-global (kbd ",1") 'delete-other-windows)
(key-chord-define-global (kbd ",g") 'magit-status)

(key-chord-define evil-insert-state-map (kbd "jk") 'evil-normal-state)
(key-chord-define evil-emacs-state-map (kbd "jk") 'evil-normal-state)

(evil-define-key 'normal clojure-mode-map (kbd "RET") 'midje-check-fact)
(define-key magit-status-mode-map (kbd "p") 'maio-git-submit)

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

(global-set-key (kbd "C-;") 'maio/mark-all-like-this)

(provide 'maio-keys)
