(require 'smie)

;; https://github.com/ThibautVerron/magma-mode/blob/cbf40b79ba4ec0b44c82e940de99930d081ea7f3/magma-smie.el

(defcustom eerlang-indent-basic 4 "Indentation of blocks"
  :group 'eerlang
  :type 'integer)

(makunbound 'eerlang-smie-grammar)

(defvar eerlang-smie-grammar
  (smie-prec2->grammar
   (smie-bnf->prec2
    '(
      (id)
      (statements
       (statement)
       (statement "," statement))
      (statement
       ("case" expr "of" match-statements "end"))
      (match-statements
       (match-statement ";" match-statement)
       (match-statement))
      (match-statement
       (statement "->" statements))
      )
    )))

(defun eerlang-smie-rules (kind token)
  (message "kind: %s token: %s" kind token)
  (pcase (cons kind token)
    (`(:elem . basic) eerlang-indent-basic)
    ;; (`(:before . "-module") 0)
    ;; (`(:before . "-export") 0)
    ;; (`(:before . "(") eerlang-indent-basic)
    ;; (`(:before . "[") eerlang-indent-basic)
    ;; (_ (smie-rule-parent))
    )
  )

(defvar eerlang-keywords-regexp
  (regexp-opt '("-module" "-export", "," "->" "case" "end" "fun" "true" "false", "[" "]", "(" ")")))

(defun eerlang-smie-forward-token ()
  (forward-comment (point-max))
  (cond
   ((looking-at eerlang-keywords-regexp)
    (goto-char (match-end 0))
    (match-string-no-properties 0))
   (t (buffer-substring-no-properties
       (point)
       (progn (skip-syntax-forward "w_")
              (point))))))

(defun eerlang-smie-backward-token ()
  (forward-comment (- (point)))
  (cond
   ((looking-back eerlang-keywords-regexp (- (point) 2) t)
    (goto-char (match-beginning 0))
    (match-string-no-properties 0))
   (t (buffer-substring-no-properties
       (point)
       (progn (skip-syntax-backward "w_")
              (point))))))


(define-derived-mode eerlang-mode prog-mode "Eerlang"
  (make-local-variable 'comment-start)
  (setq comment-start "%")
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "%+\\s *")
  (make-local-variable 'comment-column)
  (setq comment-column 48)
  (smie-setup eerlang-smie-grammar
              #'eerlang-smie-rules
              :forward-token #'eerlang-smie-forward-token
              :backward-token #'eerlang-smie-backward-token)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'smie-indent-line)
  (setq indent-tabs-mode t)
  (setq tab-width 4))

(add-to-list 'auto-mode-alist '("\\.erl" . eerlang-mode))

(provide 'eerlang)
