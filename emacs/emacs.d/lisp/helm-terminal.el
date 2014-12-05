(require 'f)
(require 's)
(require 'dash)
(require 'helm)

(defsubst terminal-buffer-p (buffer)
  "Test if BUFFER is a terminal buffer."
  (with-current-buffer buffer
    (in-mode? 'term-mode)))

(defun helm-terminal--new (name)
  (ansi-term (getenv "SHELL"))
  (rename-buffer (format "*%s*" name)))

(defvar helm-c-source-new-terminal
  '((name . "New Terminal")
    (dummy)
    (action
     . (("Open Here" . (lambda (candidate) (helm-terminal--new candidate)))))))

(defvar helm-c-source-terminal-buffers
  '((name . "Terminal Buffer")
    (candidates . (lambda () (-filter 'terminal-buffer-p (helm-buffer-list))))
    (action . (("Show" . (lambda (candidate) (switch-to-buffer candidate)))))))

(defun helm-terminal ()
  "Preconfigured `helm' for terminal."
  (interactive)
  (helm-other-buffer
   '(helm-c-source-terminal-buffers helm-c-source-new-terminal)
   "*helm terminal*"))

(provide 'helm-terminal)
