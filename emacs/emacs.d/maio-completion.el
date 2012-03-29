(require 'anything-project)
(ap:add-project
 :name 'default
 :look-for '(".git"))

(require 'anything-match-plugin)
(setq anything-for-files-prefered-list
  '(anything-c-source-ffap-line
    anything-c-source-ffap-guesser
    anything-c-source-buffers+
    anything-c-source-recentf
    anything-c-source-bookmarks
    anything-c-source-file-cache
    anything-c-source-files-in-current-dir+))

(require-and-exec 'recentf
  (setq recentf-max-saved-items 100)
  (add-to-list 'recentf-exclude "emacs.d"))

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(setq ac-ignore-case nil)
(setq ac-delay 0.1)
(setq ac-auto-show-menu nil)
(setq ac-quick-help-delay 0.5)
(require-and-exec 'auto-complete-config)
(define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map "\C-n" 'ac-next)
(define-key ac-completing-map "\C-p" 'ac-previous)
(defun ac-common-setup ()
  (add-to-list 'ac-sources 'ac-source-words-in-all-buffer)
  (add-to-list 'ac-sources 'ac-source-yasnippet))
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-modes 'eshell-mode)

(provide 'maio-completion)
