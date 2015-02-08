(with-eval-after-load 'scheme
  (define-key scheme-mode-map (kbd "C-M-x") 'lisp-eval-defun)
  (define-key scheme-mode-map (kbd "C-x C-e") 'lisp-eval-last-sexp))

(defun maio/run-ert-tests (reset?)
  (interactive "P")
  (when reset? (ert-delete-all-tests))
  (ert-kill-all-test-buffers)
  (eval-buffer)
  (ert t))

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'maio/run-ert-tests)
(define-key emacs-lisp-mode-map (kbd "<C-return>") 'eval-defun)
(when evil-mode
  (evil-define-key 'normal emacs-lisp-mode-map "K" 'elisp-slime-nav-describe-elisp-thing-at-point))

(provide 'maio-lisp)
