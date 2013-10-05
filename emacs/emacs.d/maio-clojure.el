(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'nrepl-mode))

(defun maio/nrepl ()
  (interactive)
  (if (nrepl-current-connection-buffer)
      (call-interactively 'nrepl-switch-to-repl-buffer)
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
     (key-chord-define clojure-test-mode-map ";w" 'clojure-test-run-tests)
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
     (key-chord-define nrepl-repl-mode-map ";k" 'nrepl-quit)))

(provide 'maio-clojure)
