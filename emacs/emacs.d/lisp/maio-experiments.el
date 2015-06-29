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
  (setq org-reveal-theme "solarized"))

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
      (delete-file lock)
      (message "REMOVED %s" (f-filename lock))))

  (define-derived-mode fake-word-mode text-mode "FakeWord"
    (make-local-variable 'kill-buffer-hook)
    (add-hook 'kill-buffer-hook 'remove-fake-word-lock)
    (create-fake-word-lock)))

(add-to-list 'auto-mode-alist '("\\.docx$" . fake-word-mode))

;; hydra
(ensure-package 'hydra)

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

(defhydra hydra-windows (:hint nil)
  "
split _v_ert  _s_:horz | _c_lose  _o_nly | buffer _p_revious  _n_ext  _b_:select | _u_ndo  _r_edo | resize _H__J__K__L_ | _w_:save _r_:jump"
  ("u" winner-undo)
  ("r" winner-redo)

  ("s-h" windmove-left)
  ("s-j" windmove-down)
  ("s-k" windmove-up)
  ("s-l" windmove-right)

  ("p" previous-buffer)
  ("n" next-buffer)
  ("b" ido-switch-buffer)

  ("s" split-window-below)
  ("v" split-window-right)

  ("c" delete-window)
  ("o" delete-other-windows)

  ("H" hydra-move-splitter-left)
  ("J" hydra-move-splitter-down)
  ("K" hydra-move-splitter-up)
  ("L" hydra-move-splitter-right)

  ("w" window-configuration-to-register :color blue)
  ("r" jump-to-register :color blue)

  ("RET" nil)
  ("q" nil))

(global-set-key (kbd "s-h") 'hydra-windows/windmove-left)
(global-set-key (kbd "s-j") 'hydra-windows/windmove-down)
(global-set-key (kbd "s-k") 'hydra-windows/windmove-up)
(global-set-key (kbd "s-l") 'hydra-windows/windmove-right)

(provide 'maio-experiments)
