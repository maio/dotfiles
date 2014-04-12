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

(with-eval-after-load 'js2-mode
  (require 'smartparens)
  (js2r-add-keybindings-with-prefix "C-c C-m")
  ;; jasmine stuff
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
  (add-hook 'js2-mode-hook 'smartparens-mode))

(with-eval-after-load 'json-mode
  (evil-define-key 'visual json-mode-map "=" 'json-xs-region))

(provide 'maio-javascript)
