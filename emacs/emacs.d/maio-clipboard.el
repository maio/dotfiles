(when (system-type-is-gnu)
  (add-to-list 'load-path "~/.emacs.d/nclip")
  (require 'nclip))

(when (system-type-is-darwin)
  (require 'pbcopy)
  (turn-on-pbcopy))

(provide 'maio-clipboard)
