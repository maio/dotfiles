(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'nrepl-mode))

(defun maio/nrepl ()
  (interactive)
  (if (get-process "nrepl-server")
      (call-interactively 'nrepl-switch-to-repl-buffer)
    (nrepl-jack-in)))

(eval-after-load 'clojure-mode
  '(progn
     (evil-define-key 'normal clojure-mode-map "gs" 'maio/nrepl)
     (add-hook 'clojure-mode-hook 'eldoc-mode)))

(eval-after-load 'nrepl
  '(progn
     (add-hook 'nrepl-mode-hook 'autopair-on)
     (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
     (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
     (key-chord-define nrepl-mode-map ";k" 'nrepl-quit)))

(provide 'maio-clojure)
