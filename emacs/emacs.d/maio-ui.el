(require 'maio-util)
(global-font-lock-mode 0)

(set-frame-font "Source Code Pro")

;; override font-lock-mode
(define-minor-mode font-lock-mode
  nil nil nil
  :after-hook (font-lock-initial-fontify)
  (setq font-lock-mode nil))

(defun toggle-fullscreen ()
  (when (and (fboundp 'ns-toggle-fullscreen) window-system)
    (ns-toggle-fullscreen)))

;; custom display modes
(defun regular-mode ()
  (interactive)
  (disable-theme 'cofi-light)
  (load-theme 'cofi-dark t)
  (if (system-type-is-gnu)
    (set-font-size 120)
    (set-font-size 170))
  (toggle-fullscreen)
  (toggle-fullscreen))

(defun presentation-mode ()
  (interactive)
  (disable-theme 'cofi-dark)
  (load-theme 'solarized-light t)
  (if (system-type-is-gnu)
    (set-font-size 140)
    (set-font-size 180))
  (toggle-fullscreen)
  (toggle-fullscreen))

(require 'escreen)
(escreen-install)

(provide 'maio-ui)
