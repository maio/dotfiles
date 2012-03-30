(require 'cl)

(defmacro require-and-exec (feature &optional &rest body)
  "Require the feature and execute body if it was successfull loaded."
  (declare (indent 1))
  `(if (require ,feature nil 'noerror)
        (progn ,@body)
    (message (format "%s not loaded" ,feature))))

(defun in-mode? (mode)
  (eq major-mode mode))

(defun recompile-my-files ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d/" 0))

(defun toggle-comment-on-line-or-region ()
  "Comments or uncomments current current line or whole lines in region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position)
                                 (line-end-position))))

(defun edit-init () (interactive) (find-file "~/.emacs.d/init.el"))
(defun kill-current-buffer () (interactive) (kill-buffer (current-buffer)))
(defun kill-all-buffers ()
  (interactive)
    (mapc 'kill-buffer (buffer-list)))

(defun shell () (interactive) (eshell))

(defun my-eval-defun ()
  (interactive)
  (if (in-mode? 'clojure-mode)
      (lisp-eval-defun)
    (eval-defun nil)))

(provide 'maio-util)
