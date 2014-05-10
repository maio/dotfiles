(require 'smie)

;; SMIE experiment
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/SMIE.html

(makunbound 'xxx-smie-grammar)
(makunbound 'xxx-keywords-regexp)

(defvar xxx-indent-basic 4)

(defvar xxx-smie-grammar
  (smie-prec2->grammar
   (smie-bnf->prec2
    '((id)
      (inst ("begin" insts "end")
            (exp))
      (insts (insts ";" insts) (inst))
      (exp ("[" exps "]")
           ("(" exps ")"))
      (exps (exps "," exps) (exp))
      )
    '((assoc ";"))
    '((assoc ","))
    )
   ))

(defun xxx-smie-rules (kind token)
  (message "%s %s" kind token)
  (case kind
    (:elem
     (case token
       (basic xxx-indent-basic)))
    (:after
     (cond
      ((equal token "[")
       (when (smie-rule-hanging-p)
         (when (not (smie-rule-prev-p "["))
           (smie-rule-parent))))))
    (:before
     (cond
      ((equal token "[")
       (when (smie-rule-hanging-p)
         (smie-rule-parent)))
      ((equal token ",")
       (when (smie-rule-bolp) (smie-rule-parent)))))
    (:list-intro 0))
  )

(defvar xxx-keywords-regexp
  (regexp-opt '("+" "*" "," ";" ">" ">=" "<" "<=>" "<=" "=")))

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

(defun try-reformat ()
  (interactive)
  ;; (highlight-changes-mode 0)
  (revert-buffer nil t)
  ;; (highlight-changes-mode t)
  (evil-indent (point-min) (point-max)))

(global-set-key (kbd "s-r") 'revert-buffer)
(global-set-key (kbd "s-i") 'try-reformat)

;; :after [
;; :before [
;; :before (
;; :elem basic

  ;; (case kind
  ;;   (:elem
  ;;    (case token
  ;;      (basic xxx-indent-basic)))
  ;;   (:after
  ;;    (cond
  ;;     ((equal token ",") (smie-rule-separator kind))
  ;;     ((equal token "[") xxx-indent-basic)
  ;;     ((equal token "=") xxx-indent-basic)))
  ;;   (:before
  ;;    (cond
  ;;     ((equal token ",") (smie-rule-separator kind))
  ;;     ((member token '("begin" "(" "{" "["))
  ;;      (if (smie-rule-hanging-p) 0))
  ;;     ((equal token "if")
  ;;      (and (not (smie-rule-bolp)) (smie-rule-prev-p "else")
  ;;           (smie-rule-parent)))))
  ;;   )

(define-derived-mode xxx-mode prog-mode "XXX"
  (make-local-variable 'comment-start)
  (setq comment-start "% ")
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "%+\\s *")
  ;; (make-local-variable 'comment-column)
  ;; (setq comment-column 48)
  (smie-setup xxx-smie-grammar
              #'xxx-smie-rules
              ;; :forward-token #'xxx-smie-forward-token
              ;; :backward-token #'xxx-smie-backward-token
              )
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'smie-indent-line)
  ;; (setq indent-tabs-mode t)
  ;; (setq tab-width 4)
  )


(add-to-list 'auto-mode-alist '("\\.xxx" . xxx-mode))

(provide 'xxx)
