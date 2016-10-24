(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(setq js2-basic-offset 2
      js-indent-level 2
      json-reformat:indent-width 2)

;; make node usable in comint mode
(setenv "NODE_NO_READLINE" "1")

(add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json" . json-mode))

(use-package js2-mode
  :defer t)

(use-package js2-refactor
  :defer t)

(use-package json-mode
  :defer t)

(use-package nodejs-repl
  :defer t
  :config
  (define-key js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-sexp)
  (when evil-mode
    (evil-define-key 'visual js2-mode-map (kbd "C-x C-e") 'nodejs-repl-send-region)))

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

(defun maio/js2-defaults ()
  (setq evil-shift-width 2)
  (setq tab-width 2))

(defun jsfmt-region (beg end)
  (interactive "r")
  ;; npm install -g jsfmt
  (perltidy-save-point
    (call-process-region beg end "jsfmt" t t t "--format=true")))

(with-eval-after-load 'js2-mode
  (require 'perltidy)
  (require 'smartparens)
  (add-hook 'js2-mode-hook 'maio/js2-defaults)
  (add-hook 'js2-mode-hook 'yas-minor-mode)
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
  (add-hook 'js2-mode-hook 'smartparens-mode)
  (define-key js2-mode-map (kbd "M-.") 'js2-jump-to-definition)
  (when evil-mode
    (evil-define-key 'visual js2-mode-map "=" 'indent-region)))

(with-eval-after-load 'json-mode
  (when evil-mode
    (evil-define-key 'visual json-mode-map "=" 'json-xs-region)))

(provide 'maio-javascript)
