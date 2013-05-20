(setq-default compilation-scroll-output t)
(require 'compile)

;; required by guard emacs notifier
(put 'modeline 'face-alias 'mode-line)

;; phpunit errors
(add-to-list 'compilation-error-regexp-alist
             '("^\\(.*?\\):\\([0-9]+\\)$" 1 2))

(defvar guard-suspended-p nil)

(defun guard-send-signal (signal)
  ;; handle when guard is not running - pkill returns non-zero exit code
  (shell-command (concat "pkill -" signal " -u `id -u -n` -f 'ruby.*guard'")))

(defun guard-suspend ()
  (message "suspending guard")
  (guard-send-signal "USR1"))

(defun guard-resume ()
  (message "resuming guard")
  (guard-send-signal "USR2"))

(defun guard ()
  (interactive)
  (server-start)
  (let ((old-path default-directory)
        (compilation-scroll-output t))
    (cd (locate-dominating-file default-directory "Guardfile"))
    (guard-start)
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
