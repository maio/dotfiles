(setq org-indent-indentation-per-level 1
      org-indent-mode-turns-on-hiding-stars t
      org-hide-leading-stars t)

(setq org-todo-keywords
      (quote ((sequence "TODO" "NEXT" "DONE"))))

(defun org-linespacing ()
  (setq line-spacing 6))

(with-eval-after-load 'org
  (require 'org-indent)
  (require 'org-present)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (ruby . t)
     (python . t)
     (ditaa . t)
     (sh . t)))

  (setq org-ditaa-jar-path (s-trim (shell-command-to-string "brew ls ditaa | grep jar")))

  (defun maio/unbind-org-mode-comma ()
    (org-defkey org-mode-map [(control ?,)] nil))
  (define-key org-mode-map (kbd "C-x c i") 'helm-org-headlines)
  (add-hook 'org-mode-hook 'maio/unbind-org-mode-comma)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'turn-on-smartparens-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook 'org-linespacing)
  (add-hook 'org-insert-heading-hook 'evil-insert-state))

;; http://orgmode.org/manual/Handling-links.html
(global-set-key (kbd "C-c l") 'org-store-link)

(evil-define-key 'normal org-mode-map "]]" 'org-present-next)
(evil-define-key 'normal org-mode-map "[[" 'org-present-prev)

(provide 'maio-org)
