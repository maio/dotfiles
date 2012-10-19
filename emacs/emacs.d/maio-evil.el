;; VIM emulation
(add-to-list 'load-path "~/.emacs.d/evil")
(setq evil-move-cursor-back nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump t)
(setq evil-repeat-move-cursor nil)
(setq evil-regexp-search t)
(require 'evil)
(evil-mode 1)
(loop for (mode . state) in '((inferior-emacs-lisp-mode      . emacs)
                              (pylookup-mode                 . emacs)
                              (comint-mode                   . emacs)
                              (shell-mode                    . emacs)
                              (term-mode                     . emacs)
                              (rmail-mode                    . normal)
                              (rmail-summary-mode            . emacs)
                              (bc-menu-mode                  . emacs)
                              (magit-branch-manager-mode-map . emacs)
                              (magit-log-edit-mode           . insert)
                              (rdictcc-buffer-mode           . emacs))
      do (evil-set-initial-state mode state))

(define-key evil-emacs-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-replace-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-g") 'evil-normal-state)
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

(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs
  "l" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings rmail-summary-mode-map 'emacs
  "K" 'rmail-summary-kill-label)
(evil-add-hjkl-bindings rmail-mode-map 'normal
  "q" 'kill-current-buffer
  "H" 'rmail-summary)

;; ace-jump integration
(require 'ace-jump-mode)
(setq ace-jump-mode-case-sensitive-search nil)

(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-word-mode)
(define-key evil-visual-state-map (kbd "SPC") 'ace-jump-word-mode)
(define-key evil-motion-state-map (kbd "SPC") 'ace-jump-word-mode)
(define-key evil-normal-state-map (kbd "C-SPC") 'ace-jump-line-mode)

;; Evil plugins
(add-to-list 'load-path "~/.emacs.d/evil-plugins/surround")
(require 'surround)
(global-surround-mode 1)
(add-hook 'after-save-hook 'evil-normal-state)

(provide 'maio-evil)
