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

;; golden-ration
(ensure-package 'golden-ratio)
(setq golden-ratio-exclude-modes '("magit-key-mode"))
(with-eval-after-load 'golden-ratio (diminish 'golden-ratio-mode))
(global-set-key (kbd "s-g") 'golden-ratio)

;; org-reveal
(with-eval-after-load 'org
  (ensure-package 'ox-reveal)
  (require 'ox-reveal)
  (setq org-reveal-theme "sky"
        org-reveal-title-slide-template "<h1>%t</h1><h2>%a</h2><h3>%e</h3>"))

(ensure-package 'dired-open)
(with-eval-after-load 'dired
  (require 'dired-open)
  (setq dired-open-extensions '(("qt" . "qtshow")
                                ("qt.opt" . "qtshow")
                                ("svg" . "open"))))

;; move to new window
(defadvice split-window-right (after switch-to-it () activate) (other-window 1))
(defadvice split-window-below (after switch-to-it () activate) (other-window 1))

;; coffee
(ensure-package 'coffee-mode)
(setq coffee-tab-width 2)

;; smart-tab
(ensure-package 'smart-tab)
(global-smart-tab-mode 1)
(setq smart-tab-using-hippie-expand t)

;; expand-region
(ensure-package 'expand-region)
(when evil-mode
  (define-key evil-visual-state-map "." 'er/expand-region))

;; word/excel emulation modes
(progn
  (defun get-fake-world-lock-file (fname)
    (let* ((ext (format ".%s" (f-ext fname)))
           (fname-sans-ext (s-chop-suffix ext fname))
           (len (length fname-sans-ext))
           (drop-chars (cond
                        ((> len 7) 2)
                        ((= len 7) 1)
                        (t 0))))
      (message "%d" len)
      (f-join
       (f-dirname fname)
       (format "~$%s" (substring (f-filename fname) drop-chars)))))

  (defun create-fake-word-lock ()
    (let ((lock (get-fake-world-lock-file (buffer-file-name))))
      ;; sleep would be more realistic?
      (write-region "" nil lock)
      (message "CREATED %s" (f-filename lock))))

  (defun remove-fake-word-lock ()
    (let ((lock (get-fake-world-lock-file (buffer-file-name))))
      (when (f-exists? lock)
        (delete-file lock)
        (message "REMOVED %s" (f-filename lock)))))

  (define-derived-mode fake-word-mode text-mode "FakeWord"
    (make-local-variable 'kill-buffer-hook)
    (add-hook 'kill-buffer-hook 'remove-fake-word-lock)
    (create-fake-word-lock)))

(add-to-list 'auto-mode-alist '("\\.docx$" . fake-word-mode))

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

(defhydra hydra-highlight ()
  "Highlight"
  ("." maio/highlight-symbol-at-point "highlight-symbol-at-point" :color blue)
  ("r" unhighlight-regexp "unhighlight-regexp"))

(defhydra hydra-utils ()
  "Utils"
  ("w" hydra-highlight/body "highlight (C-x w)" :color blue))

(global-set-key (kbd "s-u") 'hydra-utils/body)

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
(require 'hydra-examples)
(defhydra hydra-windows (:hint nil)
  "
_0_:close  _1_:only | _b_:select buffer | _<_:undo  _>_:redo | resize _H__J__K__L_ _=_:balance | _m_:save _'_:jump"
  ("<" winner-undo)
  (">" winner-redo)

  ("s-h" windmove-left)
  ("s-j" windmove-down-or-create)
  ("s-k" windmove-up)
  ("s-l" windmove-right-or-create)

  ("b" ido-switch-buffer)

  ("0" delete-window)
  ("1" delete-other-windows)

  ("H" hydra-move-splitter-left)
  ("J" hydra-move-splitter-down)
  ("K" hydra-move-splitter-up)
  ("L" hydra-move-splitter-right)

  ("=" balance-windows)

  ("m" window-configuration-to-register :color blue)
  ("'" jump-to-register :color blue)

  ("RET" nil))

(global-set-key (kbd "s-h") 'hydra-windows/windmove-left)
(global-set-key (kbd "s-j") 'hydra-windows/windmove-down-or-create)
(global-set-key (kbd "s-k") 'hydra-windows/windmove-up)
(global-set-key (kbd "s-l") 'hydra-windows/windmove-right-or-create)
(global-set-key (kbd "s-b") 'hydra-windows/ido-switch-buffer)

(defhydra hydra-yank-pop ()
  "yank"
  ("C-y" yank nil)
  ("M-y" yank-pop nil)
  ("n" (yank-pop 1) "next")
  ("p" (yank-pop -1) "prev")
  ("s" helm-show-kill-ring "list" :color blue))

(global-set-key (kbd "M-y") #'hydra-yank-pop/yank-pop)
(global-set-key (kbd "C-y") #'hydra-yank-pop/yank)
(global-set-key (kbd "s-v") #'hydra-yank-pop/yank)

(defhydra hydra-smartparens ()
  "smartparens"
  ("(" sp-forward-barf-sexp "barf last")
  (")" sp-forward-slurp-sexp "slurp")
  ("s" sp-split-sexp "split")
  ("t" sp-transpose-sexp "transponse")
  ("M-J" sp-join-sexp "join")
  ("J" evil-join)
  ("c" sp-convolute-sexp "convolute")
  ("u" undo-tree-undo "undo")
  ("M-k" sp-kill-sexp "kill")
  ("M-SPC" just-one-space)
  ("h" sp-backward-up-sexp)
  ("j" sp-next-sexp)
  ("k" sp-backward-sexp)
  ("l" sp-down-sexp))

    ;; (evil-define-key 'normal clojure-mode-map "l" 'sp-down-sexp)
    ;; (evil-define-key 'normal clojure-mode-map "h" 'sp-backward-up-sexp)
    ;; (evil-define-key 'normal clojure-mode-map "j" 'sp-next-sexp)
    ;; (evil-define-key 'normal clojure-mode-map "k" 'sp-backward-sexp)
(global-set-key (kbd "s-9") #'hydra-smartparens/body)

(ensure-package 'avy)
(setq avy-all-windows nil
      avy-keys '(?q ?w ?e ?r ?t ?y ?u ?i ?o ?p
                    ?a ?s ?d ?f ?g ?h ?j ?k ?l
                    ?z ?x ?c ?v ?b ?n ?m))
(define-key evil-normal-state-map (kbd "SPC") 'avy-goto-word-or-subword-1)

(require 'whitespace)
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

(provide 'maio-experiments)
