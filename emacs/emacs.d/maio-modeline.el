(require 'diminish)

(eval-after-load 'yasnippet '(diminish 'yas-minor-mode "YS"))
(eval-after-load 'eldoc '(diminish 'eldoc-mode))
(eval-after-load 'undo-tree '(diminish 'undo-tree-mode))
(eval-after-load 'hi-lock '(diminish 'hi-lock-mode))
(eval-after-load 'auto-complete '(diminish 'auto-complete-mode "AC"))
(eval-after-load 'smartparens '(diminish 'smartparens-mode "()"))
(eval-after-load 'simple '(diminish 'auto-fill-function))
(eval-after-load 'flymake '(diminish 'flymake-mode "Fly"))
(eval-after-load 'paredit '(diminish 'paredit-mode "(e)"))

(setq-default
 mode-line-format
 (list " "
       'mode-line-modified
       " "
       'evil-mode-line-tag
       '(line-number-mode "%l,")
       '(column-number-mode "%c")
       " "
       'mode-line-buffer-identification
       " "
       'mode-line-misc-info
       'mode-line-modes
       "-%-"
       ))

(provide 'maio-modeline)
