(require 'magit)
(require 'maio-key-chord)
(require 'maio-helm)

(key-chord-mode 1)
(key-chord-define-global ",," 'evil-buffer)
(key-chord-define-global ";a" 'other-window)
(key-chord-define-global ";w" 'force-save-buffer)
(key-chord-define-global ";b" 'maio/helm)
(key-chord-define-global ";k" 'kill-current-buffer)
(key-chord-define-global ";t" 'helm-c-etags-select)
(key-chord-define-global ";r" 'helm-resume)
(key-chord-define-global ";x" 'helm-M-x)
(key-chord-define-global ";s" 'helm-occur)
(define-key evil-normal-state-map "/" 'helm-occur)
(key-chord-define-global ";v" 'maio/find-config-file)
(key-chord-define-global ";n" 'maio-narrow-to-defun-clone)
(key-chord-define-global ";1" 'delete-other-windows)
(key-chord-define-global ";2" 'split-window-below)
(key-chord-define-global ";3" 'split-window-right)
(key-chord-define-global ";g" 'magit-status)
(key-chord-define-global ";f" 'helm-git-grep)
(key-chord-define-global "GG" 'guard-or-goto-guard)
(key-chord-define-global ";q" 'delete-window)
(key-chord-define-global ";*" 'maio/goto-scratch-buffer)
(key-chord-define-global ";`" 'shell)

;; marked buffer
(defvar maio-marked-buffer nil)
(define-key evil-normal-state-map "ge"
  (lambda () (interactive) (switch-to-buffer maio-marked-buffer)))
(key-chord-define-global "GE"
  (lambda () (interactive) (setq maio-marked-buffer (current-buffer))))

(key-chord-define lisp-mode-shared-map ";e" 'my-eval-defun)
(evil-define-key 'normal lisp-mode-shared-map (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-emacs-state-map "jk" 'evil-normal-state)
(define-key evil-insert-state-map (kbd "M-<backspace>") 'backward-kill-word)
(define-key evil-motion-state-map "gl" 'magit-file-log)
(define-key evil-normal-state-map (kbd "RET") 'maio/newline-above)
(define-key isearch-mode-map (kbd "C-g") 'isearch-abort)
(evil-define-key 'normal cperl-mode-map "K" 'cperl-perldoc-at-point)

;; guard
(define-key evil-motion-state-map "gm" 'guard-notify-message-show)
(evil-define-key 'normal compilation-minor-mode-map (kbd "RET") 'compile-goto-error)
(evil-define-key 'normal compilation-minor-mode-map "q" 'quit-window)
(define-key evil-insert-state-map (kbd "C-y")
  (lambda () (interactive) (call-interactively 'evil-paste-before) (forward-char)))

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
