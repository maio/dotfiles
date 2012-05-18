(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook 'eldoc-mode)

(eval-after-load 'slime
  '(setq slime-protocol-version 'ignore))

(which-func-mode 1)

(require 'autopair)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)
(add-hook 'prog-mode-hook 'autopair-on)

(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

;; (require 'flymake)
;; (require 'flymake-cursor)
;; (push '(".+\\.t$" flymake-perl-init) flymake-allowed-file-name-masks)
;; (add-hook 'perl-mode-hook
;;     (lambda () (flymake-mode nil)))

(defun maio-narrow-to-defun-clone ()
  (interactive)
  (message (which-function))
  (clone-indirect-buffer (which-function) t)
  (narrow-to-defun))

(require 'maio-guard)
(provide 'maio-prog)
