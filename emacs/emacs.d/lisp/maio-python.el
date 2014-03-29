(with-eval-after-load 'python
  (add-hook 'python-mode-hook 'esk-prog-mode-hook)
  (add-hook 'python-mode-hook 'flymake-mode)
  (add-hook 'python-mode-hook 'smartparens-mode)
  (define-key python-mode-map (kbd "SPC") 'maio/electric-space)
  (define-key python-mode-map (kbd "RET") 'maio/electric-return))

(provide 'maio-python)
