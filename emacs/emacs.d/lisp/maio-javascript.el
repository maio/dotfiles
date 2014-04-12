(setq js2-basic-offset 2)

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

(defvar jasmine-compilation-regexp
  '("Error: \\([^\n]+\\)\n\s+at .* (\\([^:]+\\):\\([[:digit:]]+\\):\\([[:digit:]]+\\))" 2 3 4 nil 1 (1 font-lock-warning-face))
  "jasmine errors regexp")

(with-eval-after-load 'js2-mode
  (require 'smartparens)
  (js2r-add-keybindings-with-prefix "s-r")
  ;; jasmine stuff
  (add-to-list 'compilation-error-regexp-alist-alist (cons 'jasmine jasmine-compilation-regexp))
  (add-to-list 'compilation-error-regexp-alist 'jasmine)
  (add-to-list 'js2-global-externs "it")
  (add-to-list 'js2-global-externs "describe")
  (add-to-list 'js2-global-externs "expect")
  (add-to-list 'js2-global-externs "beforeEach")
  (add-to-list 'js2-global-externs "afterEach")
  (add-to-list 'js2-global-externs "xdescribe")
  (add-to-list 'js2-global-externs "xit")
  (add-to-list 'js2-global-externs "spyOn")
  (add-to-list 'js2-global-externs "jasmine")
  ;; minor modes
  (add-hook 'js2-mode-hook 'yas-minor-mode-on)
  (add-hook 'js2-mode-hook 'smartparens-mode)
  (define-key js2-mode-map (kbd "SPC") 'maio/electric-space))

(with-eval-after-load 'json-mode
  (evil-define-key 'visual json-mode-map "=" 'json-xs-region))

(provide 'maio-javascript)
