(setq bookmark-save-flag 1)

(defadvice helm-bookmarks (before bmkp () activate) (require 'bookmark+))

(add-hook 'bookmark-after-jump-hook 'recenter-top-bottom)

(provide 'maio-bookmark)
