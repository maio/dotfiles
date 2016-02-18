(require 'maio-util)

(global-font-lock-mode 1)
(winner-mode 1)
(blink-cursor-mode 0)

(defvar maio/font-size nil)

(defun maio/set-font (font size)
  (setq maio/font-size size)
  (set-frame-font font)
  (set-font-size size))

(defun maio/alter-font-size (delta)
  (setq maio/font-size (+ maio/font-size delta))
  (set-font-size maio/font-size))

(defun maio/inc-font-size () (interactive) (maio/alter-font-size +10))
(defun maio/dec-font-size () (interactive) (maio/alter-font-size -10))

(defun no-background-color ()
  (set-face-background 'default "unspecified-bg" (selected-frame)))

;; custom display modes
(defun regular-mode ()
  (interactive)
  (load-theme 'eink t)
  (when (ui-type-is-terminal)
    (add-hook 'window-setup-hook 'no-background-color))
  (if (system-type-is-gnu)
      (maio/set-font "Source Code Pro" 140)
    (progn
      (maio/set-font "Source Code Pro:weight=Regular" 140))))

(defun presentation-mode ()
  (interactive)
  (load-theme 'eink t)
  (if (system-type-is-gnu)
      (maio/set-font "Source Code Pro" 140)
    (maio/set-font "Source Code Pro Medium" 180)))

(when (system-type-is-darwin)
  (xterm-mouse-mode t)
  (defun up-slightly () (interactive) (scroll-up 1))
  (defun down-slightly () (interactive) (scroll-down 1))
  (global-set-key (kbd "<mouse-4>") 'down-slightly)
  (global-set-key (kbd "<mouse-5>") 'up-slightly))

(when (ui-type-is-gui)
  (menu-bar-mode t)
  (set-fringe-mode 1))

(provide 'maio-ui)
