(require 'pulse)
(require 'clj-refactor)

(defun clojure-artifact-versions (artifact)
  (s-split " " (read (s-join " " (cljr--get-versions-from-middleware artifact)))))

(defun clojure-pulse-match (face)
  (pulse-momentary-highlight-region (match-beginning 0) (match-end 0) face))

(defun clojure-update-artifact (artifact)
  (interactive
   (list (thing-at-point 'symbol t)))
  ;; TODO: ignore when artifact is not found (version is "")
  (let ((available-version (first (clojure-artifact-versions artifact))))
    (save-excursion
      (re-search-forward "\"\\(.\*\\)\"")
      (let ((current-version (match-string-no-properties 1)))
        (if (equal current-version available-version)
            (clojure-pulse-match 'hi-yellow)
          (progn
           (replace-match (format "\"%s\"" available-version))
           (clojure-pulse-match 'hi-green)))))))

(define-key clj-refactor-map (kbd "C-c j u p") 'clojure-update-artifact)

(provide 'maio-clojure-refactor)
