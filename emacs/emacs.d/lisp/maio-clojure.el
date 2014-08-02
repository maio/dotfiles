(with-eval-after-load 'clojure-mode
  ;; For some reason this will define M-. in lisp-mode-shared-map (report bug?)
  ;; (evil-define-key 'normal clojure-mode-map (kbd "M-.") 'cider-jump)
  (define-key clojure-mode-map (kbd "<C-return>") 'cider-eval-defun-at-point)
  (define-key clojure-mode-map (kbd "M-.") 'cider-jump)
  (define-key clojure-mode-map (kbd "M-,") 'cider-jump-back)
  (add-hook 'clojure-mode-hook 'eldoc-mode)
  (define-clojure-indent ;; for cucumber tests
    (go 'defun)
    (Before 'defun)
    (After 'defun)
    (Given 'defun)
    (When 'defun)
    (Then 'defun)))

(with-eval-after-load 'cider
  (add-hook 'cider-repl-mode-hook 'turn-on-smartparens-strict-mode)
  (define-key cider-repl-mode-map (kbd "C-x k") 'cider-quit)
  (defadvice cider-eval-defun-at-point (after evil-normal-state () activate)
    (evil-normal-state))
  (evil-define-key 'normal cider-doc-mode-map "q" cider-popup-buffer-quit-function)
  (evil-define-key 'normal cider-stacktrace-mode-map "q" cider-popup-buffer-quit-function))

(provide 'maio-clojure)
