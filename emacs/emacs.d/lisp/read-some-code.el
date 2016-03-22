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

(defun defun-page-breaks ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (while (not (= (point) (point-max)))
      (end-of-defun)
      (insert "\n")
      (when (not (looking-at "\n"))
        (insert "\n")))))

(defun buffer-to-epub (epub-file)
  (interactive "FOutput file (.epub): ")
  (let ((source (current-buffer))
        (source-mode major-mode)
        (source-name (buffer-name)))
    (with-temp-buffer
      (insert-buffer-substring source)
      (funcall source-mode)
      (font-lock-fontify-buffer)
      (defun-page-breaks)
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
          (search-replace-in-buffer
           "<hr />" "<div style=\"page-break-before:always;\"></div>")
          (search-replace-in-buffer
           "^&#12;" "<div style=\"page-break-before:always;\"></div>")
          (write-file html-file))
        (shell-command
         (s-join " " (list ebook-convert-bin
                           (format "\"%s\"" html-file)
                           (format "\"%s\"" epub-file)
                           ebook-convert-options
                           (concat "--authors=" author)
                           (concat "--title=" source-name)
                           "--level1-toc='//*[@class=\"function-name\"]'"
                           (when ebook-cover
                             (concat "--cover=" ebook-cover)))))))))

(provide 'read-some-code)
