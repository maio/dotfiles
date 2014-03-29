(setq bookmark-save-flag 1)

(defadvice helm-bookmarks (before bmkp () activate) (require 'bookmark+))
(defadvice bookmark-jump (before bmkp () activate) (require 'bookmark+))

(add-hook 'bookmark-after-jump-hook 'recenter-top-bottom)

(with-eval-after-load 'bookmark+
  (global-set-key (kbd "C-x j j") 'helm-bookmarks))
(global-set-key (kbd "C-x j j") 'helm-bookmarks)

(provide 'maio-bookmark)
