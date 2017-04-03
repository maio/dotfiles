(use-package diminish
  :ensure t
  :config
  (with-eval-after-load 'eldoc (diminish 'eldoc-mode))
  (with-eval-after-load 'undo-tree (diminish 'undo-tree-mode))
  (with-eval-after-load 'hi-lock (diminish 'hi-lock-mode))
  (with-eval-after-load 'subword (diminish 'subword-mode))
  (with-eval-after-load 'simple (diminish 'auto-fill-function))

  (with-eval-after-load 'yasnippet (diminish 'yas-minor-mode "YS"))
  (with-eval-after-load 'company (diminish 'company-mode "AC"))
  (with-eval-after-load 'smartparens (diminish 'smartparens-mode "(s)"))
  (with-eval-after-load 'paredit (diminish 'paredit-mode "(p)"))
  (with-eval-after-load 'flymake (diminish 'flymake-mode "Fly"))
  (with-eval-after-load 'cider (diminish 'cider-mode))
  (with-eval-after-load 'helm-mode (diminish 'helm-mode))
  (with-eval-after-load 'projectile (diminish 'projectile-mode)))

(defvar mode-line-buffer-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map [mode-line mouse-1] 'maio/copy-file-name-to-clipboard)
    map) "\
Keymap to display on buffer.")

(defface mode-line-buffer
  '((t (:bold t)))
  ""
  :group 'mode-line-faces)

(defface mode-line-major-mode
  '((t (:bold t)))
  ""
  :group 'mode-line-faces)

(defface mode-line-minor-mode
  '((t ()))
  ""
  :group 'mode-line-faces)

(setq-default
 mode-line-format
 `(" "
   global-mode-string
   " %* "
   (:propertize "%b" face mode-line-buffer
                help-echo (buffer-file-name)
                local-map ,mode-line-buffer-keymap)
   projectile-mode-line
   "%04l:%02c"
   " "
   (:propertize ("" mode-name)
                face mode-line-major-mode
                mouse-face mode-line-highlight
                help-echo "Major mode\nmouse-1: Display minor mode menu\nmouse-2: Show help for minor mode, mouse-3: Toggle minor modes"
                local-map ,mode-line-major-mode-keymap)
   mode-line-process
   (:propertize ("" minor-mode-alist)
                face mode-line-minor-mode
                mouse-face mode-line-highlight
                help-echo "Minor mode\nmouse-1: Display minor mode menu\nmouse-2: Show help for minor mode, mouse-3: Toggle minor modes"
                local-map ,mode-line-minor-mode-keymap)
   ))

(provide 'maio-modeline)
