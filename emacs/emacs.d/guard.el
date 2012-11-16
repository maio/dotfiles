(defvar guard-notify-pending-hook nil "Pending notification")
(defvar guard-notify-success-hook nil "Success notification")
(defvar guard-notify-failed-hook nil "Failed notification")

(defun guard-notify (type title body)
  (let ((notify-hook (intern (concat "guard-notify-" type "-hook"))))
    (run-hook-with-args notify-hook title body)))

;;; notification handling

;; guard-notify-message
(defun guard-notify-message-body (title body)
  (message body))

(add-hook 'guard-notify-failed-hook 'guard-notify-message-body)

;; guard-notify-modeline
(defcustom guard-notify-modeline-pending-color "Black"
  "Modeline color for pending notification")

(defun guard-notify-modeline-pending (title body)
  (set-face-background 'modeline guard-notify-modeline-pending-color))

(defun guard-notify-modeline-success (title body)
  (set-face-background 'modeline "ForestGreen"))

(defun guard-notify-modeline-failed (title body)
  (set-face-background 'modeline "Firebrick"))

(add-hook 'guard-notify-pending-hook 'guard-notify-modeline-pending)
(add-hook 'guard-notify-success-hook 'guard-notify-modeline-success)
(add-hook 'guard-notify-failed-hook 'guard-notify-modeline-failed)

(provide 'guard)
