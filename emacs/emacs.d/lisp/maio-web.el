(setq web-mode-markup-indent-offset 2
      web-mode-script-padding 2
      web-mode-code-indent-offset 2
      web-mode-enable-current-element-highlight t
      css-indent-offset 2)

(add-to-list 'auto-mode-alist '("\\.htm\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.latte\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))

(with-eval-after-load 'web-mode
  (add-hook 'web-mode-hook (lambda () (auto-fill-mode -1)))
  (add-hook 'web-mode-hook 'yas-minor-mode)
  (when evil-mode
    (evil-define-key 'normal web-mode-map "%" 'web-mode-tag-match)
    (evil-define-key 'normal web-mode-map "3" 'web-mode-comment-or-uncomment)
    (evil-define-key 'visual web-mode-map "3" 'web-mode-comment-or-uncomment)))

(provide 'maio-web)
