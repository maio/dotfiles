(require 'generic-x)

(defun yapp-get-rule-name () (symbol-name (symbol-at-point)))
(defun yapp-beginning-of-rule () (re-search-backward "^\\w+\\W*:" 0 t))

(defun yapp-mode-config ()
  (run-hooks 'prog-mode-hook)
  (flycheck-mode)
  (setq buffer-offer-save t)
  (maio/setup-tab-indent)
  (setq imenu-extract-index-name-function 'yapp-get-rule-name)
  (setq imenu-prev-index-position-function 'yapp-beginning-of-rule))

(define-generic-mode 'yapp-mode
  '("#")
  '()
  '()
  '("\\.yp$")
  '(yapp-mode-config)
  "A mode for YAPP")

(eval-after-load 'flycheck
  '(progn
     (flycheck-define-checker yapp
       "An YAPP syntax checker."
       :command ("yapp" source)
       :error-patterns
       ((error line-start "*Error* " (message) ", at line " line "." line-end))
       :modes yapp-mode)

     (add-to-list 'flycheck-checkers 'yapp)))

(provide 'maio-modes)
