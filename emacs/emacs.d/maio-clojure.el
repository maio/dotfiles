(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'nrepl-mode))

(defun maio/nrepl ()
  (interactive)
  (if (nrepl-current-connection-buffer)
      (call-interactively 'nrepl-switch-to-repl-buffer)
    (call-interactively 'nrepl)))

(eval-after-load 'clojure-mode
  '(progn
     (require 'clojure-test-mode)
     (defadvice clojure-test-run-tests (before save activate) (save-buffer))
     (key-chord-define clojure-test-mode-map ";e" 'clojure-test-run-tests)
     (evil-define-key 'normal clojure-mode-map "gs" 'maio/nrepl)
     (evil-define-key 'normal clojure-mode-map (kbd "M-.") 'nrepl-jump)
     (add-hook 'clojure-mode-hook 'eldoc-mode)
     (define-clojure-indent  ;; for cucumber tests
       (Before 'defun)
       (After 'defun)
       (Given 'defun)
       (When 'defun)
       (Then 'defun))))

(eval-after-load 'nrepl
  '(progn
     (add-hook 'nrepl-mode-hook 'smartparens-mode)
     (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
     (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
     (key-chord-define nrepl-mode-map ";k" 'nrepl-quit)))

(provide 'maio-clojure)
