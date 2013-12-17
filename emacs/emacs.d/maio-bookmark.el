(require 'maio-key-chord)

(setq bookmark-save-flag 1)

(key-chord-define-global ";j" 'helm-bookmarks)

(add-hook 'bookmark-after-jump-hook 'recenter-top-bottom)

(provide 'maio-bookmark)
