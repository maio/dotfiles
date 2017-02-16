(with-eval-after-load 'scheme
  (define-key scheme-mode-map (kbd "C-M-x") 'lisp-eval-defun)
  (define-key scheme-mode-map (kbd "C-x C-e") 'lisp-eval-last-sexp))

(defun lisp-hippie-expand-setup ()
  (make-local-variable 'hippie-expand-try-functions-list)
  (setq hippie-expand-try-functions-list '(try-complete-lisp-symbol-partially
                                           try-complete-lisp-symbol
                                           try-expand-dabbrev)))

(add-hook 'emacs-lisp-mode-hook 'lisp-hippie-expand-setup)
(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(defun maio/run-ert-tests (reset?)
  (interactive "P")
  (when reset? (ert-delete-all-tests))
  (ert-kill-all-test-buffers)
  (eval-buffer)
  (ert t))

(defadvice sp-down-sexp (before mark () activate)
  (when (interactive-p) (push-mark)))

(defadvice sp-backward-up-sexp (before mark () activate)
  (when (interactive-p) (push-mark)))

(defadvice sp-next-sexp (before mark () activate)
  (when (interactive-p) (push-mark)))

(defadvice sp-backward-sexp (before mark () activate)
  (when (interactive-p) (push-mark)))

(define-key emacs-lisp-mode-map (kbd "C-S-j") 'sp-split-sexp)
(define-key emacs-lisp-mode-map (kbd "M-DEL") 'sp-backward-kill-word)
(define-key emacs-lisp-mode-map (kbd "M-q") 'sp-indent-defun)
(define-key emacs-lisp-mode-map (kbd "M-r") 'sp-raise-sexp)
(define-key emacs-lisp-mode-map (kbd "M-k") 'sp-kill-sexp)
(define-key emacs-lisp-mode-map (kbd "C-)") 'sp-forward-slurp-sexp)
(define-key emacs-lisp-mode-map (kbd "C-(") 'sp-forward-barf-sexp)
(define-key emacs-lisp-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
(define-key emacs-lisp-mode-map (kbd "M-J") 'sp-join-sexp)
(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'maio/run-ert-tests)
(define-key emacs-lisp-mode-map (kbd "<C-return>") 'eval-defun)
(when (evil-mode?)
  (add-hook 'emacs-lisp-mode-hook 'evil-cleverparens-mode)
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "s-L") 'sp-down-sexp)
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "s-H") 'sp-backward-up-sexp)
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "s-J") 'sp-next-sexp)
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "s-K") 'sp-backward-sexp)
  (evil-define-key 'normal emacs-lisp-mode-map "(" 'sp-backward-up-sexp)
  (evil-define-key 'normal emacs-lisp-mode-map ")" 'sp-end-of-next-or-previous-sexp)
  (evil-define-key 'normal emacs-lisp-mode-map (kbd "s-d") 'sp-clone-sexp)

  (evil-define-key 'normal emacs-lisp-mode-map "D" 'sp-kill-hybrid-sexp)
  (evil-define-key 'normal emacs-lisp-mode-map "K" 'elisp-slime-nav-describe-elisp-thing-at-point))

(provide 'maio-lisp)
