(add-hook 'clojure-mode-hook 'eldoc-mode)
(add-hook 'nrepl-mode-hook 'autopair-on)

(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

(defun maio/nrepl ()
  (interactive)
  (if (get-process "nrepl-server")
      (nrepl-switch-to-repl-buffer)
    (nrepl-jack-in)))

(eval-after-load "clojure-mode"
  '(evil-define-key 'normal clojure-mode-map (kbd "gs") 'maio/nrepl))

(evil-define-key 'normal nrepl-interaction-mode-map (kbd "RET") 'nrepl-return)
(defadvice nrepl-return (after normal-state () activate) (evil-normal-state))
(evil-define-key 'normal nrepl-mode-map (kbd "(")
  (lambda () (interactive) (insert "(") (evil-insert-state)))

(provide 'maio-clojure)
