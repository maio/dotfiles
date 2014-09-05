(deftheme eink
  "Port of eink.vim theme to emacs")

;; TODO: deduplicate values (see cofi themes)
(custom-theme-set-faces
 'eink
 '(font-lock-builtin-face ((t (:background "white smoke" :foreground "#262626"))))
 '(region ((t (:background "gray85" :foreground "#262626"))))
 '(yas-field-highlight-face ((t (:background "gray85" :foreground "#262626"))))
 '(button ((t (:foreground "#262626" :underline t))))
 '(highlight ((t nil)))
 '(cursor ((t (:background "#949494" :foreground "white smoke"))))
 '(isearch ((t (:background "#e2e2e5" :foreground "#262626"))))
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
 '(font-lock-warning-face ((t (:foreground "#262626" :weight bold))))
 '(link ((t (:foreground "#262626"))))
 '(org-hide ((t (:foreground "#262626"))))
 '(org-level-1 ((t (:foreground "#262626" :weight bold :height 1.1))))
 '(org-level-2 ((t (:foreground "#262626" :weight bold :height 1.1))))
 '(org-level-3 ((t (:foreground "#262626" :weight bold :height 1.1))))
 '(org-level-4 ((t (:foreground "#262626" :weight bold :height 1.0))))
 '(org-special-keyword ((t (:foreground "#262626"))))
 '(org-block ((t (:foreground "#262626"))))
 '(org-quote ((t (:foreground "#262626" :slant italic :inherit org-block))))
 '(org-verse ((t (:inherit org-block :slant italic))))
 '(org-todo ((t (:foreground "#262626" :weight bold))))
 '(org-link ((t (:foreground "#262626" :underline t))))
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
 '(modeline ((t (:background "white smoke" :foreground "#262626" :weight bold))))
 '(mode-line ((t (:background "grey90" :foreground "#262626" :height 0.8))))
 '(mode-line-inactive ((t (:background "grey90" :foreground "grey90" :height 0.8))))
 '(mode-line-buffer ((t (:foreground "#262626" :weight bold))))
 '(mode-line-minor-mode ((t (:weight ultra-light))))
 '(default ((t (:background "white smoke" :foreground "#262626"))))
 '(whitespace-line ((t (:background "#262626" :foreground "white smoke"))))
 '(cperl-hash-face ((t (:foreground "#262626"))))
 '(cperl-array-face ((t (:foreground "#262626"))))
 '(cperl-nonoverridable-face ((t (:foreground "#262626"))))
 '(idle-highlight ((t (:background "#FFF100"))))
 '(magit-header ((t (:weight bold))))
 '(magit-item-mark ((t (:background "#FFF100"))))
 '(magit-item-highlight ((t (:weight bold))))
 ;; compile
 '(compilation-error ((t (:inherit error))))
 ;; flycheck
 '(flycheck-error ((t (:inherit error))))
 '(flycheck-warning ((t (:inherit warning))))
 ;; dired
 '(dired-directory ((t (:weight bold))))
 ;; helm
 '(helm-selection-line ((t (:inherit region :weight bold))))
 '(helm-selection ((t (:inherit region))))
 '(helm-ff-directory ((t (:foreground "#262626" :weight bold))))
 '(helm-ff-symlink ((t (:foreground "#262626" :slant italic))))
 '(helm-ff-executable ((t (:foreground "#262626"))))
 ;; parenface
 '(parenface-paren-face ((t (:foreground "#D0D0D0"))))
 '(parenface-curly-face ((t (:foreground "#D0D0D0"))))
 '(parenface-bracket-face ((t (:foreground "#D0D0D0"))))
 ;; js2
 '(js2-function-param ((t (:foreground "#262626"))))
 '(js2-external-variable ((t (:foreground "#262626"))))
 ;; show paren
 '(sp-show-pair-match-face ((t (:foreground "black" :weight bold))))
 '(sp-show-pair-mismatch-face ((t (:background "red" :foreground "black" :weight bold))))
 '(show-paren-match ((t (:foreground "black" :weight bold))))
 '(show-paren-mismatch ((t (:background "red" :foreground "black" :weight bold))))
 ;; rpm-spec-mode
 '(rpm-spec-tag-face ((t (:inherit default))))
 '(rpm-spec-package-face ((t (:inherit default))))
 '(rpm-spec-macro-face ((t (:inherit default))))
 '(rpm-spec-doc-face ((t (:inherit default))))
 '(rpm-spec-var-face ((t (:inherit default))))
 '(rpm-spec-ghost-face ((t (:inherit default))))
 '(rpm-spec-section-face ((t (:inherit default :weight bold)))))

(provide-theme 'eink)
