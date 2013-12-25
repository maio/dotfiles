(require 'maio-util)

(global-font-lock-mode 1)
(winner-mode 1)

(defun maio/set-font (font size)
  (set-frame-font font)
  (set-font-size size))

(defun maio/no-underline-please ()
  (mapc
   (lambda (face)
     (set-face-attribute face nil :underline nil))
   (face-list)))

;; custom display modes
(defun regular-mode ()
  (interactive)
  (load-theme 'eink t)
  (maio/no-underline-please)
  (if (system-type-is-gnu)
      (maio/set-font "Source Code Pro" 120)
    (progn
      (maio/set-font "Source Code Pro Regular" 160)
      (toggle-frame-fullscreen))))

(defun presentation-mode ()
  (interactive)
  (load-theme 'eink t)
  (maio/no-underline-please)
  (if (system-type-is-gnu)
      (maio/set-font "Source Code Pro" 140)
    (maio/set-font "Source Code Pro Regular" 180)))

(when (system-type-is-darwin)
  (xterm-mouse-mode t)
  (defun up-slightly () (interactive) (scroll-up 1))
  (defun down-slightly () (interactive) (scroll-down 1))
  (global-set-key (kbd "<mouse-4>") 'down-slightly)
  (global-set-key (kbd "<mouse-5>") 'up-slightly))

(provide 'maio-ui)