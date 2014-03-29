(require 's)
(require 'dash)

(add-to-list 'load-path "~/.emacs.d/lisp/cperl-mode")
(defalias 'perl-mode 'cperl-mode)

(setq cperl-indent-level 4
      cperl-close-paren-offset -4
      cperl-continued-statement-offset 4
      cperl-indent-parens-as-block t
      cperl-electric-parens nil
      cperl-invalid-face nil
      cperl-tab-always-indent t
      cperl-electric-backspace-untabify nil)

(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.it$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.psgi$" . perl-mode))

;; Template Toolkit
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . html-mode))

(with-eval-after-load 'cperl-mode
  (require 'yasnippet)
  (yas-minor-mode-on)
  (require 'perltidy)
  (require 'which-func)
  (add-to-list 'which-func-modes 'cperl-mode)
  (add-hook 'cperl-mode-hook 'esk-prog-mode-hook)
  (add-hook 'cperl-mode-hook 'smartparens-mode)
  (add-hook 'cperl-mode-hook 'flycheck-mode)
  (add-hook 'cperl-mode-hook 'maio/setup-tab-indent)
  (evil-define-key 'normal cperl-mode-map "-" 'maio/find-alternative-file)
  (evil-define-key 'normal cperl-mode-map "=" 'perltidy-dwim)
  (evil-define-key 'visual cperl-mode-map "=" 'perltidy-dwim)
  (define-key cperl-mode-map (kbd "SPC") 'maio/electric-space)
  (define-key cperl-mode-map (kbd "RET") 'maio/electric-return)
  (define-key cperl-mode-map (kbd "C-x m t") 'prove))

(require 'flycheck)

(flycheck-define-checker prove
  "Run Perl tests using prove"
  :command ("prove" "--norc" "-v" "--merge" source)
  :error-patterns
  ((error line-start "#" (minimal-match (message)) (optional "\n#  ")
          " at " (file-name) " line " line
          (or "." (and ", " (zero-or-more not-newline))) line-end))
  :modes (perl-mode cperl-mode)
  :predicate (lambda () (s-ends-with-p ".t" (buffer-file-name))))

(add-to-list 'flycheck-checkers 'prove)

(with-eval-after-load 'feature-mode
  (evil-define-key 'normal feature-mode-map "-" 'maio/find-alternative-file))

(defun maio/buffer-path-in-project ()
  (s-chop-prefix
   (file-truename (locate-dominating-file default-directory ".git"))
   buffer-file-name))

(defun maio/starts-with-capital? (s)
  (let ((case-fold-search nil))
    (s--truthy?
     (string-match-p "^[[:upper:]].*$" s))))

(defun maio/guess-perl-package-name ()
  (s-join "::" (-filter 'maio/starts-with-capital?
                        (s-split "/" (file-name-sans-extension (maio/buffer-path-in-project))))))

(defun perl-test-file (fname)
  (if (s-ends-with? ".t" fname)
      fname
    (maio/get-alternative-file fname)))

(defun prove ()
  (interactive)
  (let ((tfile (perl-test-file (buffer-file-name))))
    (compile (concat "prove " tfile))
    (with-current-buffer compilation-last-buffer
      (rename-buffer (concat "*" "prove " tfile "*")))))

(recompile-on-save-advice prove)

(provide 'maio-perl)
