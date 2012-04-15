(require 'maio-util)
(global-font-lock-mode 0)

;; override font-lock-mode
(define-minor-mode font-lock-mode
  nil nil nil
  :after-hook (font-lock-initial-fontify)
  (setq font-lock-mode nil))

;; custom display modes
(defun regular-mode ()
  (interactive)
  (disable-theme 'dichromacy)
  (set-font-size 160)
  (load-theme 'cofi-dark t))

(defun presentation-mode ()
  (interactive)
  (disable-theme 'cofi-dark)
  (load-theme 'dichromacy t)
  (set-font-size 190))

(regular-mode)
;; (presentation-mode)

(provide 'maio-ui)
