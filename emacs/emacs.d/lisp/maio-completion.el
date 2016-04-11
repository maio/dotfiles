(use-package company
  :defer 10
  :config
  (global-company-mode 1)
  (require 'maio-company)
  (setq company-idle-delay 0.2
        company-frontends '(company-preview-frontend
                            company-echo-strip-common-frontend)
        company-backends '(company-maio
                           company-files
                           ;; company-elisp
                           company-css
                           company-capf))
  ;; Stop completion when going back to normal state. See docs for
  ;; this variable. It has weird name for what it does.
  (add-to-list 'company-continue-commands 'evil-normal-state t)

  (define-key company-active-map [tab] 'company-complete-selection)
  (define-key company-active-map [return] nil)
  (define-key company-active-map (kbd "RET") nil)
  (define-key company-active-map "\C-s" 'company-filter-candidates)

  ;; Jump straight to next candidate when starting candidates
  ;; filtering. Chances are pretty high that it's what I want to
  ;; complete. If not, I will just filter candidates as usual.
  (defadvice company-filter-candidates (after next-candidate activate)
    (company-select-next))

  (define-key company-search-map "\C-s" 'company-select-next)
  (define-key company-search-map "\C-r" 'company-select-previous)
  (define-key company-search-map [tab] 'company-complete-selection)
  (define-key company-search-map (kbd "RET") 'company-complete-selection)
  (define-key company-search-map [return] 'company-complete-selection))

(provide 'maio-completion)
