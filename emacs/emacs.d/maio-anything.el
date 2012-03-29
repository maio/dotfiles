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

(global-set-key (kbd "C-, t") 'anything-project)
(global-set-key (kbd "C-, b") 'anything-for-files)

(provide 'maio-anything)
