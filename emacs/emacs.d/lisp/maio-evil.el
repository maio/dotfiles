;; VIM emulation
(setq evil-move-cursor-back nil)
(setq evil-want-C-i-jump t)
(setq evil-repeat-move-cursor nil)
(setq evil-regexp-search t)
(setq ace-jump-mode-case-sensitive-search nil
      ace-jump-mode-gray-background nil)

(require 'evil)
(evil-mode 1)
(loop for (mode . state) in '((inferior-emacs-lisp-mode      . emacs)
                              (nrepl-mode                    . insert)
                              (pylookup-mode                 . emacs)
                              (comint-mode                   . normal)
                              (shell-mode                    . insert)
                              (git-commit-mode               . insert)
                              (git-rebase-mode               . emacs)
                              (term-mode                     . emacs)
                              (help-mode                     . emacs)
                              (helm-grep-mode                . emacs)
                              (grep-mode                     . emacs)
                              (rmail-mode                    . normal)
                              (rmail-summary-mode            . emacs)
                              (bc-menu-mode                  . emacs)
                              (magit-branch-manager-mode     . emacs)
                              (rdictcc-buffer-mode           . emacs)
                              (dired-mode                    . normal)
                              (wdired-mode                   . normal))
      do (evil-set-initial-state mode state))

(evil-define-key 'normal dired-mode-map "v" 'evil-visual-block)
(evil-define-key 'normal dired-mode-map "i" 'evil-insert-state)

(add-hook 'dired-mode-hook
          (lambda ()
            (add-hook 'evil-insert-state-entry-hook 'wdired-change-to-wdired-mode nil 'make-it-local)
            (add-hook 'evil-visual-state-entry-hook 'wdired-change-to-wdired-mode nil 'make-it-local)
            (add-hook 'evil-operator-state-entry-hook 'wdired-change-to-wdired-mode nil 'make-it-local)))

(setcdr evil-insert-state-map nil) ;; make insert state like emacs state
(define-key evil-normal-state-map [remap yank-pop] nil)
(define-key evil-normal-state-map (kbd "C-y") 'yank)
(define-key evil-normal-state-map (kbd "M-y") 'yank-pop)
(define-key evil-insert-state-map (kbd "C-y") 'yank)
(define-key evil-insert-state-map "\C-n" 'auto-complete)
(define-key evil-insert-state-map "\C-p" 'evil-complete-previous)
(define-key evil-insert-state-map [escape] 'evil-normal-state)
(define-key evil-insert-state-map "\C-x\C-n" 'evil-complete-next-line)
(define-key evil-insert-state-map "\C-x\C-p" 'evil-complete-previous-line)
(define-key evil-insert-state-map "\C-x\C-l" 'evil-complete-previous-line)
(define-key evil-replace-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "C-SPC") 'set-mark-command)
(define-key evil-motion-state-map (kbd "TAB") "%")
(define-key evil-motion-state-map (kbd "<tab>") "%")
(define-key evil-motion-state-map "gp" "`[V`]")
(define-key evil-normal-state-map "gf" 'helm-find-files)
(define-key evil-normal-state-map "H" 'evil-first-non-blank)
(define-key evil-visual-state-map "H" 'evil-first-non-blank)
(define-key evil-normal-state-map "L" 'evil-last-non-blank)
(define-key evil-visual-state-map "L" 'evil-last-non-blank)
(define-key evil-normal-state-map (kbd "C-w") 'delete-trailing-whitespace)
(define-key evil-normal-state-map "3" 'toggle-comment-on-line-or-region)
(define-key evil-visual-state-map "3" 'toggle-comment-on-line-or-region)
(define-key evil-motion-state-map "v" 'evil-visual-block)
;; make it easy to switch to visual-char mode from visual-block mode
(define-key evil-visual-state-map "v" 'evil-visual-char)
(require 'expand-region)
(define-key evil-normal-state-map (kbd "C-v") 'er/expand-region)
(define-key evil-insert-state-map (kbd "<C-return>") 'evil-open-above)
(define-key evil-insert-state-map (kbd "M-RET") 'evil-open-below)
(define-key evil-visual-state-map "u" nil)
(define-key evil-visual-state-map "R" 'maio/mark-all-like-this)
(define-key evil-visual-state-map "r" 'maio/mark-all-like-this-in-defun)
(define-key evil-visual-state-map "Q" "gq")
(define-key evil-normal-state-map "Q" "gqap")
(define-key evil-normal-state-map "S" "vabsba")
(define-key evil-normal-state-map "s" "gv")
(define-key evil-normal-state-map (kbd "M-h") 'paredit-backward)
(define-key evil-normal-state-map (kbd "M-l") 'paredit-forward)
(evil-define-key 'visual surround-mode-map "S" "sba")
(define-key evil-normal-state-map "+" 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map "-" 'evil-numbers/dec-at-pt)


;; set modeline color depending on state
(defvar evil-state-change-hook nil)

(setq evil-insert-state-cursor "light sky blue")
(setq evil-emacs-state-cursor "green")

(evil-add-hjkl-bindings bookmark-bmenu-mode-map 'emacs
  "K" 'bookmark-bmenu-delete)
(evil-add-hjkl-bindings package-menu-mode-map 'emacs
  "/" 'helm-swoop)
(evil-add-hjkl-bindings magit-mode-map 'emacs)
(evil-add-hjkl-bindings magit-diff-mode-map 'emacs)
(evil-add-hjkl-bindings git-rebase-mode-map 'emacs
  "K" 'git-rebase-kill-line
  "h" 'describe-mode)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs
  "l" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings gist-list-menu-mode-map 'emacs
  "K" 'gist-kill-current)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk
  (kbd "C-j") 'magit-goto-next-section
  (kbd "C-k") 'magit-goto-previous-section)
(evil-add-hjkl-bindings grep-mode-map 'emacs)
(evil-add-hjkl-bindings helm-grep-mode-map 'emacs)

(evil-define-key 'normal dired-mode-map (kbd "SPC") 'evil-ace-jump-char-mode)
(define-key evil-normal-state-map (kbd "SPC") 'evil-ace-jump-word-mode)
(key-chord-define evil-normal-state-map (kbd "SPC SPC") 'evil-ace-jump-char-mode)
(define-key evil-motion-state-map "/" 'evil-ace-jump-char-mode)
(define-key evil-normal-state-map "/" 'evil-search-forward)
(define-key evil-motion-state-map (kbd "SPC") 'evil-ace-jump-line-mode)


(defun maio/count-region-chars (beg end)
  (interactive "r")
  (message (format "Chars count: %s" (- end beg))))

(define-key evil-visual-state-map "ga" 'maio/count-region-chars)

;; org mode
(eval-after-load 'org
  '(progn
     (defun always-insert-item ()
       "Force insertion of org item"
       (if (not (org-in-item-p))
           (insert "\n- ")
         (org-insert-item)))

     (defun evil-org-eol-call (fun)
       "Go to end of line and call provided function"
       (end-of-line)
       (funcall fun)
       (evil-append nil))

     (evil-define-key 'normal org-mode-map
       "gh" 'outline-up-heading
       "t" 'org-todo
       "H" 'org-beginning-of-line
       "L" 'org-end-of-line
       (kbd "TAB") 'org-cycle
       (kbd "<tab>") 'org-cycle)))

;; Evil plugins
(require 'surround)
(global-surround-mode 1)
(add-hook 'after-save-hook 'evil-normal-state)

(provide 'maio-evil)
