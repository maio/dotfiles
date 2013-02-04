(require 'helm)

(defvar helm-compile-locate-dominating-file ".git"
  "Locate dominating file before running compilation so that it's executed in
   correct directory (e.g. project root)")

(defun helm-compile--get-default-directory ()
  (locate-dominating-file (helm-default-directory) helm-compile-locate-dominating-file))

(defun helm-compile--buffer-for-command (command)
  (concat "*" (s-trim command) "*"))

(defun helm-compile---recompile (command)
  (switch-to-buffer (helm-compile--buffer-for-command command))
  (delete command compile-history)
  (push command compile-history)
  (recompile))

(defun helm-compile---compile (command &optional comint)
  (with-temp-buffer
    (with-helm-default-directory (helm-compile--get-default-directory)
        (progn
          (push command compile-history)
          (compile command comint)
          (with-current-buffer compilation-last-buffer
            (rename-buffer (helm-compile--buffer-for-command command)))))))

(defun helm-compile--compile (command &optional comint)
  (if (get-buffer (helm-compile--buffer-for-command command))
      (helm-compile---recompile command)
    (helm-compile---compile command comint)))

(defvar helm-c-source-compile
  '((name . "Compile")
    (dummy)
    (action
     . (("Compile" . (lambda (candidate)
                       (helm-compile--compile candidate)))
        ("Compile (Comint)" . (lambda (candidate)
                                (helm-compile--compile candidate t)))))))

(defvar helm-c-source-compile-history
  '((name . "Compile History")
    (candidates . (lambda () (delete-dups compile-history)))
    (action
     . (("Compile" . (lambda (candidate)
                       (helm-compile--compile candidate)))
        ("Compile (Comint)" . (lambda (candidate)
                                (helm-compile--compile candidate t)))
        ("Remove from history" . (lambda (ignore)
                                   (mapc (lambda (candidate) (delete candidate compile-history))
                                         (helm-marked-candidates))))))))

(defun helm-compile ()
  "Preconfigured `helm' for compile."
  (interactive)
  (helm-other-buffer
   '(helm-c-source-compile-history helm-c-source-compile)
   "*helm compile*"))

(provide 'helm-compile)
