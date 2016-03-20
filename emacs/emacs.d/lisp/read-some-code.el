(require 'htmlize)
(require 's)
(require 'f)

(setq ebook-convert-bin "/Applications/calibre.app/Contents/MacOS/ebook-convert")
(setq ebook-convert-options "--filter-css=background-color")
(when load-file-name
  (setq ebook-cover (f-join (file-name-directory load-file-name) "read-some-code-cover.png")))

;; TODO
;; - turn off minor modes (flyspell, git gutter, ...)

(defun search-replace-in-buffer (search replace)
  (save-excursion
    (beginning-of-buffer)
    (while (re-search-forward search nil t) (replace-match replace))))

(defun buffer-to-epub (epub-file)
  (interactive "FOutput file (.epub): ")
  (let ((epub-file (if (f-ext? epub-file "epub")
                       epub-file
                     (concat epub-file ".epub")))
        (html-buffer (htmlize-buffer (current-buffer)))
        (author (s-replace "-mode" "" (format "%s" major-mode)))
        (html-file (make-temp-file "buffer-to-epub" nil ".html")))
    (with-current-buffer html-buffer
      ;; htmlize output contains mix of pre and span tags but iBooks
      ;; uses different fonts for each. It ignores monospace css
      ;; setting for span tags so we have to replace them with inline
      ;; pre tags in order to get consistent look.
      (search-replace-in-buffer "<span" "<pre style=\"display: inline\"")
      (search-replace-in-buffer "</span" "</pre")
      (search-replace-in-buffer "<hr />" "<div style=\"page-break-before:always;\"></div>")
      (write-file html-file))
    (shell-command
     (s-join " " (list ebook-convert-bin
                       (format "\"%s\"" html-file)
                       (format "\"%s\"" epub-file)
                       ebook-convert-options
                       (concat "--authors=" author)
                       (when ebook-cover
                         (concat "--cover=" ebook-cover)))))))

(provide 'read-some-code)
