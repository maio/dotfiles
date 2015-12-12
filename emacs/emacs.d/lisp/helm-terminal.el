(require 'f)
(require 's)
(require 'dash)
(require 'helm)

(defsubst terminal-buffer-p (buffer)
  "Test if BUFFER is a terminal buffer."
  (with-current-buffer buffer
    (or (in-mode? 'term-mode)
        (in-mode? 'eshell-mode))))

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
    (action . (("Show" . (lambda (candidate)
                           (progn
                             (switch-to-buffer candidate)
                             (delete-other-windows))))))))

(defun helm-terminal ()
  "Preconfigured `helm' for terminal."
  (interactive)
  (helm-other-buffer
   '(helm-c-source-terminal-buffers helm-c-source-new-terminal)
   "*helm terminal*"))

(add-to-list 'winner-boring-buffers "*helm terminal*")
(add-to-list 'winner-boring-buffers "*helm compile*")
(add-to-list 'winner-boring-buffers "*Helm Find Files*")

(provide 'helm-terminal)
