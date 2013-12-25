(add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)

;; remove light background from diff added/removed faces
(custom-set-faces
 '(diff-added ((t (:inherit diff-changed :foreground "green4"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red3")))))

(eval-after-load 'magit
  '(require 'maio-magit))

(eval-after-load 'gist
  '(progn
     (key-chord-define gist-mode-map ";w" 'gist-mode-save-buffer)))

(provide 'maio-git)
