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
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
(define-key evil-motion-state-map (kbd "TAB") "%")
(define-key evil-motion-state-map (kbd "gp") "`[V`]")
(define-key evil-normal-state-map "H" 'evil-first-non-blank)
(define-key evil-visual-state-map "H" 'evil-first-non-blank)
(define-key evil-normal-state-map "L" 'evil-last-non-blank)
(define-key evil-visual-state-map "L" 'evil-last-non-blank)
(define-key evil-normal-state-map (kbd "C-w") 'delete-trailing-whitespace)
(define-key evil-normal-state-map "3" 'toggle-comment-on-line-or-region)
(define-key evil-visual-state-map "3" 'toggle-comment-on-line-or-region)
(define-key evil-motion-state-map (kbd "C-v") 'evil-visual-char)
(define-key evil-motion-state-map "v" 'evil-visual-block)
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

(evil-define-command cofi/evil-maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p))
        (entry-key ?j)
        (exit-key ?k))
    (insert entry-key)
    (let ((evt (read-event (format "Insert %c to exit insert state" exit-key) nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt exit-key))
          (delete-char -1)
          (set-buffer-modified-p modified)
          (push 'escape unread-command-events))
       (t (push evt unread-command-events))))))

(define-key evil-insert-state-map "j" 'cofi/evil-maybe-exit)

(evil-define-command maio/evil-maybe-write ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p))
        (entry-key ?,)
        (exit-key ?w))
    (insert entry-key)
    (let ((evt (read-event (format "Insert %c to save buffer" exit-key) nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt exit-key))
        (delete-char -1)
        (set-buffer-modified-p modified)
        (save-buffer)
        (push 'escape unread-command-events))
       (t (push evt unread-command-events))))))

(define-key evil-insert-state-map "," 'maio/evil-maybe-write)

(evil-define-key 'normal cperl-mode-map
  "=" 'perltidy-dwim)

(evil-define-key 'visual cperl-mode-map
  "=" 'perltidy-dwim)

(evil-define-key 'normal php-mode-map
  "K" 'my-php-function-lookup)

(defun maio/space-after-comma () (interactive) (insert ", "))
(defun maio/return-after-comma () (interactive) (insert ",") (push 'return unread-command-events))
(defun my-eval-defun ()
  (interactive)
  (if (in-mode? 'clojure-mode)
      (lisp-eval-defun)
    (eval-defun nil)))

(define-key key-translation-map [?,] [(control ?,)])
(global-set-key (kbd "C-, SPC") 'maio/space-after-comma)
(global-set-key (kbd "C-, RET") 'maio/return-after-comma)
(global-set-key (kbd "C-, s") 'save-buffer)
(global-set-key (kbd "C-, w") 'save-buffer)
(global-set-key (kbd "C-, v") 'edit-init)
(global-set-key (kbd "C-, t") 'anything-project)
(global-set-key (kbd "C-, C-,") 'evil-buffer)
(global-set-key (kbd "C-, e") 'my-eval-defun)
(global-set-key (kbd "C-, b") 'anything-for-files)
(global-set-key (kbd "C-, g") 'magit-status)
(global-set-key (kbd "C-, k") 'kill-current-buffer)
(global-set-key (kbd "C-w") 'evil-delete-backward-word)

;; Evil plugins
(add-to-list 'load-path "~/.emacs.d/evil-plugins/surround")
(require 'surround)
(global-surround-mode 1)
(add-hook 'after-save-hook 'evil-normal-state)

(provide 'maio-evil)
