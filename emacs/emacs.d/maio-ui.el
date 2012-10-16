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

;; enable copy/paste in terminal
(unless window-system
  (when (getenv "DISPLAY")
    (defun xsel-cut-function (text &optional push)
      (with-temp-buffer
        (insert text)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    (defun xsel-paste-function ()
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output)))
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)))

;; custom display modes
(defun regular-mode ()
  (interactive)
  (disable-theme 'dichromacy)
  (set-font-size 120)
  (load-theme 'cofi-dark t)
  (toggle-fullscreen)
  (toggle-fullscreen))

(defun presentation-mode ()
  (interactive)
  (disable-theme 'cofi-dark)
  (load-theme 'dichromacy t)
  (set-font-size 140)
  (toggle-fullscreen)
  (toggle-fullscreen))

(require 'escreen)
(escreen-install)

(provide 'maio-ui)
