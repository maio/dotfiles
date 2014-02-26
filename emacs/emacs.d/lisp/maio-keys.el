(require 'maio-helm)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-h m") 'helm-descbinds)
(global-set-key (kbd "M-j") 'enlarge-window)
(global-set-key (kbd "C-9") 'previous-buffer)
(global-set-key (kbd "C-0") 'next-buffer)

(require 'smartrep)
;; https://github.com/shishi/.emacs.d/blob/master/inits/20-smartrep.el
(smartrep-define-key global-map "C-x" '(("," . previous-buffer)
                                        ("." . next-buffer)
                                        ("h" . winner-undo)
                                        ("l" . winner-redo)))

(global-set-key (kbd "C-x C-s") 'force-save-buffer)
(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x C-g") 'magit-status)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'maio/helm)
(global-set-key (kbd "C-x c v") 'maio/find-config-file)
(global-set-key (kbd "C-x g s") 'remember-notes)
(global-set-key (kbd "C-x g .") 'shell-switcher-switch-buffer)
(global-set-key (kbd "C-x g /") 'helm-git-grep)
(global-set-key (kbd "C-x g g") 'guard-or-goto-guard)
(global-set-key (kbd "C-x n f") 'maio-narrow-to-defun-clone)
(global-set-key (kbd "C-x c k") 'maio/bury)
(global-set-key (kbd "C-x c i") 'imenu)

(define-key comint-mode-map (kbd "C-x k") 'kill-comint-buffer)
(define-key ido-common-completion-map "\C-p" 'ido-prev-match)
(define-key ido-common-completion-map "\C-n" 'ido-next-match)
(define-key ido-buffer-completion-map "\C-p" 'ido-prev-match)
(define-key ido-buffer-completion-map "\C-n" 'ido-next-match)

;; unimpaired.vim
(eval-after-load 'flycheck
  '(progn
     (define-key evil-normal-state-map (kbd "]q") 'flycheck-next-error)
     (define-key evil-normal-state-map (kbd "[q") 'flycheck-previous-error)))

(define-key evil-normal-state-map (kbd "]e") 'next-error)
(define-key evil-normal-state-map (kbd "[e") 'previous-error)

(evil-define-key 'normal lisp-mode-shared-map (kbd "M-.") 'elisp-slime-nav-find-elisp-thing-at-point)
(evil-define-key 'normal lisp-mode-shared-map "Q" 'paredit-reindent-defun)
(evil-define-key 'normal lisp-mode-shared-map "D" 'paredit-kill)
(evil-define-key 'normal lisp-mode-shared-map "B" 'backward-up-list)
(evil-define-key 'insert lisp-mode-shared-map (kbd "C-j") 'paredit-close-round-and-newline)

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
