;;; -*- lexical-binding: t -*-

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 0)
          (num-windows (count-windows)))
      (while  (< i (- num-windows 1))
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (% (+ i 1) num-windows)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))

(global-set-key (kbd "C-x i") 'rotate-windows)

;; toggle window split
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(define-key ctl-x-4-map "t" 'toggle-window-split)

;; read env from shell
(when (ui-type-is-gui)
  (ensure-package 'exec-path-from-shell)
  (require 'exec-path-from-shell)
  (add-to-list 'exec-path-from-shell-variables "ERL_LIBS")
  (add-to-list 'exec-path-from-shell-variables "PERL5LIB")
  (add-to-list 'exec-path-from-shell-variables "LANG")
  (add-to-list 'exec-path-from-shell-variables "LEIN_FAST_TRAMPOLINE")
  (add-to-list 'exec-path-from-shell-variables "LEIN_JVM_OPTS")
  (exec-path-from-shell-initialize))

;; org-capture
(with-eval-after-load 'org
  (setq org-default-notes-file (concat org-directory "/notes.org")))

(global-set-key (kbd "C-c c") 'org-capture)

;; recenter screen after search
(when evil-mode
  (defadvice evil-search-previous (after recenter () activate) (recenter))
  (defadvice evil-search-next (after recenter () activate) (recenter)))

;; paren-face
(ensure-package 'paren-face)
(require 'paren-face)
(setq paren-face-regexp "[(){}]")
(add-hook 'prog-mode-hook 'paren-face-mode)

;; org-reveal
(with-eval-after-load 'org
  (ensure-package 'ox-reveal)
  (require 'ox-reveal)
  (setq org-reveal-theme "sky"
        org-reveal-title-slide-template "<h1>%t</h1><h2>%a</h2><h3>%e</h3>"))

;; move to new window
(defadvice split-window-right (after switch-to-it () activate) (other-window 1))
(defadvice split-window-below (after switch-to-it () activate) (other-window 1))

;; coffee
(use-package coffee-mode
  :config
  (setq coffee-tab-width 2))

;; expand-region
(ensure-package 'expand-region)
(when evil-mode
  (define-key evil-visual-state-map "." 'er/expand-region))

;; hydra
(ensure-package 'hydra)
(setq hydra-is-helpful nil)

(defun maio/highlight-symbol-at-point ()
  (interactive)
  (let* ((regexp (hi-lock-regexp-okay
                  (find-tag-default-as-symbol-regexp)))
         (face 'hi-yellow))
    (unless hi-lock-mode (hi-lock-mode 1))
    (hi-lock-set-pattern regexp face)))

(defun windmove-right-or-create ()
  (interactive)
  (condition-case err
      (call-interactively 'windmove-right)
    (error
     (call-interactively 'split-window-right))))

(defun windmove-down-or-create ()
  (interactive)
  (condition-case err
      (call-interactively 'windmove-down)
    (error
     (call-interactively 'split-window-below))))

(setq hydra-lv nil)
(global-set-key (kbd "s-h") 'windmove-left)
(global-set-key (kbd "s-j") 'windmove-down-or-create)
(global-set-key (kbd "s-k") 'windmove-up)
(global-set-key (kbd "s-l") 'windmove-right-or-create)

(defhydra hydra-yank-pop ()
  "yank"
  ("C-y" yank nil)
  ("M-y" yank-pop nil)
  ("n" (yank-pop 1) "next")
  ("p" (yank-pop -1) "prev"))

(global-set-key (kbd "M-y") #'hydra-yank-pop/yank-pop)
(global-set-key (kbd "C-y") #'hydra-yank-pop/yank)
(global-set-key (kbd "s-v") #'hydra-yank-pop/yank)

(ensure-package 'avy)
(defun avy-action-copy-thing (pt)
  (save-excursion
    (goto-char pt)
    (let* ((thing (if (looking-at "(") 'sexp 'symbol))
           (str (thing-at-point thing t)))
      (kill-new str)
      (message "Copied: %s" str)))
  (let ((dat (ring-ref avy-ring 0)))
    (select-frame-set-input-focus
     (window-frame (cdr dat)))
    (select-window (cdr dat))
    (goto-char (car dat))))

(defun avy-action-copy-and-paste-thing (pt)
  (avy-action-copy-thing pt)
  (yank))

(setq avy-all-windows t
      avy-word-punc-regexp "[!-/-@[-`{-~]"
      avy-dispatch-alist '((?y . avy-action-copy-thing)
                           (?x . avy-action-kill-stay))
      avy-keys '(?q ?w ?e ?r ?t    ?u ?i ?o ?p
                    ?a ?s ?d ?f ?g ?h ?j ?k ?l
                    ?z    ?c ?v ?b ?n ?m))
(define-key evil-normal-state-map (kbd "SPC") 'avy-goto-word-1)
(define-key evil-motion-state-map (kbd "SPC") 'avy-goto-char)

(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; racket
(use-package racket-mode
  :defer t)

;; gcloud
(with-eval-after-load 'tramp
  (push
   (cons
    "gcloud"
    '((tramp-login-program "gcloud")
      (tramp-login-args (("compute" "ssh") ("%h") ("--zone=europe-west1-d" "--ssh-flag=\"-A\"")))
      (tramp-remote-shell "/bin/sh")
      (tramp-remote-shell-args ("-i") ("-c"))))
   tramp-methods))

;; helm compile + terminal
(with-eval-after-load 'helm
  (require 'helm-terminal)
  (require 'helm-compile)
  (defun helm-compile-and-terminal ()
    "Preconfigured `helm' for terminal."
    (interactive)
    (helm-other-buffer
     '(helm-c-source-compilation-buffers
       helm-c-source-terminal-buffers
       helm-c-source-compile-history
       helm-c-source-compile
       helm-c-source-new-terminal)
     "*helm comterm*"))

  (global-set-key (kbd "<s-return>") 'helm-compile-and-terminal))

(use-package xterm-color
  :config
  (setenv "TERM" "xterm-256color")
  (setq compilation-environment '("TERM=xterm-256color"))

  (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
  (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
  (with-eval-after-load 'eshell
    (add-hook 'eshell-mode-hook
              (lambda ()
                (setq xterm-color-preserve-properties t)
                (add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
                (setq eshell-output-filter-functions (remove 'eshell-handle-ansi-color eshell-output-filter-functions))))))

(provide 'maio-experiments)
