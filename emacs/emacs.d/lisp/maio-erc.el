(require 'erc-join)

(defun maio/erc-notify (match-type nickuserhost msg)
  (with-current-buffer (get-buffer-create "IRC")
    (save-excursion
      (insert (format-time-string "%D %H:%M "))
      (insert msg))))

(add-hook 'erc-text-matched-hook 'maio/erc-notify)

(setq erc-hide-list '("JOIN" "PART" "QUIT"))
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#ejuan" "#dolnykubin" "#emacs" "#evil-mode"
         "#clojure")))

(provide 'maio-erc)
