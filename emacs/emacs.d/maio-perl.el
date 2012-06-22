(add-to-list 'load-path "~/.emacs.d/cperl-mode")
(defalias 'perl-mode 'cperl-mode)
(custom-set-faces
 '(cperl-array-face ((t (:foreground "Green" :weight bold))))
 '(cperl-hash-face ((t (:foreground "Red" :slant italic :weight bold)))))

(setq cperl-indent-level 4
      cperl-close-paren-offset -4
      cperl-continued-statement-offset 4
      cperl-indent-parens-as-block t
      cperl-electric-parens nil
      cperl-invalid-face nil
      cperl-tab-always-indent t)

(add-to-list 'which-func-modes 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.psgi$" . perl-mode))

;; Template Toolkit
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . html-mode))

(eval-after-load 'cperl-mode
  '(progn
     (add-hook 'cperl-mode-hook 'esk-prog-mode-hook)
     (add-hook 'cperl-mode-hook 'flymake-mode)
     (add-hook 'cperl-mode-hook 'autopair-on)
     (evil-define-key 'normal cperl-mode-map "=" 'perltidy-dwim)
     (evil-define-key 'visual cperl-mode-map "=" 'perltidy-dwim)
     (define-key cperl-mode-map ";" 'maio/electric-semicolon)
     (define-key cperl-mode-map (kbd "SPC") 'maio/electric-space)
     (define-key cperl-mode-map (kbd "RET") 'maio/electric-return)))

(setq flymake-perlcritic-severity 3)
(require 'flymake-perlcritic)

(provide 'maio-perl)
