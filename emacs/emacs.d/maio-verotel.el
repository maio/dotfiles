(require 'url)

(defun verotel-get-prod-version ()
  (with-current-buffer (url-retrieve-synchronously "https://admin.verza.com/current-release")
    (search-forward "version: ")
    (number-at-point)))

(provide 'maio-verotel)
