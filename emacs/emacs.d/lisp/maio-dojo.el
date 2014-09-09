(defun dojo-mode ()
  (interactive)
  (setq company-idle-delay 0.1)
  (setq shift-select-mode t)
  (setq evil-normal-state-cursor '("red" box))
  (with-eval-after-load 'parenface
    (let ((color "gray60"))
      (set-face-foreground 'parenface-paren-face color)
      (set-face-foreground 'parenface-bracket-face color)
      (set-face-foreground 'parenface-curly-face color))))

(provide 'maio-dojo)
