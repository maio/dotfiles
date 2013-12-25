(setq org-indent-indentation-per-level 1)

(eval-after-load 'org
  '(progn
     (require 'org-indent)

     (defun maio/unbind-org-mode-comma ()
       (org-defkey org-mode-map [(control ?,)] nil))
     (add-hook 'org-mode-hook 'maio/unbind-org-mode-comma)
     (add-hook 'org-mode-hook 'org-indent-mode)
     (add-hook 'org-insert-heading-hook 'evil-insert-state)))

(provide 'maio-org)