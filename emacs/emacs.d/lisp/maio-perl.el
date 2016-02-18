(setq perl-indent-parens-as-block t)

(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))

;; Template Toolkit
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . html-mode))

(defun setup-perl-mode ()
  (make-local-variable 'evil-lookup-func)
  (setq evil-lookup-func 'cperl-perldoc-at-point)
  (setq indent-tabs-mode t))

(with-eval-after-load 'perl-mode
  (add-hook 'perl-mode-hook 'smartparens-mode)
  (add-hook 'perl-mode-hook 'flycheck-mode)
  (add-hook 'perl-mode-hook 'setup-perl-mode)

  (require 'perltidy)
  (evil-define-key 'normal perl-mode-map "=" 'perltidy-dwim)
  (evil-define-key 'visual perl-mode-map "=" 'perltidy-dwim))

(provide 'maio-perl)
