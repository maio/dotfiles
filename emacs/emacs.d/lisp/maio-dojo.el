(defun dojo-mode ()
  (interactive)
  (setq company-idle-delay 0.1)
  (setq shift-select-mode t)
  (global-set-key (kbd "<s-right>") 'move-end-of-line)
  (global-set-key (kbd "<s-left>") 'evil-first-non-blank)
  (when evil-mode
    (setq evil-normal-state-cursor '("red" box))
    (setq evil-insert-state-cursor '("black" (bar . 2)))
    (setq evil-emacs-state-cursor '("black" (bar . 2))))
  (blink-cursor-mode t)
  (setq truncate-partial-width-windows 40
        helm-full-frame t)
  (setq-default line-spacing 6)
  (maio/set-font "Source Code Pro Medium" 150)
  (with-eval-after-load 'paren-face
    (let ((color "black"))
      (set-face-foreground 'parenthesis color))))

(provide 'maio-dojo)
