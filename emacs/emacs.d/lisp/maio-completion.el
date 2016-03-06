(use-package company
  :defer 10
  :config
  (global-company-mode 1)
  (setq company-idle-delay 0
        company-frontends '(company-preview-frontend
                            company-echo-strip-common-frontend)
        company-backends '(company-dabbrev-code
                           company-files
                           company-css
                           company-capf))

  (define-key company-active-map [tab] 'company-complete-selection)
  (define-key company-active-map [return] nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map "\C-s" 'company-filter-candidates)

  (define-key company-search-map [tab] 'company-complete-selection)
  (define-key company-search-map (kbd "RET") 'company-complete-selection)
  (define-key company-search-map [return] 'company-complete-selection))

(provide 'maio-completion)
