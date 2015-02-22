(with-eval-after-load 'clojure-mode
  (require 'cider)
  (define-key clojure-mode-map (kbd "<C-return>") 'cider-eval-defun-at-point)
  ;; add to sp-...-map instead of clojure-mode-map
  (define-key clojure-mode-map (kbd "M-q") 'sp-indent-defun)
  (define-key clojure-mode-map (kbd "M-r") 'sp-raise-sexp)
  (define-key clojure-mode-map (kbd "M-k") 'sp-kill-sexp)
  (define-key clojure-mode-map (kbd "C-)") 'sp-forward-slurp-sexp)
  (define-key clojure-mode-map (kbd "C-(") 'sp-forward-barf-sexp)
  (define-key clojure-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (when evil-mode
    (evil-define-key 'normal clojure-mode-map "D" 'sp-kill-hybrid-sexp)
    (evil-define-key 'normal clojure-mode-map (kbd "M-.") 'cider-jump-to-var)
    (evil-define-key 'normal clojure-mode-map (kbd "M-,") 'cider-jump-back))
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
  (define-key cider-repl-mode-map (kbd "s-l") 'cider-repl-clear-buffer)
  (define-key cider-repl-mode-map (kbd "C-x k") 'cider-quit)
  (define-key cider-repl-mode-map (kbd "s-k") 'cider-quit)
  (when evil-mode
    (defadvice cider-eval-defun-at-point (after evil-normal-state () activate)
      (evil-normal-state))
    (evil-define-key 'normal cider-repl-mode-map [escape] "gi")
    (evil-define-key 'normal cider-doc-mode-map "q" cider-popup-buffer-quit-function)
    (evil-define-key 'normal cider-stacktrace-mode-map "q" cider-popup-buffer-quit-function)))

(provide 'maio-clojure)
