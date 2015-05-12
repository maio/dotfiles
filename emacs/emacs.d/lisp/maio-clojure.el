(defun clojure-reload ()
  ;; TODO: throw error when this fails
  (nrepl-sync-request:eval "(require 'clojure.tools.namespace.repl)
                            (clojure.tools.namespace.repl/refresh)"))

(defun clojure-autotest-cb ()
  (clojure-reload)
  (cider-test-run-tests nil)
  (remove-hook 'cider-file-loaded-hook 'clojure-autotest-cb))

(defun clojure-autotest ()
  (interactive)
  (force-save-buffer)
  (add-hook 'cider-file-loaded-hook 'clojure-autotest-cb)
  (cider-load-buffer))

(defun clojure-hippie-expand-setup ()
  (make-local-variable 'hippie-expand-try-functions-list)
  (setq hippie-expand-try-functions-list '(try-expand-dabbrev)))

(defun clojure-refactor-setup ()
  (clj-refactor-mode 1)
  (cljr-add-keybindings-with-prefix "C-c j")
  (require 'maio-clojure-refactor)
  (add-hook 'cider-connected-hook #'cljr-update-artifact-cache)
  (add-hook 'cider-connected-hook #'cljr-warm-ast-cache))

(with-eval-after-load 'clojure-mode
  (require 'cider)
  (define-key clojure-mode-map (kbd "<C-return>") 'cider-eval-defun-at-point)
  ;; add to sp-...-map instead of clojure-mode-map
  (define-key clojure-mode-map (kbd "M-q") 'sp-indent-defun)
  (define-key clojure-mode-map (kbd "M-r") 'sp-raise-sexp)
  (define-key clojure-mode-map (kbd "M-k") 'sp-kill-sexp)
  (define-key clojure-mode-map (kbd "M-s") 'sp-split-sexp)
  (define-key clojure-mode-map (kbd "C-)") 'sp-forward-slurp-sexp)
  (define-key clojure-mode-map (kbd "C-(") 'sp-forward-barf-sexp)
  (define-key clojure-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (define-key clojure-mode-map (kbd "s-s") 'clojure-autotest)
  (when evil-mode
    (evil-define-key 'normal clojure-mode-map "D" 'sp-kill-hybrid-sexp)
    (evil-define-key 'normal clojure-mode-map (kbd "M-.") 'cider-jump-to-var)
    (evil-define-key 'normal clojure-mode-map (kbd "M-,") 'cider-jump-back))
  (add-hook 'clojure-mode-hook 'eldoc-mode)
  (add-hook 'clojure-mode-hook 'clojure-hippie-expand-setup)
  (add-hook 'clojure-mode-hook 'clojure-refactor-setup)
  (define-clojure-indent ;; for cucumber tests
    (go 'defun)
    (go-with-channel 'defun)
    (testscript 'defun)
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
