;; UI
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(set-frame-font "Iosevka 18" nil t)
(set-frame-parameter nil 'fullscreen 'maximized)
(setq make-backup-files nil)

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(global-auto-revert-mode t)


(add-hook 'text-mode-hook 'abbrev-mode)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Theme
(use-package eink-theme
  :ensure t
  :config
  (load-theme 'eink t))

;; Keys
;;;; Remove some Emacs specific bindings which I use due to muscle memory.
(global-unset-key (kbd "C-x C-s"))
(global-unset-key (kbd "C-a"))

;; Cltr-c,v,x for copy/paste/cut
(cua-mode t)

;; Try to make M-<,> work with select mode
(global-unset-key (kbd "M->"))
(global-unset-key (kbd "M-<"))
(define-key key-translation-map (kbd "M->") (kbd "M-."))
(define-key key-translation-map (kbd "M-<") (kbd "M-,"))

;; C-w map
(define-prefix-command 'windows-map)
(define-key windows-map "m" 'delete-other-windows)
(define-key windows-map "/" 'split-window-right)

(defun apply-ijkl-shortcuts (keymap)
  (define-key keymap (kbd "M-t") 'other-window)
  (define-key keymap (kbd "C-w") 'windows-map)
  (define-key keymap (kbd "M-l") 'forward-word)
  (define-key keymap (kbd "M-j") 'backward-word)
  (define-key keymap (kbd "M-i") 'previous-line)
  (define-key keymap (kbd "M-k") 'next-line)
  (define-key keymap (kbd "M-n") 'left-char)
  (define-key keymap (kbd "M-m") 'right-char)
  (define-key keymap (kbd "M-u") 'move-beginning-of-line)
  (define-key keymap (kbd "M-o") 'move-end-of-line)
  (define-key keymap (kbd "M-,") 'beginning-of-defun)
  (define-key keymap (kbd "M-.") 'end-of-defun)
  (define-key keymap (kbd "M-<") nil) ; TODO: should select
  (define-key keymap (kbd "M->") nil) ; TODO: should select
  (define-key keymap (kbd "M-f") 'scroll-up-command)
  (define-key keymap (kbd "M-w") 'scroll-down-command)
  (define-key keymap (kbd "M-SPC") 'isearch-forward)
  (define-key keymap (kbd "M-DEL") 'undo)
  (define-key keymap (kbd "C-s") 'save-buffer)
  (define-key keymap (kbd "C-a") 'mark-whole-buffer)
  (define-key keymap (kbd "C-x C-x") 'kill-whole-line)
  (define-key keymap (kbd "C-S-v") 'helm-show-kill-ring)
  (define-key keymap (kbd "M-y") 'kill-whole-line)
  (define-key keymap (kbd "M-d") 'kill-char-or-word)
  (define-key keymap (kbd "M-h") 'find-function-at-point)
  (define-key keymap (kbd "M-;") 'delete-char)
  (define-key keymap (kbd "<f12>") 'eshell)
  (define-key keymap (kbd "C-S-f") 'helm-do-grep-ag)
  (define-key keymap (kbd "C-S-o") 'helm-projectile-switch-project)
  (define-key keymap (kbd "C-S-n") 'helm-projectile)
  (define-key keymap (kbd "M-\\") 'projectile-run-shell-command-in-root)
  (define-key keymap (kbd "C-e") 'helm-mini)
  (define-key keymap (kbd "M-e") 'er/expand-region)
  (define-key keymap (kbd "M-E") 'er/contract-region)
  (define-key keymap (kbd "M-q") 'bury-buffer)
  (define-key keymap (kbd "C-S-j") 'idea-join-line)
  (define-key keymap (kbd "C-f") 'helm-occur)
  (define-key keymap (kbd "M-1") 'dired-sidebar-toggle-sidebar)

  ;; sexp-s
  (define-key keymap (kbd "M-0") 'sp-forward-slurp-sexp)
  (define-key keymap (kbd "M-9") 'sp-forward-barf-sexp)
  )

;;;;;; Page UP/DOWN
(setq scroll-error-top-bottom t)
;;;;;; Incremental search
(define-key isearch-mode-map (kbd "M-k") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "M-i") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "M-e") nil)
(define-key isearch-mode-map (kbd "M-y") nil)

(use-package dired
  :config
  (define-key dired-mode-map (kbd "M-1") 'quit-window)
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(use-package dired-sidebar
  :ensure t)

;;;; Duplicate line/region
(use-package duplicate-thing
  :ensure t
  :config
  (global-set-key (kbd "C-d") 'duplicate-thing))
;;;; Expand region
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "M-e") 'er/expand-region)
  (global-set-key (kbd "M-E") 'er/contract-region))
;;;; Comment
(use-package newcomment
  :config
  (defun comment-idea-dwim (arg)
    (interactive "*P")
    (if (use-region-p)
	(comment-or-uncomment-region (region-beginning) (region-end) arg)
      (call-interactively 'comment-line)))

  (global-set-key (kbd "C-_") 'comment-idea-dwim)
  (global-set-key (kbd "C-/") 'comment-idea-dwim))


;;;; Add Selection for Next Occurence
(use-package multiple-cursors
  :ensure t
  :config
  (defun mc/mark-next-like-this-symbol (arg)
    ;; Modified version of mc/mark-next-like-this-symbol - does not
    ;; select next symbol on first keypress so that it works similar
    ;; way as in IDEA.
    (interactive "p")
    (if (< arg 0)
	(let ((cursor (mc/furthest-cursor-after-point)))
          (if cursor
              (mc/remove-fake-cursor cursor)
            (error "No cursors to be unmarked")))
      (if (region-active-p)
          (mc/mark-more-like-this (= arg 0) 'forwards)
	(mc--select-thing-at-point 'symbol)))
    (mc/maybe-multiple-cursors-mode))
  (global-set-key (kbd "M-g") 'mc/mark-next-like-this-symbol))
;;;; Find buffer/file
(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-e" . helm-mini)
         ("C-x C-f" . helm-find-files))
  :bind (:map helm-map
	      ("M-i" . helm-previous-line)
	      ("M-k" . helm-next-line)
	      ("M-w" . helm-previous-page)
	      ("M-f" . helm-next-page)
	      ("C-x g" . helm-ff-run-magit)
	      :map helm-find-files-map
	      ("M-i" . helm-previous-line)
	      ("M-k" . helm-next-line)
	      ("M-j" . helm-find-files-up-one-level)
	      ("M-l" . helm-execute-persistent-action)
	      ("C-x g" . helm-ff-run-magit))
  :config (progn
	    (define-key helm-major-mode-map (kbd "C-x g") 'helm-ff-run-magit)
	    ;; (setq helm-grep-ag-command "rg --color=always --smart-case --no-heading --line-number %s %s %s")
	    (setq helm-buffers-fuzzy-matching t)
            (helm-mode 1)))

(use-package point-stack
  :ensure t
  :config
  (setq point-stack-advised-functions
   '(isearch-mode find-function-do-it find-library imenu beginning-of-buffer end-of-buffer xref-find-definitions helm-mini magit-diff-visit-file))
  (point-stack-setup-advices)
  (global-set-key (kbd "M-b") 'point-stack-pop))

(use-package wgrep-helm
  :ensure t
  :config
  (add-hook 'helm-grep-after-init-hook 'wdired-change-to-wdired-mode))

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(use-package idle-highlight-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'idle-highlight-mode)
  (add-hook 'text-mode-hook 'idle-highlight-mode))

(use-package org
  :ensure t
  :config
  (apply-ijkl-shortcuts org-mode-map))

(apply-ijkl-shortcuts global-map)

;; Packages
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  (setq magit-diff-refine-hunk t)
  (add-hook 'with-editor-mode-hook 'flyspell-mode)
  (magit-auto-revert-mode -1)
  (apply-ijkl-shortcuts magit-revision-mode-map)
  (apply-ijkl-shortcuts magit-status-mode-map)
  (apply-ijkl-shortcuts magit-mode-map)
  (define-key magit-status-mode-map (kbd "M-.") 'magit-section-forward-sibling)
  (define-key magit-status-mode-map (kbd "M-,") 'magit-section-backward-sibling)

  (defun maybe-magit-refresh ()
    (interactive)
    (when (eq major-mode 'magit-status-mode)
      (magit-refresh)))
  
  (add-hook 'focus-in-hook 'maybe-magit-refresh))

(use-package fullframe
  :ensure t
  :config
  (fullframe magit-status magit-mode-quit-window nil)
  (fullframe magit-show-commit magit-mode-bury-buffer nil))

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package org-brain
  :ensure t)

(use-package projectile
  :ensure t
  :config
  (setq projectile-project-search-path '("~/Projects"))
  (projectile-discover-projects-in-search-path))

(use-package helm-projectile
  :ensure t
  :bind (:map helm-projectile-find-file-map
	      ("C-S-n" . helm-ff-run-switch-project)
	      ("C-x g" . helm-ff-run-magit))
  :bind (:map helm-buffer-map
	      ("C-S-n" . helm-ff-run-switch-project)
	      ("C-x g" . helm-ff-run-magit))
  :config
  (helm-projectile-define-key helm-projectile-projects-map
    (kbd "C-x g") #'helm-projectile-vc)
  (helm-projectile-define-key helm-projectile-find-file-map
    (kbd "C-x g") #'helm-projectile-vc)
  (projectile-mode 1))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

;; Functions
(defun kill-char-or-word ()
  (interactive)
  (cond
   ((looking-at (rx (char word)))
    (kill-word 1))
   ((looking-at (rx (char blank)))
    (forward-kill-whitespace))
   (t
    (delete-char 1))))

;; https://github.com/tarsius/killer/blob/ace0547944933440384ceeb5876b1f68c082d540/killer.el#L128
(defun forward-kill-whitespace ()
  "Kill all spaces and tabs after point."
  (interactive)
  (let ((orig-pos (point)))
    (kill-region (progn (skip-chars-forward " \t")
                        (constrain-to-field nil orig-pos))
                 orig-pos)))

(defun helm-ff-run-magit ()
    "Run magit from a helm session"
    (interactive)
    (with-helm-alive-p
      (helm-run-after-exit
       'magit-status)))

(defun helm-ff-run-switch-project ()
    "Run helm-projectile-switch-project from a helm session"
    (interactive)
    (with-helm-alive-p
      (helm-run-after-exit
       'helm-projectile-switch-project)))

(defun idea-join-line ()
  (interactive)
  (next-logical-line)
  (join-line))

(let ((personal-settings "~/.personal.el"))
  (when (file-exists-p personal-settings)
    (message "Loading personal settings...")
    (load-file personal-settings)))

;; Customizations
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-completing-read-handlers-alist
   (quote
    ((describe-function . helm-completing-read-symbols)
     (describe-variable . helm-completing-read-symbols)
     (describe-symbol . helm-completing-read-symbols)
     (debug-on-entry . helm-completing-read-symbols)
     (find-function . helm-completing-read-symbols)
     (disassemble . helm-completing-read-symbols)
     (trace-function . helm-completing-read-symbols)
     (trace-function-foreground . helm-completing-read-symbols)
     (trace-function-background . helm-completing-read-symbols)
     (find-tag . helm-completing-read-default-find-tag)
     (xref-find-definitions . helm-completing-read-default-find-tag)
     (xref-find-references . helm-completing-read-default-find-tag)
     (ffap-alternate-file)
     (tmm-menubar)
     (find-file)
     (find-file-at-point . helm-completing-read-sync-default-handler)
     (ffap . helm-completing-read-sync-default-handler)
     (execute-extended-command)
     (dired-do-hardlink . helm-read-file-name-handler-1)
     (basic-save-buffer . helm-read-file-name-handler-1)
     (write-file . helm-read-file-name-handler-1)
     (write-region . helm-read-file-name-handler-1))))
 '(package-selected-packages
   (quote
    (point-stack nim-mode elixir-mode dired-sidebar dired-subtree clojure-mode wgrep-helm exec-path-from-shell idle-highlight-mode helm-projectile projectile org-brain fullframe magit helm multiple-cursors comment-dwim-2 killer expand-region duplicate-thing eink-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'dired-find-alternate-file 'disabled nil)

