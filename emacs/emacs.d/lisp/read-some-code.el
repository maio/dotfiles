(setq ebook-convert-bin "/Applications/calibre.app/Contents/MacOS/ebook-convert")
(setq ebook-convert-options "--no-default-epub-cover --filter-css=background-color")

(require 'htmlize)
(require 's)

;; TODO
;; - turn off minor modes (flyspell, git gutter, ...)

(defun buffer-to-epub (epub-file)
  (interactive "F")
  (when (not (s-ends-with? ".epub" epub-file))
    (error "Output file should have .epub extension."))
  (let ((html-buffer (htmlize-buffer (current-buffer)))
        (html-file (make-temp-file "buffer-to-epub" nil ".html")))
    (with-current-buffer html-buffer
      ;; htmlize output contains mix of pre and span tags but iBooks
      ;; uses different fonts for each and resulting document looks
      ;; weird. div uses same font as span so this should fix it.
      (while (re-search-forward "</?\\(pre\\)" nil t)
        (replace-match "div style=\"font-family: monospace; white-space: pre-wrap;\"" nil nil nil 1))
      (write-file html-file))
    (shell-command (format "%s %s %s %s" ebook-convert-bin html-file epub-file ebook-convert-options))))
