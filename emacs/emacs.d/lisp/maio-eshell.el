;; copy of starter-kit-eshell.el --- Saner defaults and goodies: eshell tweaks

(setq eshell-cmpl-cycle-completions nil
      eshell-save-history-on-exit t
      eshell-buffer-shorthand t
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'")

;;;###autoload
(with-eval-after-load 'esh-opt
  (require 'em-prompt)
  (require 'em-term)
  (require 'em-cmpl)
  (add-hook 'eshell-mode-hook ;; for some reason this needs to be a hook
            '(lambda ()
               (setq eshell-path-env (getenv "PATH"))
               (define-key eshell-mode-map [tab] 'company-manual-begin)
               (define-key eshell-mode-map "\C-a" 'eshell-bol)))
  (setq eshell-cmpl-cycle-completions nil)

  ;; TODO: submit these via M-x report-emacs-bug
  (add-to-list 'eshell-visual-commands "ssh")
  (add-to-list 'eshell-visual-commands "tail")
  (add-to-list 'eshell-visual-commands "htop")
  (add-to-list 'eshell-command-completions-alist
               '("gunzip" "gz\\'"))
  (add-to-list 'eshell-command-completions-alist
               '("tar" "\\(\\.tar|\\.tgz\\|\\.tar\\.gz\\)\\'")))

;;;###autoload
(defun eshell/cdg ()
  "Change directory to the project's root."
  (eshell/cd (locate-dominating-file default-directory ".git")))

(provide 'maio-eshell)
