(require 'maio-util)
(global-font-lock-mode 0)

(defun maio/set-font (font size)
  (set-frame-font font)
  (set-font-size size))

(defun maio/no-bold-or-underline-please ()
  (mapc
  (lambda (face)
    (set-face-attribute face nil :weight 'normal :underline nil))
  (face-list)))

;; custom display modes
(defun regular-mode ()
  (interactive)
  (if (system-type-is-gnu)
      (maio/set-font "Terminus Bold" 150)
    (maio/set-font "Source Code Pro Regular" 160)))

(defun presentation-mode ()
  (interactive)
  (if (system-type-is-gnu)
      (maio/set-font "Terminus Bold" 180)
    (maio/set-font "Source Code Pro Regular" 180)))

(provide 'maio-ui)
