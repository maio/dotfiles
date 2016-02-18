(use-package bookmark+
  :defer 1
  :config
  (setq bookmark-save-flag 1)
  (with-eval-after-load 'helm
    (add-to-list 'helm-completing-read-handlers-alist '(bookmark-jump . ido)))

  (add-hook 'bookmark-after-jump-hook 'recenter-top-bottom)
  (global-set-key (kbd "C-x j j") 'bookmark-jump))

(provide 'maio-bookmark)
