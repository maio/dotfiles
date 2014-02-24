(require 'company)

(add-hook 'after-init-hook 'global-company-mode)

(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 3)
(push 'company-readline company-backends)

(define-key company-active-map [tab] 'company-complete-selection)
(define-key company-active-map [return] nil)
(define-key company-active-map (kbd "RET") nil)
(define-key company-active-map "\C-s" 'company-filter-candidates)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(provide 'maio-completion)
