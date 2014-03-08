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

;; read env from shell
(setenv "PATH" (s-trim (shell-command-to-string "bash -l -c 'echo $PATH'")))
(setq exec-path (s-split ":" (getenv "PATH")))
(setenv "ERL_LIBS" (s-trim (shell-command-to-string "bash -l -c 'echo $ERL_LIBS'")))
(setenv "PERL5LIB" (s-trim (shell-command-to-string "bash -l -c 'echo $PERL5LIB'")))

;; org-capture
(eval-after-load 'org
  '(progn
     (setq org-default-notes-file (concat org-directory "/notes.org"))))

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
(add-hook 'emacs-lisp-mode-hook 'paren-face-add-keyword)

;; golden-ration
(ensure-package 'golden-ratio)
(require 'golden-ratio)
(golden-ratio-mode 1)
(diminish 'golden-ratio-mode nil)

(provide 'maio-experiments)
