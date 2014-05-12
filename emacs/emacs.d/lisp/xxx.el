(require 'smie)
(require 'erlang)

;; SMIE experiment
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/SMIE.html

(makunbound 'xxx-smie-grammar)
(makunbound 'xxx-keywords-regexp)

(defvar xxx-debug-indent nil)

(defvar xxx-indent-basic 4)

(defvar xxx-smie-grammar
  (smie-prec2->grammar
   (smie-bnf->prec2
    '((id)

      )
    '((assoc ";"))
    '((assoc ","))
    )
   ))

(defvar xxx-smie-grammar
  (smie-prec2->grammar
   (smie-bnf->prec2
    '((id)
      (inst (id "=" exp)
            (id "->" exp)
            (exp))
      (insts (insts "," insts) (inst))
      (exp (exp "+" exp)
           (exp "*" exp)
           ("[" exps "]")
           ("(" exps ")"))
      (exps (exps "," exps) (exp)))
    '((assoc ";"))
    '((assoc ","))
    '((assoc "+") (assoc "*")))))


(defun xxx-smie-rules (kind token)
  (when xxx-debug-indent (message "%s %s" kind token))
  (case kind
    (:elem
     (case token
       (basic (if (smie-rule-hanging-p)
                  (smie-rule-parent)
                xxx-indent-basic))))
    (:before
     (cond
      ((equal token "[")
       (if (and (smie-rule-hanging-p))
           (smie-rule-parent)
         xxx-indent-basic))))
    (:after
     (cond
      ((equal token "[")
       (if (and (smie-rule-hanging-p) (not (smie-rule-sibling-p)))
           (smie-rule-parent)
         xxx-indent-basic))))
    (:close-all nil)
    (:list-intro nil))
    )


(defvar xxx-keywords-regexp (regexp-opt '("[" "]" ";" "," "->" "*" ".")))

(defun xxx-smie-forward-token ()
  (forward-comment (point-max))
  (cond
   ((looking-at xxx-keywords-regexp)
    (goto-char (match-end 0))
    (match-string-no-properties 0))
   (t (buffer-substring-no-properties
       (point)
       (progn (skip-syntax-forward "w_")
              (point))))))

(defun xxx-smie-backward-token ()
  (forward-comment (- (point)))
  (cond
   ((looking-back xxx-keywords-regexp (- (point) 2) t)
    (goto-char (match-beginning 0))
    (match-string-no-properties 0))
   (t (buffer-substring-no-properties
       (point)
       (progn (skip-syntax-backward "w_")
              (point))))))


(define-derived-mode xxx-mode prog-mode "XXX"
  (erlang-syntax-table-init)
  (make-local-variable 'xxx-debug-indent)
  (make-local-variable 'comment-start)
  (setq comment-start "% ")
  (smie-setup xxx-smie-grammar
              #'xxx-smie-rules
              :forward-token #'xxx-smie-forward-token
              :backward-token #'xxx-smie-backward-token
              )
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'smie-indent-line)
  ;; (setq indent-tabs-mode t)
  )

(add-to-list 'auto-mode-alist '("\\.xxx" . xxx-mode))

(provide 'xxx)
