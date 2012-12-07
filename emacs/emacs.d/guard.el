(defgroup guard nil
  "Guard - Emacs Guard integration.")

(defvar guard-notify-hook nil
  "Generic guard notification hook. It will receive type, title and message.")
(defvar guard-notify-pending-hook nil
  "Hook for pending notifications. It will receive title and message.")
(defvar guard-notify-success-hook nil
  "Hook for success notifications. It will receive title and message.")
(defvar guard-notify-failed-hook nil
  "Hook for failed notifications. It will receive title and message.")

(defun guard-notify (type title body)
  (run-hook-with-args 'guard-notify-hook type title body)
  (let ((type-notify-hook (intern (concat "guard-notify-" type "-hook"))))
    (run-hook-with-args type-notify-hook title body)))

;;; notification handling

;; guard-notify-message
(require 's)

(defun guard-notify-message-get-buffer ()
  (with-current-buffer (get-buffer-create "*guard-message*")
    (compilation-minor-mode t)
    (current-buffer)))

(defun guard-notify-message-buffer-visible-p ()
  (when (get-buffer-window (guard-notify-message-get-buffer)) t))

(defun guard-notify-message-close-buffer (&rest ignore)
  (when (guard-notify-message-buffer-visible-p)
    (delete-window (get-buffer-window (guard-notify-message-get-buffer)))))

(defun guard-notify-message-show ()
  (interactive)
  (switch-to-buffer (guard-notify-message-get-buffer)))

(defun guard-message-body-preview (body)
  "Return first 7 lines of trimmed message body"
  (let ((lines (s-lines (s-trim body)))
        (max-lines 7))
    (s-join "\n" (subseq lines 0 (min max-lines (length lines))))))

(defun guard-notify-message (body)
  (with-current-buffer (guard-notify-message-get-buffer)
    (let ((prev-point (point)))
      (when (not (guard-notify-message-buffer-visible-p))
        (message (guard-message-body-preview body)))
      (erase-buffer)
      (insert (s-trim body))
      (goto-char prev-point))))

(defun guard-notify-message-failed-body (title body)
  (guard-notify-message body))

(defun guard-notify-message-success-body (title body)
  (guard-notify-message "PASS"))

(add-hook 'guard-notify-failed-hook 'guard-notify-message-failed-body)
(add-hook 'guard-notify-success-hook 'guard-notify-message-success-body)
(add-hook 'guard-notify-success-hook 'guard-notify-message-close-buffer)

;; guard-notify-modeline
(defcustom guard-notify-modeline-pending-color "Black"
  "Modeline color for pending notification"
  :group 'guard)
(defcustom guard-notify-modeline-success-color "ForestGreen"
  "Modeline color for success notification"
  :group 'guard)
(defcustom guard-notify-modeline-failed-color "Firebrick"
  "Modeline color for failed notification"
  :group 'guard)

(defun guard-notify-modeline (type title body)
  (let ((modeline-color (intern (concat "guard-notify-modeline-" type "-color"))))
    (set-face-background 'modeline (symbol-value modeline-color))))

(add-hook 'guard-notify-hook 'guard-notify-modeline)

(provide 'guard)