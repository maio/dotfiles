(require 'f)
(require 's)
(require 'dash)
(require 'helm)

(defvar helm-compile-locate-dominating-file ".git"
  "Locate dominating file before running compilation so that it's executed in
   correct directory (e.g. project root)")

(defun helm-compile--get-default-directory ()
  (locate-dominating-file (helm-default-directory) helm-compile-locate-dominating-file))

(defun helm-compile--buffer-for-command (project command)
  (concat "*" project " " (s-trim command) "*"))

(defun helm-compile---switch-to-buffer (project command)
  (switch-to-buffer (helm-compile--buffer-for-command project command))
  (delete command compile-history)
  (push command compile-history))

(defun helm-compile---compile (project command &optional comint)
  (with-temp-buffer
    (progn
      (push command compile-history)
      (compile command comint)
      (with-current-buffer compilation-last-buffer
        (rename-buffer (helm-compile--buffer-for-command project command))))))

(defun helm-compile--compile (command &optional comint)
  (let* ((default-directory (helm-compile--get-default-directory))
         (project (f-base default-directory)))
    (if (get-buffer (helm-compile--buffer-for-command project command))
        (helm-compile---switch-to-buffer project command)
      (helm-compile---compile project command comint))))

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

(defvar helm-c-source-compilation-buffers
  '((name . "Compilation Buffer")
    (candidates . (lambda () (-filter 'compilation-buffer-p (helm-buffer-list))))
    (action
     . (("Compile" . (lambda (candidate)
                       (switch-to-buffer candidate)))))))

(defun helm-compile ()
  "Preconfigured `helm' for compile."
  (interactive)
  (when (and (buffer-file-name) (buffer-modified-p))
    (save-buffer))
  (helm-other-buffer
   '(helm-c-source-compilation-buffers helm-c-source-compile-history helm-c-source-compile)
   "*helm compile*"))

(add-to-list 'savehist-additional-variables 'compile-history)

(provide 'helm-compile)
