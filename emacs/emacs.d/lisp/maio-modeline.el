(require 'diminish)

(with-eval-after-load 'eldoc (diminish 'eldoc-mode))
(with-eval-after-load 'undo-tree (diminish 'undo-tree-mode))
(with-eval-after-load 'hi-lock (diminish 'hi-lock-mode))
(with-eval-after-load 'subword (diminish 'subword-mode))
(with-eval-after-load 'simple (diminish 'auto-fill-function))

(with-eval-after-load 'yasnippet (diminish 'yas-minor-mode "YS"))
(with-eval-after-load 'company (diminish 'company-mode "AC"))
(with-eval-after-load 'smartparens (diminish 'smartparens-mode "()"))
(with-eval-after-load 'paredit (diminish 'paredit-mode "(e)"))
(with-eval-after-load 'flymake (diminish 'flymake-mode "Fly"))

(setq-default
 mode-line-format
 (list " "
       'mode-line-modified
       " "
       '(line-number-mode "%l,")
       '(column-number-mode "%c")
       " "
       'mode-line-buffer-identification
       " "
       'mode-line-misc-info
       'mode-line-modes
       ))

(provide 'maio-modeline)
