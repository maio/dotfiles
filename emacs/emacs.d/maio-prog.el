(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook 'eldoc-mode)

(eval-after-load 'slime
  '(setq slime-protocol-version 'ignore))

(which-func-mode 1)
(electric-pair-mode 1)
(electric-indent-mode 1)
(electric-layout-mode 1)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)

(defun maio-narrow-to-defun-clone ()
  (interactive)
  (message (which-function))
  (clone-indirect-buffer (which-function) t)
  (narrow-to-defun))

(setq whitespace-action '(auto-cleanup))
(setq whitespace-style '(face trailing lines-tail) whitespace-line-column 80)
(whitespace-mode)

(require 'maio-guard)
(provide 'maio-prog)
