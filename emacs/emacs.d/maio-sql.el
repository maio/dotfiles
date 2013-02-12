(require 'sqlplus)
(require 'maio-completion)

(add-to-list 'ac-modes 'sqlplus-mode)
(add-to-list 'ac-modes 'sql-mode)
(add-to-list 'auto-mode-alist '("\\.sqlt$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.body$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.spec$" . sql-mode))

;; sqlplus auto complete tables
(defvar ac-sqlplus-tables-cache nil)

(defun ac-sqlplus-table-candidates ()
  (or ac-sqlplus-tables-cache
      (set (make-local-variable 'ac-sqlplus-tables-cache)
           (mapcar 'downcase (mapcar 'car (cdr (assoc 'table (sqlplus-get-objects-alist))))))))

(ac-define-source sqlplus-tables
  '((candidates . ac-sqlplus-table-candidates)
    (symbol . "t")
    (cache)))

(defun ac-sqlplus-mode-setup ()
  (setq ac-sources (append '(ac-source-yasnippet ac-source-sqlplus-tables) ac-sources)))

(add-hook 'sqlplus-mode-hook 'ac-sqlplus-mode-setup)

(provide 'maio-sql)
