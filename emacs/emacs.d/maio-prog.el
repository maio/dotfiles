(add-hook 'clojure-mode-hook 'midje-mode)
(add-hook 'clojure-mode-hook 'eldoc-mode)

(which-func-mode 1)

(require 'autopair)
(autopair-global-mode t)

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)

(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

;; (require 'flymake)
;; (require 'flymake-cursor)
;; (push '(".+\\.t$" flymake-perl-init) flymake-allowed-file-name-masks)
;; (add-hook 'perl-mode-hook
;;     (lambda () (flymake-mode nil)))

(require 'maio-guard)
(provide 'maio-prog)
