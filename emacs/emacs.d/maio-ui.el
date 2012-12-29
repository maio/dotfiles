(require 'maio-util)
(global-font-lock-mode 0)

(set-frame-font "Source Code Pro Regular")

;; custom display modes
(defun regular-mode ()
  (interactive)
  (if (system-type-is-gnu)
    (set-font-size 120)
    (set-font-size 160)))

(defun presentation-mode ()
  (interactive)
  (if (system-type-is-gnu)
    (set-font-size 140)
    (set-font-size 170)))

(provide 'maio-ui)
