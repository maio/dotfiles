(defun maio/leader-enabled-key? (key)
  (assoc key maio/leader-action-alist))

(defun maio/perform-leader-action-for-key (key)
  (command-execute (cdr (assoc key maio/leader-action-alist))))

(defun maio/should-insert-leader? ()
  (cond ((in-mode? 'Custom-mode) nil)
        ((eq evil-state 'normal) nil)
        (buffer-read-only nil)
        (t t)))

(defun maio/maybe-leader ()
  (interactive)
  (let ((modified (buffer-modified-p))
        (leader-key ?,))
    (when (maio/should-insert-leader?) (insert leader-key))
    (let ((evt (read-event "Leader" nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (maio/leader-enabled-key? evt))
        (when (maio/should-insert-leader?)
          (delete-char -1)
          (set-buffer-modified-p modified))
        (maio/perform-leader-action-for-key evt))
       (t (push evt unread-command-events))))))

(define-key evil-emacs-state-map "," 'maio/maybe-leader)
(define-key evil-insert-state-map "," 'maio/maybe-leader)
(define-key evil-normal-state-map "," 'maio/maybe-leader)
(define-key evil-motion-state-map "," 'maio/maybe-leader)
(global-set-key "," 'maio/maybe-leader)

(provide 'maio-leader)
