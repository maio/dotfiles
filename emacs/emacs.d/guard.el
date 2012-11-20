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

(defun guard-message-body-preview ()
  "Return first 7 lines of trimmed message body"
  (s-join "\n" (subseq (s-lines (s-trim body)) 0 7)))

(defun guard-notify-message-body (title body)
  (message (guard-message-body-preview body)))

(add-hook 'guard-notify-failed-hook 'guard-notify-message-body)

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
