;; copy of starter-kit-eshell.el --- Saner defaults and goodies: eshell tweaks

(setq eshell-cmpl-cycle-completions nil
      eshell-save-history-on-exit t
      eshell-buffer-shorthand t
      eshell-cmpl-dir-ignore "\\`\\(\\.\\.?\\|CVS\\|\\.svn\\|\\.git\\)/\\'")

(defun eshell/clear ()
  "Clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-emit-prompt)))

(defun maio/eshell-setup ()
  (setenv "PAGER" "cat")
  (setq eshell-path-env (getenv "PATH"))
  (when evil-mode
    (evil-define-key 'normal eshell-mode-map [escape] "gi"))
  (define-key eshell-mode-map "\C-a" 'eshell-bol)
  (define-key eshell-mode-map (kbd "s-L") 'eshell/clear))

;;;###autoload
(with-eval-after-load 'esh-opt
  (require 'em-prompt)
  (require 'em-term)
  (require 'em-cmpl)
   ;; for some reason this needs to be a hook
  (add-hook 'eshell-mode-hook 'maio/eshell-setup)
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
