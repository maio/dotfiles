(require 'diminish)

(require 'powerline)
(powerline-default-theme)

(eval-after-load 'yasnippet '(diminish 'yas-minor-mode "YS"))
(eval-after-load 'eldoc '(diminish 'eldoc-mode))
(eval-after-load 'undo-tree '(diminish 'undo-tree-mode))
(eval-after-load 'hi-lock '(diminish 'hi-lock-mode))
(eval-after-load 'auto-complete '(diminish 'auto-complete-mode "AC"))
(eval-after-load 'autopair '(diminish 'autopair-mode "()"))
(eval-after-load 'simple '(diminish 'auto-fill-function))
(eval-after-load 'flymake '(diminish 'flymake-mode "Fly"))
(eval-after-load 'paredit '(diminish 'paredit-mode "(e)"))

(provide 'maio-modeline)
