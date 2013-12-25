(require 'maio-key-chord)

(setq bookmark-save-flag 1)

(key-chord-define-global ";j" 'helm-bookmarks)

(defadvice helm-bookmarks (before bmkp () activate) (require 'bookmark+))

(add-hook 'bookmark-after-jump-hook 'recenter-top-bottom)

(provide 'maio-bookmark)
