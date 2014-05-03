;;; -*- lexical-binding: t -*-

(defmacro clj-comment (&rest body)
  "Ignores body, yields nil."
  nil)

(defun clj-identity (x)
  "Returns its argument."
  x)

(defmacro clj-for (bindings body)
  "List comprehension."
  (let ((bindings (clj-partition 2 (mapcar #'identity bindings))))
    (--reduce-from  `(loop for ,(car it) in ,(car (cdr it))
                           append ,acc) `(list ,body) (reverse bindings))))

(put 'clj-for 'lisp-indent-function 2)

(defun clj-range (start &optional end step)
  (unless end (setq end start start 0))
  (number-sequence start (1- end) step))


;; TESTS ----------------------------------------------------------------------

(ert-deftest clj-comment ()
  (should (equal (clj-comment pretty much anything) nil)))

(ert-deftest clj-identity-test ()
  (let ((some-value 'any-value))
    (should
     (equal (clj-identity some-value) some-value))))

(ert-deftest clj-for ()
  (should
   (equal (clj-for [x '(6)]
            x)
          '(6))))

(ert-deftest clj-for ()
  (should
   (equal (clj-for [x '(1 2)
                    y '(3 4)]
              (list x y))
          '((1 3) (1 4) (2 3) (2 4)))))

(ert-deftest clj-range ()
  (should
   (equal (clj-range 3) '(0 1 2))))

(provide 'clj-lib)
