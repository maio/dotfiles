(require 'f)

(defun magit-branch-notes-file ()
  (f-join ".git" "info" (concat (magit-get-current-branch) ".org")))

(defun magit-edit-branch-notes-file ()
  (interactive)
  (find-file (magit-branch-notes-file)))

(defun magit-insert-notes ()
  (when (file-exists-p (magit-branch-notes-file))
    (magit-with-section (section notes 'notes "Notes:" t)
      (insert
       (with-temp-buffer
         (insert-file-contents (magit-branch-notes-file))
         (buffer-string)))
      (insert "\n"))))

(provide 'maio-magit-notes)
