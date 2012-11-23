(setq-default compilation-scroll-output t)
(require 'compile)

;; phpunit errors
(add-to-list 'compilation-error-regexp-alist
             '("^\\(.*?\\):\\([0-9]+\\)$" 1 2))

(defvar guard-suspended-p nil)

(defun guard-send-signal (signal)
  (shell-command (concat "pkill -" signal " -u " (user-login-name) " -f 'ruby.*guard'")))

(defun guard-suspend ()
  (message "suspending guard")
  (guard-send-signal "USR1"))

(defun guard-resume ()
  (message "resuming guard")
  (guard-send-signal "USR2"))

(defadvice magit-pull (before guard-suspend () activate)
  (setq guard-suspended-p t)
  (guard-suspend))

(defadvice magit-process-sentinel (after guard-resume () activate)
  (when guard-suspended-p
    (setq guard-suspended-p nil)
    (guard-resume)))

(defun guard ()
  (interactive)
  (server-start)
  (let ((old-path default-directory)
        (compilation-scroll-output t))
    (cd (helm-ls-git-root-dir))
    (compile "make guard")
    (other-buffer-or-window)
    (rename-buffer "*guard*")
    (other-buffer-or-window)
    (cd old-path)))

(defun guard-or-goto-guard ()
  (interactive)
  (if (get-buffer "*guard*")
      (progn
        (switch-to-buffer "*guard*")
        (end-of-buffer))
    (guard)))

(defun guard-goto-first-error ()
  (interactive)
  (with-current-buffer (guard-notify-message-get-buffer)
    (goto-char 0)
    (compilation-next-error 1)
    (compile-goto-error)))

(provide 'maio-guard)
