;; VIM emulation
(require 'cl-lib)
(setq evil-move-cursor-back nil)
(setq evil-want-C-i-jump t)
(setq evil-repeat-move-cursor nil)
(setq evil-regexp-search t)
(setq evil-cross-lines t)
(setq-default evil-symbol-word-search t)
(setq ace-jump-mode-case-sensitive-search nil
      ace-jump-mode-gray-background nil
      ace-jump-mode-scope 'window)

(setq-default cursor-type '("DeepSkyBlue2" box))
(setq evil-default-cursor '("DeepSkyBlue2" box))
(setq evil-normal-state-cursor '("black" box))
(setq evil-insert-state-cursor '("DeepSkyBlue2" box))
(setq evil-emacs-state-cursor '("DeepSkyBlue2" box))

(require 'evil)
(evil-mode 1)
(cl-loop for (mode . state) in '((inferior-emacs-lisp-mode      . emacs)
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
                                 (magit-process-mode            . emacs)
                                 (rdictcc-buffer-mode           . emacs)
                                 (dired-mode                    . normal)
                                 (wdired-mode                   . normal)
                                 (compilation-mode              . emacs)
                                 (diff-mode                     . emacs)
                                 (tar-mode                      . emacs)
                                 (archive-mode                  . emacs)
                                 (ert-results-mode              . emacs)
                                 (image-mode                    . emacs)
                                 (ag-mode                       . emacs)
                                 (profiler-report-mode          . emacs)
                                 (cider-test-report-mode        . emacs)
                                 (cider-docview-mode            . emacs)
                                 (cider-repl-mode               . insert)
                                 (makey-key-mode                . emacs))
         do (evil-set-initial-state mode state))

(evil-define-key 'normal dired-mode-map "v" 'evil-visual-block)
(evil-define-key 'normal dired-mode-map "i" 'evil-insert-state)

(add-hook 'dired-mode-hook
          (lambda ()
            (add-hook 'evil-insert-state-entry-hook 'wdired-change-to-wdired-mode nil 'make-it-local)
            (add-hook 'evil-visual-state-entry-hook 'wdired-change-to-wdired-mode nil 'make-it-local)
            (add-hook 'evil-operator-state-entry-hook 'wdired-change-to-wdired-mode nil 'make-it-local)))

(setcdr evil-insert-state-map nil) ;; make insert state like emacs state
(define-key evil-insert-state-map "\C-r" 'evil-paste-from-register)
(define-key evil-normal-state-map (kbd "C-j") 'newline)
(define-key evil-normal-state-map "U" 'undo-tree-visualize)
(define-key evil-normal-state-map [remap yank-pop] nil)
(define-key evil-normal-state-map (kbd "C-y") 'yank)
(define-key evil-normal-state-map (kbd "M-y") 'yank-pop)
(define-key evil-normal-state-map (kbd "C-a") 'evil-first-non-blank)
(define-key evil-visual-state-map (kbd "C-a") 'evil-first-non-blank)
(define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
(define-key evil-visual-state-map (kbd "C-e") 'move-end-of-line)
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
(define-key evil-normal-state-map "L" 'move-end-of-line)
(define-key evil-visual-state-map "L" 'move-end-of-line)
(define-key evil-normal-state-map (kbd "C-w") 'delete-trailing-whitespace)
(define-key evil-normal-state-map "3" 'toggle-comment-on-line-or-region)
(define-key evil-visual-state-map "3" 'toggle-comment-on-line-or-region)
;; make it easy to switch to visual-char mode from visual-block mode
(define-key evil-visual-state-map "v" 'evil-visual-block)
(define-key evil-normal-state-map (kbd "C-v") 'scroll-up-command)
(define-key evil-motion-state-map (kbd "C-v") 'scroll-up-command)
(define-key evil-insert-state-map (kbd "<C-return>") 'evil-open-above)
(define-key evil-insert-state-map (kbd "M-RET") 'evil-open-below)
(define-key evil-visual-state-map "u" nil)
(define-key evil-visual-state-map "Q" "gq")
(define-key evil-normal-state-map "Q" "gqap")
(define-key evil-normal-state-map "S" "vabsba")
(define-key evil-normal-state-map "s" "gv")
(define-key evil-normal-state-map (kbd "M-h") 'paredit-backward)
(define-key evil-normal-state-map (kbd "M-l") 'paredit-forward)
(evil-define-key 'visual evil-surround-mode-map "S" "sba")
(define-key evil-normal-state-map "+" 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map "-" 'evil-numbers/dec-at-pt)

(evil-add-hjkl-bindings magit-blame-map 'emacs)
(evil-add-hjkl-bindings archive-mode-map 'emacs)
(evil-add-hjkl-bindings tar-mode-map 'emacs)
(evil-add-hjkl-bindings bookmark-bmenu-mode-map 'emacs
  "K" 'bookmark-bmenu-delete)
(evil-add-hjkl-bindings package-menu-mode-map 'emacs
  "/" 'maio/helm-occur)
(evil-add-hjkl-bindings magit-mode-map 'emacs)
(evil-add-hjkl-bindings magit-diff-mode-map 'emacs)
(evil-add-hjkl-bindings compilation-mode-map 'emacs
  "/" 'maio/helm-occur)
(evil-add-hjkl-bindings git-rebase-mode-map 'emacs
  "K" 'git-rebase-kill-line
  "h" 'describe-mode)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs
  "l" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings gist-list-menu-mode-map 'emacs
  "K" 'gist-kill-current)
(evil-add-hjkl-bindings magit-process-mode 'emacs)
(evil-add-hjkl-bindings ert-results-mode-map 'emacs)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk
  (kbd "C-j") 'magit-goto-next-section
  (kbd "C-k") 'magit-goto-previous-section)
(evil-add-hjkl-bindings grep-mode-map 'emacs)
(evil-add-hjkl-bindings helm-grep-mode-map 'emacs)
(evil-add-hjkl-bindings ag-mode-map 'emacs)
(evil-add-hjkl-bindings profiler-report-mode-map 'emacs
  "\r" 'profiler-report-find-entry)
(evil-add-hjkl-bindings diff-mode-map 'emacs
  "q" 'quit-window)

(define-key evil-normal-state-map (kbd "SPC") 'evil-ace-jump-word-mode)
(define-key evil-normal-state-map "/" 'maio/helm-occur)

(defun maio/count-region-chars (beg end)
  (interactive "r")
  (message (format "Chars count: %s" (- end beg))))

(define-key evil-visual-state-map "ga" 'maio/count-region-chars)

;; org mode
(with-eval-after-load 'org
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

  (evil-define-key 'insert org-mode-map
    (kbd "M-p") 'org-metaup
    (kbd "M-n") 'org-metadown)
  (evil-define-key 'normal org-mode-map
    "gh" 'outline-up-heading
    "t" 'org-todo
    "T" 'org-set-tags
    "H" 'org-beginning-of-line
    "L" 'org-end-of-line
    (kbd "M-p") 'org-metaup
    (kbd "M-n") 'org-metadown
    (kbd "TAB") 'org-cycle
    (kbd "<tab>") 'org-cycle))

;; Evil plugins
(require 'evil-surround)
(global-evil-surround-mode 1)
(define-key evil-visual-state-map "s" 'evil-surround-edit)

(defun maio-after-save-state ()
  (interactive)
  (when (evil-insert-state-p) (evil-normal-state)))
(add-hook 'after-save-hook 'maio-after-save-state)

(provide 'maio-evil)
