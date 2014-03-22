(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'maio-util)

(require-and-exec 'package
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  (let ((my-packages '(evil)))
    (dolist (package my-packages)
      (ensure-package package))))

(evil-mode 1)
(require 'maio-erlang)
