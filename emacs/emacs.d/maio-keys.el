(require 'maio-leader)

(setq maio/leader-action-alist
      '((?w . force-save-buffer)
        (?, . other-buffer-or-window)
        (?b . helm-mini)
        (?k . kill-current-buffer)
        (?t . helm-c-etags-select)
        (?f . helm-git-find-files)
        (?r . helm-resume)
        (?x . helm-M-x)
        (?s . helm-occur)
        (?v . find-config-file)
        (?e . my-eval-defun)
        (?n . maio-narrow-to-defun-clone)
        (?a . ack-and-a-half)
        (?1 . delete-other-windows)
        (?g . magit-status)))

(evil-define-key 'normal clojure-mode-map (kbd "RET") 'midje-check-fact)
(define-key magit-status-mode-map (kbd "p") 'maio-git-submit)

(defun maio/electric-semicolon ()
  (interactive)
  (call-interactively 'end-of-line)
  (when (not (looking-back ";"))
    (insert ";")))

(defun maio/electric-space ()
  (interactive)
  (cond ((looking-back "(\\|{")
         (insert "  ")
         (backward-char))
        (t (insert " "))))

(defun maio/electric-return ()
  (interactive)
  (cond ((looking-back "(\\|{")
         (newline-and-indent)
         (call-interactively 'evil-open-above))
        (t (newline-and-indent))))

(defun maio/makefile-newline ()
  (interactive)
  (insert "\\")
  (newline-and-indent))

(eval-after-load 'make-mode
  '(define-key makefile-gmake-mode-map (kbd "C-j") 'maio/makefile-newline))

(provide 'maio-keys)
