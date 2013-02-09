;; VIM emulation
(setq evil-move-cursor-back nil)
(setq evil-want-C-i-jump t)
(setq evil-repeat-move-cursor nil)
(setq evil-regexp-search t)
(require 'evil)
(evil-mode 1)
(loop for (mode . state) in '((inferior-emacs-lisp-mode      . emacs)
                              (nrepl-mode                    . insert)
                              (pylookup-mode                 . emacs)
                              (comint-mode                   . normal)
                              (shell-mode                    . emacs)
                              (term-mode                     . emacs)
                              (help-mode                     . emacs)
                              (helm-grep-mode                . emacs)
                              (grep-mode                     . emacs)
                              (rmail-mode                    . normal)
                              (rmail-summary-mode            . emacs)
                              (bc-menu-mode                  . emacs)
                              (magit-branch-manager-mode     . emacs)
                              (rdictcc-buffer-mode           . emacs))
      do (evil-set-initial-state mode state))

(define-key evil-emacs-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-replace-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "C-SPC") 'set-mark-command)
(define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
(define-key evil-motion-state-map (kbd "TAB") "%")
(define-key evil-motion-state-map (kbd "<tab>") "%")
(define-key evil-motion-state-map (kbd "gp") "`[V`]")
(define-key evil-normal-state-map "H" 'evil-first-non-blank)
(define-key evil-visual-state-map "H" 'evil-first-non-blank)
(define-key evil-normal-state-map "L" 'evil-last-non-blank)
(define-key evil-visual-state-map "L" 'evil-last-non-blank)
(define-key evil-normal-state-map (kbd "C-w") 'delete-trailing-whitespace)
(define-key evil-normal-state-map "3" 'toggle-comment-on-line-or-region)
(define-key evil-visual-state-map "3" 'toggle-comment-on-line-or-region)
(define-key evil-motion-state-map (kbd "C-v") 'er/expand-region)
(define-key evil-motion-state-map "v" 'evil-visual-block)
;; make it easy to switch to visual-char mode from visual-block mode
(define-key evil-visual-state-map "v" 'evil-visual-char)
(define-key evil-insert-state-map (kbd "<C-return>") 'evil-open-above)
(define-key evil-visual-state-map "u" nil)
(define-key evil-insert-state-map "\C-x\C-l" 'evil-complete-previous-line)
(define-key evil-visual-state-map (kbd "R") 'maio/mark-all-like-this)
(define-key evil-visual-state-map (kbd "r") 'maio/mark-all-like-this-in-defun)
(define-key evil-visual-state-map "Q" "gq")
(define-key evil-normal-state-map "Q" "gqap")
(define-key evil-normal-state-map "S" "vabsba")
(evil-define-key 'visual surround-mode-map "S" "sba")

(evil-add-hjkl-bindings magit-mode-map 'emacs)
(evil-add-hjkl-bindings magit-diff-mode-map 'emacs)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)
(evil-add-hjkl-bindings rebase-mode-map 'emacs
  "K" 'rebase-mode-kill-line
  "h" 'describe-mode)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs
  "l" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings rmail-summary-mode-map 'emacs
  "K" 'rmail-summary-kill-label)
(evil-add-hjkl-bindings rmail-mode-map 'normal
  "q" 'kill-current-buffer
  "H" 'rmail-summary)
(evil-add-hjkl-bindings grep-mode-map 'emacs)

;; ace-jump integration
(require 'ace-jump-mode)
(setq ace-jump-mode-case-sensitive-search nil)

;; idea from vim-seek (could also be used for f (evil-find-char)
(defun maio/ace-jump-two-char-mode (query-char query-char-2)
  "AceJump char mode"
  (interactive (list (read-char "First Char:")
                     (read-char "Second:")))

  (if (eq (ace-jump-char-category query-char) 'other)
    (error "[AceJump] Non-printable character"))

  ;; others : digit , alpha, punc
  (setq ace-jump-query-char query-char)
  (setq ace-jump-current-mode 'ace-jump-char-mode)
  (ace-jump-do (regexp-quote (concat (char-to-string query-char)
                                     (char-to-string query-char-2)))))

(define-key evil-normal-state-map (kbd "SPC") 'maio/ace-jump-two-char-mode)
(define-key evil-visual-state-map (kbd "SPC") 'ace-jump-word-mode)
(define-key evil-motion-state-map (kbd "SPC") 'ace-jump-word-mode)

;; sackspace
(require 'sackspace)
(sack/install-in-evil)
(define-key evil-insert-state-map (kbd "<DEL>") 'sack/tabstop)

;; Evil plugins
(require 'surround)
(global-surround-mode 1)
(add-hook 'after-save-hook 'evil-normal-state)

;; symbol object
(evil-define-text-object evil-inner-symbol (count &optional beg end type)
  "Select symbol."
  (evil-inner-object-range count beg end type #'forward-symbol))

(evil-define-text-object evil-symbol (count &optional beg end type)
  "Select symbol."
  (evil-an-object-range count beg end type #'forward-symbol))

(define-key evil-inner-text-objects-map "o" 'evil-inner-symbol)
(define-key evil-outer-text-objects-map "o" 'evil-symbol)

(setq eshell-prompt-function
  (lambda ()
    (concat (eshell/pwd) "\n$ "))
  eshell-prompt-regexp (concat "^" (regexp-quote "$")))

(provide 'maio-evil)
