(require 'maio-util)

(global-font-lock-mode 1)
(winner-mode 1)

(defun maio/set-font (font size)
  (set-frame-font font)
  (set-font-size size))

;; custom display modes
(defun regular-mode ()
  (interactive)
  (load-theme 'eink t)
  (if (system-type-is-gnu)
      (maio/set-font "Source Code Pro" 120)
    (progn
      (maio/set-font "Source Code Pro Medium" 120)
      (when (ui-type-is-gui)
        (toggle-frame-fullscreen)))))

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
  (set-fringe-mode 0))

(provide 'maio-ui)
