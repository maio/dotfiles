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
(ensure-package 'exec-path-from-shell)
(require 'exec-path-from-shell)
(add-to-list 'exec-path-from-shell-variables "ERL_LIBS")
(add-to-list 'exec-path-from-shell-variables "PERL5LIB")
(exec-path-from-shell-initialize)

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
(add-hook 'perl-mode-hook 'paren-face-add-keyword)
(add-hook 'erlang-mode-hook 'paren-face-add-keyword)
(add-hook 'json-mode-hook 'paren-face-add-keyword)
(add-hook 'js2-mode-hook 'paren-face-add-keyword)
(add-hook 'emacs-lisp-mode-hook 'paren-face-add-keyword)
(add-hook 'python-mode-hook 'paren-face-add-keyword)

;; golden-ration
(ensure-package 'golden-ratio)
(setq golden-ratio-exclude-modes '("magit-key-mode"))
(with-eval-after-load 'golden-ratio (diminish 'golden-ratio-mode))
(global-set-key (kbd "s-g") 'golden-ratio)

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
  (setq reb-re-syntax 'rx)

  ;; use flycheck-rx-to-string instead of rx-to-string
  (defun reb-cook-regexp (re)
  "Return RE after processing it according to `reb-re-syntax'."
  (cond ((memq reb-re-syntax '(sregex rx))
	 (flycheck-rx-to-string (eval (car (read-from-string re)))))
	(t re))))

;; org-reveal
(with-eval-after-load 'org
  (ensure-package 'ox-reveal)
  (require 'ox-reveal)
  (setq org-reveal-theme "solarized"))

(ensure-package 'dired-open)
(with-eval-after-load 'dired
  (require 'dired-open)
  (setq dired-open-extensions '(("qt" . "qtshow")
                                ("qt.opt" . "qtshow")
                                ("svg" . "open"))))

;; popwin
(ensure-package 'popwin)
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(push '("^\*helm .+\*$" :regexp t) popwin:special-display-config)
(push '("^\*helm-.+\*$" :regexp t) popwin:special-display-config)

;; helm-cmd-t
(ensure-package 'helm-cmd-t)
(global-set-key (kbd "s-t") 'helm-cmd-t)

;; move to new window
(defadvice split-window-right (after switch-to-it () activate) (other-window 1))
(defadvice split-window-below (after switch-to-it () activate) (other-window 1))

(provide 'maio-experiments)
