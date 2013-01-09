(require 'diminish)
(eval-after-load 'yasnippet '(diminish 'yas-minor-mode "YS"))
(eval-after-load 'eldoc '(diminish 'eldoc-mode))
(eval-after-load 'undo-tree '(diminish 'undo-tree-mode))
(eval-after-load 'hi-lock '(diminish 'hi-lock-mode))
(eval-after-load 'auto-complete '(diminish 'auto-complete-mode "AC"))
(eval-after-load 'autopair '(diminish 'autopair-mode "()"))
(eval-after-load 'simple '(diminish 'auto-fill-function))
(eval-after-load 'flymake '(diminish 'flymake-mode "Fly"))
(eval-after-load 'paredit '(diminish 'paredit-mode "(e)"))

(setq-default
 mode-line-format
 (list
  '(evil-mode ("" evil-mode-line-tag))
  ;; modified mark
  "%* "

  ;; the buffer name; the file name as a tool tip
  '(:eval (propertize "%b "
                      'help-echo (buffer-file-name)))

  ;; line and column
  "" ;; '%02' to set to 2 chars at least; prevents flickering
  (propertize "%02l") ","
  (propertize "%02c")
  " "

  ;; relative position, size of file
  (propertize "%p ") ;; % above top

  mode-line-modes
  ;; i don't want to see minor-modes; but if you want, uncomment this:
  ;; minor-mode-alist  ;; list of minor modes

  " "
  ;; current function
  '(which-func-mode ("" which-func-format " "))

  " %-" ;; fill with '-'
  ))

(provide 'maio-modeline)
