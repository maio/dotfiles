(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.latte\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))

(with-eval-after-load 'web-mode
  (add-hook 'web-mode-hook 'yas-minor-mode-on)
  (add-hook 'web-mode-hook (lambda () (auto-fill-mode -1))))

(provide 'maio-web)
