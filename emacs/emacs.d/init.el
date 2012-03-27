(add-to-list 'load-path "~/.emacs.d")
(require 'maio-util)

(add-to-list 'exec-path "/opt/local/bin")
(set-face-attribute 'default nil :height 160)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq backup-inhibited t)
(global-auto-revert-mode 1)
(setq fill-column 80)
(setq-default tab-width 4)
(setq c-basic-offset 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(column-number-mode 1)

;; Shell
(setq eshell-scroll-to-bottom-on-output t)
(setq ansi-color-for-comint-mode t)
(setq comint-prompt-read-only nil)

;; Magit
(setq magit-rewrite-inclusive nil)
(setq magit-status-buffer-switch-function 'switch-to-buffer)

(require 'maio-php)
(require 'perl-mode)
(defalias 'cperl-mode 'perl-mode)

(require-and-exec 'package
  (add-to-list 'package-archives
               '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (let ((my-packages '(starter-kit
                       starter-kit-lisp
                       starter-kit-bindings
                       undo-tree
                       autopair
                       project
                       goto-last-change
                       clojure-mode midje-mode
                       anything
                       anything-config
                       anything-match-plugin
                       ack-and-a-half
                       flymake
                       flymake-cursor
                       rainbow-mode
                       diminish
                       zenburn-theme
                       popup
                       fuzzy
                       multi-eshell
                       yasnippet yasnippet-bundle)))
    (dolist (package my-packages)
      (when (not (package-installed-p package))
        (package-install package)))))

(add-hook 'clojure-mode-hook 'midje-mode)

(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.body$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.spec$" . sql-mode))

(defun edit-init () (interactive) (find-file "~/.emacs.d/init.el"))
(defun kill-current-buffer () (interactive) (kill-buffer (current-buffer)))

(defun toggle-comment-on-line-or-region ()
  "Comments or uncomments current current line or whole lines in region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position)
                                 (line-end-position))))

(require 'feature-mode)

;; VIM emulation
(add-to-list 'load-path "~/.emacs.d/evil")
(setq evil-move-cursor-back nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump t)
(setq evil-repeat-move-cursor nil)
(setq evil-regexp-search t)
(require 'evil)
(evil-mode 1)
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

(evil-define-key 'normal perl-mode-map
  "=" 'perltidy-dwim)

(evil-define-key 'visual perl-mode-map
  "=" 'perltidy-dwim)

(evil-define-key 'normal php-mode-map
  "K" 'my-php-function-lookup)

(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)

;; Evil plugins
(add-to-list 'load-path "~/.emacs.d/evil-plugins/surround")
(require 'surround)
(global-surround-mode 1)

;;;; Devel
(which-func-mode 1)

(require 'sqlplus)
(require 'perltidy)

(require-and-exec 'autopair
  (autopair-global-mode 1))
(setq autopair-autowrap t)

(require 'tramp)
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(defun kill-all-buffers ()
  (interactive)
    (mapc 'kill-buffer (buffer-list)))

(load-theme 'cofi-dark t)

(add-hook 'after-save-hook 'evil-normal-state)

(require 'anything-project)
(ap:add-project
 :name 'default
 :look-for '(".git"))

(require 'anything-match-plugin)
(setq anything-for-files-prefered-list
  '(anything-c-source-ffap-line
    anything-c-source-ffap-guesser
    anything-c-source-buffers+
    anything-c-source-recentf
    anything-c-source-bookmarks
    anything-c-source-file-cache
    anything-c-source-files-in-current-dir+))

(require-and-exec 'recentf
  (setq recentf-max-saved-items 100)
  (add-to-list 'recentf-exclude "emacs.d"))

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(setq ac-ignore-case 'smart)
(setq ac-delay 0.1)
(setq ac-auto-show-menu nil)
(setq ac-quick-help-delay 0.5)
(require-and-exec 'auto-complete-config)
(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map "\C-n" 'ac-next)
(define-key ac-completing-map "\C-p" 'ac-previous)
;; (define-key ac-completing-map [return] nil)
;; (define-key ac-completing-map "\r" nil)
(defun ac-common-setup ()
  (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  (add-to-list 'ac-sources 'ac-source-yasnippet))
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-modes 'eshell-mode)

;; (require 'flymake)
;; (require 'flymake-cursor)
;; (push '(".+\\.t$" flymake-perl-init) flymake-allowed-file-name-masks)
;; (add-hook 'perl-mode-hook
;;     (lambda () (flymake-mode nil)))

(require 'diminish)
(eval-after-load 'yasnippet '(diminish 'yas/minor-mode "YS"))
(eval-after-load 'eldoc '(diminish 'eldoc-mode))
(eval-after-load 'undo-tree '(diminish 'undo-tree-mode))
(eval-after-load 'hi-lock '(diminish 'hi-lock-mode))
(eval-after-load 'auto-complete '(diminish 'auto-complete-mode "AC"))
(eval-after-load 'autopair '(diminish 'autopair-mode "()"))
(eval-after-load 'simple '(diminish 'auto-fill-function))

(setq-default
 mode-line-format
 (list
  '(evil-mode ("" evil-mode-line-tag))
  ;; modified mark
  "%* "

  ;; the buffer name; the file name as a tool tip
  '(:eval (propertize "%b "
                      'help-echo (buffer-file-name)))

  ;; line and column
  "" ;; '%02' to set to 2 chars at least; prevents flickering
  (propertize "%02l") ","
  (propertize "%02c")
  " "

  ;; relative position, size of file
  (propertize "%p ") ;; % above top

  ;; the current major mode for the buffer.
  '(:eval (propertize "%m"
                      'help-echo buffer-file-coding-system))

  ;; i don't want to see minor-modes; but if you want, uncomment this:
  minor-mode-alist  ;; list of minor modes

  " "
  ;; current function
  '(which-func-mode ("" which-func-format " "))

  " %-" ;; fill with '-'
  ))

;; Use UTF-8 dammit
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(defun recompile-my-files ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d/" 0))

(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
(hl-line-mode nil)

(put 'narrow-to-region 'disabled nil)

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

(defun show-trailing-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'show-trailing-whitespace)

(defun shell () (interactive) (eshell))
