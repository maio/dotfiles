(add-to-list 'load-path "~/.emacs.d/cperl-mode")
(defalias 'perl-mode 'cperl-mode)
(setq cperl-electric-parens nil)
(setq cperl-indent-level 4)
(setq cperl-invalid-face nil)
(custom-set-faces
 '(cperl-array-face ((t (:foreground "Green" :weight bold))))
 '(cperl-hash-face ((t (:foreground "Red" :slant italic :weight bold)))))

(setq cperl-indent-level 4
      cperl-close-paren-offset -4
      cperl-continued-statement-offset 4
      cperl-indent-parens-as-block t
                cperl-tab-always-indent t)

(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))

(provide 'maio-perl)
