(require 'maio-util)
(add-to-list 'load-path "~/.emacs.d/php-mode")

(require-and-exec 'php-mode
  (add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
  (setq php-mode-force-pear t))

(require-and-exec 'which-func
  (add-to-list 'which-func-modes 'php-mode))

(add-hook 'php-mode-hook
          (lambda ()
            (defun ywb-php-lineup-arglist-intro (langelem)
              (save-excursion
                (goto-char (cdr langelem))
                (vector (+ (current-column) c-basic-offset))))
            (defun ywb-php-lineup-arglist-close (langelem)
              (save-excursion
                (goto-char (cdr langelem))
                (vector (current-column))))
            (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
            (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

(add-hook 'php-mode-hook 'autopair-on)

(defun my-php-function-lookup ()
  (interactive)
  (let* ((function (symbol-name (or (symbol-at-point)
                                    (error "No function at point."))))
         (buf (url-retrieve-synchronously (concat "http://php.net/manual-lookup.php?pattern=" function))))
    (with-current-buffer buf
      (goto-char (point-min))
      (let (desc)
        (when (re-search-forward "<div class=\"methodsynopsis dc-description\">\\(\\(.\\|\n\\)*?\\)</div>" nil t)
          (setq desc
                (replace-regexp-in-string
                 " +" " "
                 (replace-regexp-in-string
                  "\n" ""
                  (replace-regexp-in-string "<.*?>" "" (match-string-no-properties 1)))))

          (when (re-search-forward "<p class=\"para rdfs-comment\">\\(\\(.\\|\n\\)*?\\)</p>" nil t)
            (setq desc
                  (concat desc "\n\n"
                          (replace-regexp-in-string
                           " +" " "
                           (replace-regexp-in-string
                            "\n" ""
                            (replace-regexp-in-string "<.*?>" "" (match-string-no-properties 1))))))))
        (if desc
            (message desc)
          (message "Could not extract function info. Press M-F1 to go the description."))))
    (kill-buffer buf)))

(evil-define-key 'normal php-mode-map
  "K" 'my-php-function-lookup)

(provide 'maio-php)
