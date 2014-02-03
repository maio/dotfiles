(add-to-list 'ac-modes 'sql-mode)

(evil-define-key 'normal sql-mode-map "-" 'maio/find-alternative-file)

(provide 'maio-sql)
