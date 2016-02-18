(use-package company
  :defer t
  :config
  (setq company-idle-delay nil)

  (define-key company-active-map [tab] 'company-complete-selection)
  (define-key company-active-map [return] nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map "\C-s" 'company-filter-candidates)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)

  (define-key company-search-map (kbd "RET") 'company-complete-selection)
  (define-key company-search-map [return] 'company-complete-selection)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous))

(provide 'maio-completion)
