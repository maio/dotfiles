(setq org-indent-indentation-per-level 1
      org-indent-mode-turns-on-hiding-stars t
      org-hide-leading-stars t
      org-src-fontify-natively t
      org-fontify-whole-heading-line t
      org-fontify-whole-heading-lines t
      org-tags-column -79
      org-imenu-depth 10
      org-cycle-separator-lines 1
      org-confirm-babel-evaluate nil
      org-export-babel-evaluate nil
      org-hide-emphasis-markers t
      org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/focus.org" "Inbox")
         "* TODO %?\n%a" :empty-lines-after 1)
        ("e" "Emacs Improvement" entry (file+olp "~/org/focus.org" "Emacs" "Improve")
         "* TODO %?\n%a" :prepend t)
        ("d" "Avast Defects [New]" entry (file+olp "~/org/focus.org" "Avast" "Defects")
         "* %t %? :new:" :prepend t)
        ("D" "Avast Defects [Fix]" entry (file+olp "~/org/focus.org" "Avast" "Defects")
         "* %t %? :fix:" :prepend t)))

(setq org-todo-keywords
      (quote ((sequence "TODO" "NEXT" "IMPEDIMENT" "DONE"))))

(defun org-linespacing ()
  (setq line-spacing 6))

(use-package org
  :defer t
  :config
  (require 'org-indent)

  ;; improve UX of src template - do not add extra newline between begin and end
  (add-to-list 'org-structure-template-alist
               '("s" "#+BEGIN_SRC ?\n#+END_SRC" "<src lang=\"?\">\n</src>"))

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
  (add-hook 'org-mode-hook 'org-bullets-mode)
  (when evil-mode
    (add-hook 'org-insert-heading-hook 'evil-insert-state)))

;; https://zhangda.wordpress.com/2016/02/15/configurations-for-beautifying-emacs-org-mode/
(use-package org-bullets
  :defer t
  :init
  (setq org-bullets-bullet-list '("●" "◎" "○" "⊙" "￮" "∘" "∙")))

;; http://orgmode.org/manual/Handling-links.html
(global-set-key (kbd "C-c l") 'org-store-link)

(defun recenter-top ()
  (interactive)
  (recenter 0))

(when evil-mode
  (evil-define-key 'normal org-mode-map "]]" 'org-next-visible-heading)
  (evil-define-key 'normal org-mode-map "[[" 'org-previous-visible-heading))

(defadvice org-next-visible-heading (after recenter activate)
  (recenter-top))

(defadvice org-previous-visible-heading (after recenter activate)
  (recenter-top))

(defadvice org-capture-place-entry (after insert-state activate)
  (evil-insert-state))

(provide 'maio-org)
