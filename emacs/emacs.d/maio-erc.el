(eval-after-load 'erc-join
  '(progn
     (setq erc-hide-list '("JOIN" "PART" "QUIT"))
     (setq erc-autojoin-channels-alist
           '(("freenode.net" "#ejuan" "#dolnykubin" "#emacs" "#evil-mode"
              "#clojure")))))

(provide 'maio-erc)
