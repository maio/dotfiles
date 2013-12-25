(require 'xclip)
(turn-on-xclip)

;; make xclip work when in tramp buffer
(defadvice xclip-set-selection (around tramp-fix () activate)
  (let ((default-directory "/")) ad-do-it))
(defadvice xclip-selection-value (around tramp-fix () activate)
  (let ((default-directory "/")) ad-do-it))

(provide 'maio-clipboard)
