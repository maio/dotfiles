(require 's)
(require 'dash)

(setq perl-indent-parens-as-block t)

(add-to-list 'auto-mode-alist '("\\.pwt$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.it$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.psgi$" . perl-mode))

;; Template Toolkit
(add-to-list 'auto-mode-alist '("\\.tmpl$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . html-mode))

(defun setup-perl-mode ()
  (make-local-variable 'evil-lookup-func)
  (setq evil-lookup-func 'cperl-perldoc-at-point)
  (setq indent-tabs-mode t))

(with-eval-after-load 'perl-mode
  (add-hook 'perl-mode-hook 'smartparens-mode)
  (add-hook 'perl-mode-hook 'flycheck-mode)
  (add-hook 'perl-mode-hook 'yas-minor-mode-on)
  (add-hook 'perl-mode-hook 'setup-perl-mode)

  ;; (require 'yasnippet)
  ;; (yas-minor-mode-on)
  (require 'perltidy)
  (evil-define-key 'normal perl-mode-map "-" 'maio/find-alternative-file)
  (evil-define-key 'normal perl-mode-map "=" 'perltidy-dwim)
  (evil-define-key 'visual perl-mode-map "=" 'perltidy-dwim)
  ;; (define-key perl-mode-map (kbd "SPC") 'maio/electric-space)
  ;; (define-key perl-mode-map (kbd "RET") 'maio/electric-return)
  (define-key perl-mode-map (kbd "C-x m t") 'prove))

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
