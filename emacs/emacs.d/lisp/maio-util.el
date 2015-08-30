(require 'cl-lib)

(defun ensure-package (package)
  (when (not (package-installed-p package))
    (package-install package)))

(defmacro require-and-exec (feature &optional &rest body)
  "Require the feature and execute body if it was successfull loaded."
  (declare (indent 1))
  `(if (require ,feature nil 'noerror)
        (progn ,@body)
    (message (format "%s not loaded" ,feature))))

(defun in-mode? (mode)
  (eq major-mode mode))

(defun toggle-comment-on-line-or-region ()
  "Comments or uncomments current current line or whole lines in region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position)
                                 (line-end-position))))

(defun kill-this-buffer-and-window ()
  (interactive)
  (call-interactively 'kill-this-buffer)
  (call-interactively 'delete-window))

(defun kill-all-buffers ()
  (interactive)
    (mapc 'kill-buffer (buffer-list)))

(defun kill-buffer-if-not-current (buffer)
  (when (not (eq (current-buffer) buffer))
    (kill-buffer buffer)))

(defun kill-other-buffers ()
  (interactive)
  (mapc 'kill-buffer-if-not-current (buffer-list)))

(defun kill-comint-buffer ()
  (interactive)
  (when (get-buffer-process (current-buffer))
    (comint-interrupt-subjob)
    (while (get-buffer-process (current-buffer)) (sleep-for 0 100)))
  (call-interactively 'kill-this-buffer))

(defun clear-comint-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun maio-maybe-clear-window-buffer (win)
  (save-window-excursion
    (select-window win)
    (when (in-mode? 'cider-repl-mode) (cider-repl-clear-buffer))
    (when (compilation-buffer-p (current-buffer)) (clear-comint-buffer))))

(defun maio-clear-visible-comint-buffers ()
  (interactive)
  (walk-windows 'maio-maybe-clear-window-buffer))

(defun force-save-buffer ()
  (interactive)
  (cond
   ((in-mode? 'magit-log-edit-mode) (magit-log-edit-commit))
   ((s-starts-with? "*notes*" (buffer-name (current-buffer))) (call-interactively 'save-buffer))
   ((s-starts-with? "*" (buffer-name (current-buffer))) (call-interactively 'rename-buffer))
   (t (progn
        (set-buffer-modified-p t)
        (command-execute 'save-buffer)))))

(defun set-font-size (size)
  (set-face-attribute 'default nil :height size))

(defun maio/bury ()
  (interactive)
  (bury-buffer)
  (when (window-parent) (delete-window)))

(defun previous-other-window ()
  (interactive)
  (other-window -1))

(defun other-buffer-or-window ()
  (interactive)
  (if (window-parent)
      (command-execute 'other-window)
    (command-execute 'evil-buffer)))

(defun maio/find-config-file ()
  (interactive)
  (helm-find-files-1 (expand-file-name "~/.emacs.d/lisp/")))

(defun maio/current-project-dir ()
  (locate-dominating-file default-directory ".git"))

(defun maio/goto-grep-buffer ()
  (interactive)
  (switch-to-buffer-other-window
   (first (let ((regexp "\*grep"))
            (remove-if-not (lambda (buf) (string-match regexp (buffer-name buf)))
                           (buffer-list))))))

(defun maio/copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun ui-type-is-gui ()
  (interactive)
  "Return true if running GUI version of Emacs"
  (display-graphic-p))

(defun ui-type-is-terminal ()
  (interactive)
  "Return true if running in Terminal"
  (not (display-graphic-p)))

(defun system-type-is-gnu ()
  (interactive)
  "Return true if system is GNU/Linux-based"
  (string-equal system-type "gnu/linux"))

(defun system-type-is-darwin ()
  (interactive)
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin"))

(defun maio/goto-scratch-buffer ()
  (interactive)
  (switch-to-buffer "*scratch*"))

(defun maio/looking-at-bol? ()
  (save-excursion (backward-word) (eq (point) (line-beginning-position))))

(defun maio/looking-at-empty-line? ()
  (save-excursion (move-end-of-line 1) (eq (point) (yas--real-line-beginning))))

(defun maio/looking-at-first-word-on-the-line? ()
  (save-excursion (backward-word) (eq (point) (yas--real-line-beginning))))

(defun buffer-contains? (string)
  (save-excursion
    (save-match-data
      (goto-char (point-min))
      (search-forward string nil t))))

(defun maio/run-prog-mode-hook ()
  (run-hooks 'prog-mode-hook))

(defun maio/erlang-tab-to-tab-stop ()
  (interactive)
  (if (eq (point) (line-beginning-position))
      (indent-relative)
    (tab-to-tab-stop)))

(defun maio/setup-tab-indent ()
  (setq indent-tabs-mode t)
  (when (in-mode? 'erlang-mode)
    (setq indent-line-function 'maio/erlang-tab-to-tab-stop))
  (let ((my-tab-width 4))
    (setq tab-width my-tab-width)
    (set (make-local-variable 'tab-stop-list)
         (number-sequence my-tab-width 200 my-tab-width))))

(fset 'raise-exp "\C-vy\C-vvpgv\C-g")

(defun maio/reset ()
  (interactive)
  (kill-all-buffers)
  (delete-other-windows))

(defun get-ip-address (&optional dev)
  "get the IP-address for device DEV (default: en0)"
  (let ((dev (if dev dev "en0")))
    (format-network-address (car (network-interface-info dev)) t)))

(defun make-current-window-dedicated ()
  (interactive)
  (set-window-dedicated-p (get-buffer-window) t))

(defun single-window-p ()
  (= (length (window-list)) 1))

(defun maio/jump-brace (char)
  (interactive (list (read-char "char: " t)))
  (avy-goto-char-2 ?\( char))

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(provide 'maio-util)
