(require 'key-chord)
(setq key-chord-one-key-delay 0.3)
(setq key-chord-two-keys-delay 0.4)

;; custom key-chord-define
(defun key-chord-define (keymap keys command)
  (if (/= 2 (length keys))
      (error "Key-chord keys must have two elements"))
  ;; Exotic chars in a string are >255 but define-key wants 128..255 for those
  (let ((key1 (logand 255 (aref keys 0)))
        (key2 (logand 255 (aref keys 1))))
    (define-key keymap (vector 'key-chord key1 key2) command)))

(provide 'maio-key-chord)
