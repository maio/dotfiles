(setq ebook-convert-bin "/Applications/calibre.app/Contents/MacOS/ebook-convert")
(setq ebook-convert-options "--no-default-epub-cover --filter-css=background-color")

(require 'htmlize)
(require 's)

;; TODO
;; - turn off minor modes (flyspell, git gutter, ...)

(defun search-replace-in-buffer (search replace)
  (beginning-of-buffer)
  (while (re-search-forward search nil t) (replace-match replace)))

(defun buffer-to-epub (epub-file)
  (interactive "F")
  (when (not (s-ends-with? ".epub" epub-file))
    (error "Output file should have .epub extension."))
  (let ((html-buffer (htmlize-buffer (current-buffer)))
        (html-file (make-temp-file "buffer-to-epub" nil ".html")))
    (with-current-buffer html-buffer
      ;; htmlize output contains mix of pre and span tags but iBooks
      ;; uses different fonts for each. It ignores monospace css
      ;; setting for span tags so we have to replace them with inline
      ;; pre tags in order to get consistent look.
      (search-replace-in-buffer "<span" "<pre style=\"display: inline\"")
      (search-replace-in-buffer "</span" "</pre")
      (write-file html-file))
    (shell-command (format "%s %s %s %s" ebook-convert-bin html-file epub-file ebook-convert-options))))
