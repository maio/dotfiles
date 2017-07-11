(require 'maio-util)

(global-font-lock-mode 1)
(winner-mode 1)
(blink-cursor-mode 0)

(defvar maio/font-size nil)

(defun maio/set-font (font size)
  (setq maio/font-size size)
  (set-frame-font font)
  (set-default-font font t t)
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
      (maio/set-font "Iosevka:weight=Light" 140)
    (progn
      (maio/set-font "Iosevka:weight=Light" 150))))

(when (ui-type-is-gui)
  (menu-bar-mode t)
  (set-fringe-mode 1))

(provide 'maio-ui)
