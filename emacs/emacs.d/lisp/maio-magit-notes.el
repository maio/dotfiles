(defun maybe-read-file-to-string (fname)
  (when (file-exists-p fname) (flymake-read-file-to-string fname)))

(defun magit-branch-notes-file ()
  (s-concat ".git/info/" (magit-get-current-branch) ".org"))

(defun magit-edit-branch-notes-file ()
  (interactive)
  (find-file (magit-branch-notes-file)))

(defun magit-insert-notes ()
  (let ((notes (maybe-read-file-to-string (magit-branch-notes-file))))
    (when notes
      (magit-with-section (section notes 'notes "Notes:" t)
        (insert notes)
        (insert "\n")))))

(provide 'maio-magit-notes)
