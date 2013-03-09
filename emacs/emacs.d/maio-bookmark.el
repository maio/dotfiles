(require 'bookmark+)

;; bmkp-make-function-bookmark

(setq bookmark-save-flag nil)

(when (file-exists-p "~/.emacs.d/bookmarks.local")
  (bookmark-load "~/.emacs.d/bookmarks.local" nil 'nosave))

(define-key evil-motion-state-map "gb" 'bookmark-jump)

(provide 'maio-bookmark)
