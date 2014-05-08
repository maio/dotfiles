(require 'maio-helm)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-h m") 'helm-descbinds)
(global-set-key (kbd "M-j") 'enlarge-window)
(global-set-key (kbd "C-9") 'previous-buffer)
(global-set-key (kbd "C-0") 'next-buffer)

(define-key (current-global-map) [remap save-buffer] 'force-save-buffer)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x K") 'kill-this-buffer-and-window)
(global-set-key (kbd "C-x g g") 'magit-status)
(global-set-key (kbd "C-x g b") 'magit-blame-mode)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'maio/helm)
(global-set-key (kbd "C-x c v") 'maio/find-config-file)
(global-set-key (kbd "C-x g s") 'remember-notes)
(global-set-key (kbd "C-x g .") 'eshell)
(global-set-key (kbd "C-x g /") 'helm-git-grep)
(global-set-key (kbd "C-x n f") 'maio-narrow-to-defun-clone)
(global-set-key (kbd "C-x c k") 'maio/bury)
(global-set-key (kbd "C-x c i") 'imenu)
(global-set-key (kbd "<s-return>") 'maio/ansi-term)
(global-set-key (kbd "s-j") 'other-window)
(global-set-key (kbd "s-k") 'previous-other-window)
(global-set-key (kbd "s-r") 'revert-buffer)

(define-key comint-mode-map (kbd "C-x k") 'kill-comint-buffer)
(define-key comint-mode-map (kbd "s-l") 'clear-comint-buffer)
(define-key ido-common-completion-map "\C-p" 'ido-prev-match)
(define-key ido-common-completion-map "\C-n" 'ido-next-match)
(define-key ido-buffer-completion-map "\C-p" 'ido-prev-match)
(define-key ido-buffer-completion-map "\C-n" 'ido-next-match)

;; unimpaired.vim
(with-eval-after-load 'flycheck
  (define-key evil-normal-state-map (kbd "]q") 'flycheck-next-error)
  (define-key evil-normal-state-map (kbd "[q") 'flycheck-previous-error))
(define-key evil-normal-state-map (kbd "]e") 'next-error)
(define-key evil-normal-state-map (kbd "[e") 'previous-error)
(with-eval-after-load 'flyspell
  (define-key evil-normal-state-map (kbd "]z") 'flyspell-goto-next-error))

(evil-define-key 'normal lisp-mode-shared-map (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)
(evil-define-key 'normal lisp-mode-shared-map "Q" 'paredit-reindent-defun)
(evil-define-key 'normal lisp-mode-shared-map "D" 'paredit-kill)
(evil-define-key 'normal lisp-mode-shared-map "B" 'backward-up-list)
(evil-define-key 'insert lisp-mode-shared-map (kbd "C-j") 'paredit-close-round-and-newline)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") '(lambda () (interactive) (eval-buffer) (ert t)))

(define-key evil-insert-state-map (kbd "M-<backspace>") 'backward-kill-word)
(define-key evil-motion-state-map "gl" 'magit-file-log)
(define-key evil-motion-state-map "g/" 'maio/goto-grep-buffer)
(define-key evil-normal-state-map (kbd "RET") 'maio/newline-above)
(define-key isearch-mode-map (kbd "C-g") 'isearch-abort)
(evil-define-key 'normal cperl-mode-map "K" 'cperl-perldoc-at-point)

;; guard
(evil-define-key 'normal compilation-minor-mode-map (kbd "RET") 'compile-goto-error)
(evil-define-key 'normal compilation-minor-mode-map "q" 'quit-window)

(defun maio/electric-space ()
  (interactive)
  (cond ((looking-back "(\\|{\\|\\[")
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

(with-eval-after-load 'make-mode
  (define-key makefile-gmake-mode-map (kbd "C-j") 'maio/makefile-newline))

(provide 'maio-keys)
