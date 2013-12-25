(require 'cl-lib)

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

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

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
  (kill-current-buffer))

(defun my-eval-defun ()
  (interactive)
  (if (in-mode? 'clojure-mode)
      (cider-eval-expression-at-point)
    (eval-defun nil))
  (evil-normal-state))

(defun clear-comint-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(defun force-save-buffer ()
  (interactive)
  (cond
   ((in-mode? 'magit-log-edit-mode) (magit-log-edit-commit))
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

(defun other-buffer-or-window ()
  (interactive)
  (if (window-parent)
      (command-execute 'other-window)
    (command-execute 'evil-buffer)))

(defun maio/find-config-file ()
  (interactive)
  (with-helm-default-directory "~/.emacs.d/lisp/"
      (call-interactively 'helm-find-files)))

(defun maio/current-project-dir ()
  (locate-dominating-file default-directory ".git"))

(defun maio/goto-grep-buffer ()
  (interactive)
  (switch-to-buffer-other-window
   (first (let ((regexp "\*grep"))
            (remove-if-not (lambda (buf) (string-match regexp (buffer-name buf)))
                           (buffer-list))))))
(defun maio/find-project ()
  (interactive)
  (with-helm-default-directory "~/Projects/"
      (call-interactively 'helm-find-files)))

(defun maio/copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

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

(defun maio/goto-compilation-buffer ()
  (interactive)
  (switch-to-buffer-other-window compilation-last-buffer))

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

(provide 'maio-util)
