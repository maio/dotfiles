(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))

(defmacro json-xs-save-point (&rest body)
  (declare (indent 0) (debug t))
  `(let ((old-point (point)))
     ,@body
     (goto-char old-point)))

(defun json-xs-region (beg end)
  "Tidy JSON in the region."
  (interactive "r")
  (json-xs-save-point
    (call-process-region beg end "json_xs" t t)))

(eval-after-load 'js2-mode
  '(progn
     (require 'smartparens)
     (add-hook 'js2-mode-hook 'smartparens-mode)))

(eval-after-load 'json-mode
  '(progn
     (evil-define-key 'visual json-mode-map "=" 'json-xs-region)))

(provide 'maio-javascript)
