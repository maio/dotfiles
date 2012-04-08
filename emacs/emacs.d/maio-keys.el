(setq maio/leader-action-alist
      '((?w . force-save-buffer)
        (?, . evil-buffer)
        (?b . helm-mini)
        (?k . kill-current-buffer)
        (?t . helm-c-etags-select)
        (?f . helm-projectile)
        (?v . edit-init)
        (?e . my-eval-defun)
        (?a . ack-and-a-half)
        (?1 . delete-other-windows)
        (?g . magit-status)))

(defun maio/leader-enabled-key? (key)
  (assoc key maio/leader-action-alist))

(defun maio/perform-leader-action-for-key (key)
  (command-execute (cdr (assoc key maio/leader-action-alist))))

(defun maio/should-insert-leader? ()
  (cond ((eq evil-state 'normal) nil)
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

(define-key evil-motion-state-map "," nil)
(global-set-key "," 'maio/maybe-leader)

(provide 'maio-keys)
