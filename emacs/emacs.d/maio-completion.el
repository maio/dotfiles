;; (setq ac-ignore-case nil)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(setq ac-ignore-case nil)
(setq ac-use-menu-map t)
(add-to-list 'ac-modes 'eshell-mode)
(add-to-list 'ac-modes 'sql-mode)
(add-to-list 'ac-modes 'makefile-gmake-mode)
(add-to-list 'ac-modes 'conf-colon-mode)

(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map [tab] 'ac-complete)
(define-key ac-completing-map "\C-n" 'ac-next)
(define-key ac-completing-map "\C-p" 'ac-previous)
(define-key ac-completing-map "\r" nil)
(define-key ac-completing-map [return] nil)

(provide 'maio-completion)
