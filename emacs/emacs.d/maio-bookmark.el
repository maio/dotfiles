(setq bookmark-save-flag 1)

(define-key evil-motion-state-map "gr" 'bookmark-jump)
(define-key evil-normal-state-map "M" 'bookmark-set)

(provide 'maio-bookmark)
