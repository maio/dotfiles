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

(eval-after-load 'cperl-mode
  '(progn
     (require 'yasnippet)
     (yas-global-mode t)
     (require 'perltidy)
     (require 'which-func)
     (add-to-list 'which-func-modes 'cperl-mode)
     (add-hook 'cperl-mode-hook 'esk-prog-mode-hook)
     (add-hook 'cperl-mode-hook 'smartparens-mode)
     (add-hook 'cperl-mode-hook 'maio/setup-tab-indent)
     (evil-define-key 'normal cperl-mode-map "-" 'maio/find-alternative-file)
     (evil-define-key 'normal cperl-mode-map "=" 'perltidy-dwim)
     (evil-define-key 'visual cperl-mode-map "=" 'perltidy-dwim)
     (key-chord-define cperl-mode-map ";;" 'maio/electric-semicolon)
     (define-key cperl-mode-map (kbd "SPC") 'maio/electric-space)
     (define-key cperl-mode-map (kbd "RET") 'maio/electric-return)))

(eval-after-load 'feature-mode
  '(progn
     (evil-define-key 'normal feature-mode-map "-" 'maio/find-alternative-file)))

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

(provide 'maio-perl)