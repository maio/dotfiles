(require 's)
(require 'dash)

(defvar recompile-on-save-hash (make-hash-table))

(defun recompile-on-save (buf)
  (interactive "bcompilation buffer: ")
  (puthash (current-buffer) (get-buffer buf) recompile-on-save-hash))

(defun ros--recompile-on-save ()
  (-when-let (compilation-buffer (gethash (current-buffer) recompile-on-save-hash))
    (with-current-buffer compilation-buffer (recompile))))

(defun ros--recompile-on-save-cleanup ()
  (maphash (lambda (key value)
             (when (not (and (buffer-live-p key)
                             (buffer-live-p value)))
               (remhash key recompile-on-save-hash))) recompile-on-save-hash))

(add-hook 'after-save-hook 'ros--recompile-on-save)
(add-hook 'kill-buffer-hook 'ros--recompile-on-save-cleanup)

(provide 'recompile-on-save)
