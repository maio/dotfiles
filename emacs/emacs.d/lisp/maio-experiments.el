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
(setenv "PATH" (s-trim (shell-command-to-string "bash -l -c 'echo $PATH'")))
(setq exec-path (s-split ":" (getenv "PATH")))
(setenv "ERL_LIBS" (s-trim (shell-command-to-string "bash -l -c 'echo $ERL_LIBS'")))
(setenv "PERL5LIB" (s-trim (shell-command-to-string "bash -l -c 'echo $PERL5LIB'")))

;; org-capture
(with-eval-after-load 'org
  (setq org-default-notes-file (concat org-directory "/notes.org")))

(global-set-key (kbd "C-c c") 'org-capture)

;; recenter screen after search
(defadvice evil-search-previous (after recenter () activate) (recenter))
(defadvice evil-search-next (after recenter () activate) (recenter))

;; parenface
(ensure-package 'parenface)
(require 'parenface)
(add-hook 'cperl-mode-hook 'paren-face-add-keyword)
(add-hook 'erlang-mode-hook 'paren-face-add-keyword)
(add-hook 'json-mode-hook 'paren-face-add-keyword)
(add-hook 'js2-mode-hook 'paren-face-add-keyword)
(add-hook 'emacs-lisp-mode-hook 'paren-face-add-keyword)

;; golden-ration
(ensure-package 'golden-ratio)
(setq golden-ratio-exclude-modes '("magit-key-mode"))
(require 'golden-ratio)
(golden-ratio-mode 1)
(diminish 'golden-ratio-mode nil)
(add-hook 'ediff-mode-hook (lambda () (golden-ratio-mode 0)))
(add-hook 'ediff-quit-hook (lambda () (golden-ratio-mode 1)))

;; eyebrowse
(ensure-package 'eyebrowse)
(setq eyebrowse-mode-line-separator " ")
(require 'eyebrowse)
(require 'dash)
(progn
  (let ((map eyebrowse-mode-map))
    (define-key map (kbd "C-'") 'eyebrowse-last-window-config)
    (define-key map (kbd "C-\"") 'eyebrowse-close-window-config)
    (define-key map (kbd "s-j") 'eyebrowse-next-window-config)
    (define-key map (kbd "s-k") 'eyebrowse-prev-window-config)
    (-map (lambda (n)
            (define-key map (kbd (s-concat "C-" (number-to-string n)))
              (lambda () (interactive)
                (eyebrowse-switch-to-window-config n)))) '(1 2 3 4 5 6))))

;;; eyebrowse build default windows
(progn
  (eyebrowse-switch-to-window-config 0)
  (eyebrowse-switch-to-window-config 4)
  (eyebrowse-switch-to-window-config 1))

(defadvice magit-status (before eyebrowse-window-0 () activate)
  (eyebrowse-switch-to-window-config 0)
  (delete-other-windows))

(defadvice magit-file-log (before eyebrowse-window-0 () activate)
  (eyebrowse-switch-to-window-config 0)
  (delete-other-windows))

(defadvice ansi-term (around eyebrowse-window-4 (program &optional new-buffer-name) activate)
  (let ((dir default-directory)) (eyebrowse-switch-to-window-config 4)
       (if (in-mode? 'term-mode)
           (split-window-below)
         (delete-other-windows))
       (let ((default-directory dir))
         ad-do-it)))

(defadvice find-file (around eyebrowse-window-1 (filename &optional wildcards) activate)
  (let ((dir default-directory))
    (eyebrowse-switch-to-window-config 1)
    (let ((default-directory dir))
      ad-do-it)))

(eyebrowse-mode)

;; git gutter
;; (ensure-package 'git-gutter+)
;; (require 'git-gutter+)
;; (define-key git-gutter+-mode-map (kbd "C-x g =") 'git-gutter+-show-hunk)
;; (define-key git-gutter+-mode-map (kbd "C-x g s") 'git-gutter+-stage-hunks)
;; (define-key git-gutter+-mode-map (kbd "C-x g r") 'git-gutter+-revert-hunks)
;; (define-key evil-normal-state-map (kbd "]d") 'git-gutter+-next-hunk)
;; (define-key evil-normal-state-map (kbd "[d") 'git-gutter+-previous-hunk)
;; (global-git-gutter+-mode)

;; rx
;; http://www.lunaryorn.com/2014/03/26/search-based-fontification-with-keywords.html
(with-eval-after-load 're-builder
  (setq reb-re-syntax 'rx))

;; org-reveal
(ensure-package 'ox-reveal)
(require 'ox-reveal)
(setq org-reveal-theme "solarized")

(provide 'maio-experiments)
