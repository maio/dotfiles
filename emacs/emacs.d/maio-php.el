(require 'maio-util)

(require-and-exec 'php-mode
  (add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
  (setq php-mode-force-pear t))

(require-and-exec 'which-func
  (add-to-list 'which-func-modes 'php-mode))

;; http://www.xemacs.org/Documentation/packages/html/cc-mode_10.html#SEC38
(add-hook 'php-mode-hook
          (lambda ()
            (defun php-statement-block-intro (langelem)
              (save-excursion
                (goto-char (cdr langelem))
                (vector (+ (current-column) c-basic-offset))))
            (defun php-block-close (langelem)
              (save-excursion
                (goto-char (cdr langelem))
                (vector (current-column))))
            (c-set-offset 'statement-block-intro 'php-statement-block-intro)
            (c-set-offset 'block-close 'php-block-close)))

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

(evil-define-key 'normal php-mode-map "K" 'my-php-function-lookup)
(key-chord-define php-mode-map ";;" 'maio/electric-semicolon)
(define-key php-mode-map (kbd "SPC") 'maio/electric-space)

(provide 'maio-php)
