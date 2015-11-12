(setq cider-prompt-for-symbol nil
      cider-interactive-eval-output-destination 'output-buffer)

(defun clojure-reload ()
  ;; requires org.clojure/tools.namespace
  ;; {:user {:dependencies [[org.clojure/tools.namespace "0.2.10"]]}}
  (interactive)
  (message "Reloading changed namespaces...")
  (let ((nrepl-sync-request-timeout 60))
    (nrepl-sync-request:eval "(require 'clojure.tools.namespace.repl)
                              (clojure.tools.namespace.repl/refresh)"
                             (cider-default-connection)
                             (cider-current-session))))

(defun clojure-autotest-reload-cb ()
  (clojure-reload)
  (cider-test-run-tests nil)
  (remove-hook 'cider-file-loaded-hook 'clojure-autotest-reload-cb))

(defun clojure-autotest-cb ()
  (cider-test-run-tests nil)
  (remove-hook 'cider-file-loaded-hook 'clojure-autotest-cb))


(defun clojure-autotest (&optional reload)
  (interactive "P")
  (force-save-buffer)
  (when (and (not (s-ends-with? ".cljs" (buffer-file-name)))
             (not (s-ends-with? "project.clj" (buffer-file-name)))
             (not (s-ends-with? "profiles.clj" (buffer-file-name))))
    (if reload
        (add-hook 'cider-file-loaded-hook 'clojure-autotest-reload-cb)
      (add-hook 'cider-file-loaded-hook 'clojure-autotest-cb))
    ;; cider should do this?
    (save-restriction
      (widen)
      (cider-load-buffer))))

(defun clojure-hippie-expand-setup ()
  (make-local-variable 'hippie-expand-try-functions-list)
  (setq hippie-expand-try-functions-list '(try-expand-dabbrev)))

(with-eval-after-load 'clojure-mode
  (require 'cider)
  (define-key clojure-mode-map (kbd "<C-return>") 'cider-eval-defun-at-point)
  (define-key clojure-mode-map (kbd "<M-return>") 'cider-inspect)
  ;; add to sp-...-map instead of clojure-mode-map
  (define-key clojure-mode-map (kbd "M-q") 'sp-indent-defun)
  (define-key clojure-mode-map (kbd "M-r") 'sp-raise-sexp)
  (define-key clojure-mode-map (kbd "M-k") 'sp-kill-sexp)
  (define-key clojure-mode-map (kbd "M-s") 'sp-split-sexp)
  (define-key clojure-mode-map (kbd "C-)") 'sp-forward-slurp-sexp)
  (define-key clojure-mode-map (kbd "C-(") 'sp-forward-barf-sexp)
  (define-key clojure-mode-map (kbd "M-C-f") 'sp-end-of-next-sexp)
  (define-key clojure-mode-map (kbd "C-k") 'sp-kill-hybrid-sexp)
  (define-key clojure-mode-map (kbd "M-J") 'sp-join-sexp)
  (define-key clojure-mode-map (kbd "s-s") 'clojure-autotest)
  (when evil-mode
    (evil-define-key
      'insert clojure-mode-map (kbd "<C-return>") 'cider-eval-defun-at-point)
    (evil-define-key
      'insert clojure-mode-map (kbd "<backspace>") 'sp-backward-delete-char)
    (evil-define-key
      'visual clojure-mode-map (kbd "<return>") 'cider-eval-region)
    (evil-define-key 'normal clojure-mode-map "D" 'sp-kill-hybrid-sexp)
    (evil-define-key 'normal clojure-mode-map (kbd "M-.") 'cider-jump-to-var)
    (evil-define-key 'normal clojure-mode-map (kbd "M-,") 'cider-jump-back))
  (add-hook 'clojure-mode-hook 'eldoc-mode)
  (add-hook 'clojure-mode-hook 'clojure-hippie-expand-setup)
  (define-clojure-indent
    (async 'defun)
    (go 'defun)
    (go-try 'defun)
    (go-with-channel 'defun)
    (go-with-return-to 'defun)
    ;; om/cljs
    (this-as 'defun)
    (init-state 'defun)
    (render 'defun)
    (render-state 'defun)
    (did-mount 'defun)
    (did-update 'defun)
    (will-mount 'defun)
    (will-unmount 'defun)
    (should-update 'defun)
    (will-update 'defun)
    (did-update 'defun)
    (dom/div 'defun)
    (dom/ul 'defun)
    (dom/li 'defun)
    (dom/a 'defun)
    (dom/button 'defun)
    (dom/tr 'defun)
    (dom/td 'defun)

    ;; misc
    (component 'defun)
    (testscript 'defun)
    ;; cucumber
    (Before 'defun)
    (After 'defun)
    (Given 'defun)
    (When 'defun)
    (Then 'defun))
  )

(with-eval-after-load 'cider
  (add-hook 'cider-repl-mode-hook 'turn-on-smartparens-strict-mode)
  (define-key cider-test-report-mode-map "j" 'cider-test-next-result)
  (define-key cider-test-report-mode-map "k" 'cider-test-previous-result)
  (define-key cider-test-report-mode-map (kbd "<return>") 'cider-test-jump)
  (define-key cider-repl-mode-map (kbd "s-L") 'cider-repl-clear-buffer)
  (define-key cider-repl-mode-map (kbd "C-x k") 'cider-quit)
  (define-key cider-repl-mode-map (kbd "s-K") 'cider-quit)
  (define-key cider-inspector-mode-map (kbd "M-,") 'cider-inspector-pop)
  (when evil-mode
    (evil-define-key 'normal clojure-mode-map (kbd "s-L") 'sp-down-sexp)
    (evil-define-key 'normal clojure-mode-map (kbd "s-H") 'sp-backward-up-sexp)
    (evil-define-key 'normal clojure-mode-map (kbd "s-J") 'sp-next-sexp)
    (evil-define-key 'normal clojure-mode-map (kbd "s-K") 'sp-backward-sexp)
    (evil-define-key 'normal clojure-mode-map "(" 'maio/jump-brace)
    (evil-define-key 'normal clojure-mode-map ")" 'sp-end-of-next-sexp)
    (evil-define-key 'normal clojure-mode-map (kbd "s-d") 'sp-clone-sexp)

    (defadvice cider-eval-defun-at-point (after evil-normal-state () activate)
      (evil-normal-state))
    ;; this is also visible in regular clojure mode
    ;; (evil-define-key 'normal cider-repl-mode-map [escape] "gi")
    (evil-define-key 'normal cider-popup-buffer-mode-map "q" cider-popup-buffer-quit-function)
    (evil-define-key 'normal cider-doc-mode-map "q" cider-popup-buffer-quit-function)
    (evil-define-key 'normal cider-stacktrace-mode-map "q" cider-popup-buffer-quit-function)))

(provide 'maio-clojure)
