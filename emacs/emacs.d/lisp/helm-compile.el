(require 'f)
(require 's)
(require 'dash)
(require 'helm)
(require 'compile)

(defvar helm-compile-pre-compilation-hook nil)
(defvar helm-compile-compilation-hook nil)

(defvar helm-compile-locate-dominating-file ".git"
  "Locate dominating file before running compilation so that it's executed in
   correct directory (e.g. project root)")

(setq helm-compile--recent-buffers nil)

(defun sort-by-recent (buffer-names)
  (-each (reverse (-map 'buffer-name helm-compile--recent-buffers))
    (lambda (recent)
      (if (-contains? buffer-names recent)
          (let ((n (remove recent buffer-names)))
            (add-to-list 'n recent)
            (setq buffer-names n))
        buffer-names)))
  buffer-names)

(defun helm-compile-add-recent (proc)
  (let ((buffer (current-buffer)))
    (setq helm-compile--recent-buffers (remove buffer helm-compile--recent-buffers))
    (add-to-list 'helm-compile--recent-buffers buffer)))

(add-hook 'compilation-start-hook 'helm-compile-add-recent)

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
      (switch-to-buffer compilation-last-buffer)
      (with-current-buffer compilation-last-buffer
        (rename-buffer (helm-compile--buffer-for-command project command))))))

(defun helm-compile--compile (command &optional comint)
  (let ((dir (helm-compile--get-default-directory)))
    (run-hooks 'helm-compile-pre-compilation-hook)
    (let* ((default-directory dir)
           (project (f-base default-directory)))
      (if (get-buffer (helm-compile--buffer-for-command project command))
          (helm-compile---switch-to-buffer project command)
        (helm-compile---compile project command comint))
      (run-hooks 'helm-compile-compilation-hook))))

(defvar helm-c-source-compile
  (helm-build-dummy-source
      "Compile"
    :action (helm-make-actions
             "Compile"
             (lambda (candidate)
               (helm-compile--compile candidate))
             "Compile (Comint)"
             (lambda (candidate)
               (helm-compile--compile candidate t)))))

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
    (candidates . (lambda () (sort-by-recent
                              (-filter 'compilation-buffer-p (helm-buffer-list)))))
    (action
     . (("Compile"
         . (lambda (candidate)
             (run-hooks 'helm-compile-pre-compilation-hook)
             (pop-to-buffer candidate)))
        ("Kill buffer"
         . (lambda (candidate)
             (mapc (lambda (candidate) (kill-buffer candidate))
                   (helm-marked-candidates))))))))

(defun helm-compile ()
  "Preconfigured `helm' for compile."
  (interactive)
  (when (and (buffer-file-name) (buffer-modified-p))
    (save-buffer))
  (helm-other-buffer
   '(helm-c-source-compilation-buffers helm-c-source-compile-history helm-c-source-compile)
   "*helm compile*"))

(add-hook 'helm-compile-compilation-hook 'delete-other-windows)

(provide 'helm-compile)
