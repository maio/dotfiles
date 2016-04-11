(require 'company)
(require 'company-dabbrev-code)

(defun maio-company-candidates (prefix)
  (let ((started-at (point))
        (seen (make-hash-table :test 'equal))
        candidates)
    (puthash prefix t seen)
    (save-excursion
      ;; turn off narrow?
      (goto-char (point-min))
      (while (< (point) started-at)
        (re-search-forward (company-dabbrev-code--make-regexp prefix))
        (let ((symbol (thing-at-point 'symbol t)))
          (when (not (gethash symbol seen))
            (puthash symbol t seen)
            (add-to-list 'candidates symbol))))
      candidates)))

(defun company-maio (command &optional arg &rest ignored)
  "`company-mode' completion backend."
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-maio))
    (prefix (or (company-grab-symbol) 'stop))
    (candidates
     (let* ((case-fold-search nil)
            (words (maio-company-candidates arg)))
       (company-dabbrev--filter arg words)))
    (ignore-case nil)
    (sorted t)
    (no-cache t)
    (duplicates nil)))

(setq company-backends '(company-maio))

(provide 'maio-company)
