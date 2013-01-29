(require 'maio-util)
(global-font-lock-mode 0)

(if (system-type-is-gnu)
    (set-frame-font "Terminus Bold")
  (set-frame-font "Source Code Pro Regular"))

(defun maio/no-bold-or-underline-please ()
  (mapc
  (lambda (face)
    (set-face-attribute face nil :weight 'normal :underline nil))
  (face-list)))

;; custom display modes
(defun regular-mode ()
  (interactive)
  (if (system-type-is-gnu)
    (set-font-size 160)
    (set-font-size 160)))

(defun presentation-mode ()
  (interactive)
  (if (system-type-is-gnu)
    (set-font-size 180)
    (set-font-size 180)))

(provide 'maio-ui)
