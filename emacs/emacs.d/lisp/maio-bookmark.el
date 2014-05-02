(setq bookmark-save-flag 1)
(add-to-list 'helm-completing-read-handlers-alist '(bookmark-jump . ido))
(add-hook 'bookmark-after-jump-hook 'recenter-top-bottom)

(require 'bookmark+)
(global-set-key (kbd "C-x j j") 'bookmark-jump)

(provide 'maio-bookmark)
