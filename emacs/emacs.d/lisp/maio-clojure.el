;; doesn't work
(defun maio/nrepl ()
  (interactive)
  (if (nrepl-current-connection-buffer)
      (call-interactively 'cider-switch-to-repl-buffer)
    (call-interactively 'nrepl)))

(defun maio/delete-nrepl-error-window ()
  (interactive)
  (when (get-buffer "*nrepl-error*")
    (let ((nrepl-error-window (get-buffer-window (get-buffer "*nrepl-error*"))))
      (when nrepl-error-window
        (delete-window nrepl-error-window)))))

(eval-after-load 'clojure-mode
  '(progn
     (require 'midje-mode)
     (require 'clojure-test-mode)
     (defadvice clojure-test-run-tests (before clear-and-save activate)
       (maio/delete-nrepl-error-window)
       (midje-clear-comments)
       (save-buffer))
     (defadvice clojure-test-highlight-problem (after comment (line event message pp-actual) activate)
       (save-excursion
         (goto-char (point-min))
         (forward-line (1- line))
         (beginning-of-line)
         (call-interactively 'open-line)
         (indent-according-to-mode)
         (midje-insert-failure-message message)))
     (evil-define-key 'normal clojure-mode-map "gs" 'maio/nrepl)
     (evil-define-key 'normal clojure-mode-map (kbd "M-.") 'nrepl-jump)
     (add-hook 'clojure-mode-hook 'eldoc-mode)
     (define-clojure-indent  ;; for cucumber tests
       (go 'defun)
       (Before 'defun)
       (After 'defun)
       (Given 'defun)
       (When 'defun)
       (Then 'defun))))

(eval-after-load 'cider
  '(progn
     (add-hook 'cider-repl-mode-hook 'turn-on-smartparens-strict-mode)
     (define-key cider-repl-mode-map (kbd "C-x k") 'cider-quit)))

(provide 'maio-clojure)
