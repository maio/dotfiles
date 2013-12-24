(deftheme eink
  "Port of eink.vim theme to emacs")

(custom-theme-set-faces
 'eink
 '(font-lock-builtin-face ((t (:background "white smoke" :foreground "#262626"))))
 '(region ((t (:background "#949494" :foreground "white smoke"))))
 '(highlight ((t nil)))
 '(cursor ((t (:background "#949494" :foreground "white smoke"))))
 '(show-paren-match-face ((t (:background "#949494" :foreground "white smoke"))))
 '(isearch ((t (:background "#e2e2e5" :foreground "#262626"))))
 '(modeline ((t (:background "white smoke" :foreground "#262626" :weight bold))))
 '(minibuffer-prompt ((t (:foreground "#262626" :weight bold))))
 '(default-italic ((t (:italic t))))
 '(font-lock-comment-face ((t (:foreground "#262626" :weight bold))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#808080"))))
 '(font-lock-constant-face ((t (:foreground "#262626"))))
 '(font-lock-doc-face ((t (:foreground "#262626"))))
 '(font-lock-function-name-face ((t (:foreground "#262626"))))
 '(font-lock-keyword-face ((t (:foreground "#262626"))))
 '(font-lock-preprocessor-face ((t (:foreground "#262626"))))
 '(font-lock-reference-face ((t (:foreground "#262626"))))
 '(font-lock-string-face ((t (:foreground "#262626"))))
 '(font-lock-type-face ((t (:foreground "#262626"))))
 '(font-lock-variable-name-face ((t (:foreground "#262626"))))
 '(font-lock-warning-face ((t (:foreground "#262626"))))
 '(link ((t (:foreground "#262626"))))
 '(org-hide ((t (:foreground "#262626"))))
 '(org-level-1 ((t (:foreground "#262626" :weight bold :height 1.1))))
 '(org-level-2 ((t (:foreground "#262626" :weight normal :height 1.1))))
 '(org-level-3 ((t (:foreground "#262626" :weight bold :height 1.1))))
 '(org-level-4 ((t (:foreground "#262626" :weight normal :height 1.0))))
 '(org-special-keyword ((t (:foreground "#262626"))))
 '(org-block ((t (:foreground "#262626"))))
 '(org-quote ((t (:foreground "#262626" :slant italic :inherit org-block))))
 '(org-verse ((t (:inherit org-block :slant italic))))
 '(org-todo ((t (:foreground "#262626" :weight bold))))
 '(org-done ((t (:foreground "#a9a9a9" :weight bold))))
 '(org-agenda-structure ((t (:foreground "#262626" :weight bold))))
 '(org-date ((t (:foreground "#262626") :underline)))
 '(org-agenda-date ((t (:foreground "#262626" :height 1.2))))
 '(org-agenda-date-weekend ((t (:foreground "#262626" :weight normal))))
 '(org-agenda-date-today ((t (:foreground "#262626" :weight bold :height 1.4))))
 '(org-scheduled ((t (:foreground "#262626"))))
 '(font-latex-bold-face ((t (:foreground "#262626"))))
 '(font-latex-italic-face ((t (:foreground "#262626" :slant italic))))
 '(font-latex-string-face ((t (:foreground "#a9a9a9"))))
 '(font-latex-match-reference-keywords ((t (:foreground "#262626"))))
 '(font-latex-match-variable-keywords ((t (:foreground "#262626"))))
 '(ido-only-match ((t (:foreground "#262626"))))
 '(org-sexp-date ((t (:foreground "#262626"))))
 '(ido-first-match ((t (:foreground "#262626"))))
 '(gnus-header-content ((t (:foreground "#262626"))))
 '(gnus-header-from ((t (:foreground "#262626"))))
 '(gnus-header-name ((t (:foreground "#262626"))))
 '(gnus-header-subject ((t (:foreground "#262626"))))
 '(slime-repl-inputed-output-face ((t (:foreground "#262626"))))
 '(ido-subdir ((t (:foreground "#262626"))))
 '(eshell-prompt ((t (:foreground "#262626" :weight bold))))
 '(custom-variable-tag ((t (:foreground "#262626" :weight bold))))
 '(mode-line ((t (:background "grey90" :foreground "#262626" :box (:line-width -1 :style released-button)))))
 '(default ((t (:background "white smoke" :foreground "#262626"))))
 '(whitespace-line ((t (:background "#262626" :foreground "white smoke"))))
)

(provide-theme 'eink)
