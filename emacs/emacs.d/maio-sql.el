(add-to-list 'ac-modes 'sql-mode)
(add-to-list 'auto-mode-alist '("\\.sqlt$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.body$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.spec$" . sql-mode))

(evil-define-key 'normal sql-mode-map "-" 'maio/find-alternative-file)

(provide 'maio-sql)
