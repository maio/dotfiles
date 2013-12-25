(require 's)
(require 'dash)

(defvar recompile-on-save-buffers nil)

(defun recompile-on-save (buf)
  (interactive "bcompilation buffer: ")
  (add-to-list 'recompile-on-save-buffers (get-buffer buf)))

(defun ros--recompile-buffer (buf)
  (with-current-buffer buf (recompile)))

(defun ros--recompile-on-save ()
  (--each (--filter (s-starts-with? (with-current-buffer it default-directory)
                                    default-directory)
                    recompile-on-save-buffers)
    (ros--recompile-buffer it)))

(defun ros--recompile-on-save-cleanup ()
  (setq recompile-on-save-buffers
        (--filter (buffer-live-p it) recompile-on-save-buffers)))

(add-hook 'after-save-hook 'ros--recompile-on-save)
(add-hook 'kill-buffer-hook 'ros--recompile-on-save-cleanup)

(provide 'recompile-on-save)
