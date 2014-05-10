(require 'xxx)
(require 'ert)
(require 'ert-x)
(require 'f)

;; https://github.com/echosa/phpplus-mode/blob/master/test/ert/ert-x-tests.el
;; https://github.com/hemze/emacs/blob/940c52a8e0c8e75c1c994aee2f467339d8a66ece/mmm-mode-master/tests/region.el
;; https://github.com/elixir-lang/emacs-elixir/blob/master/test/elixir-mode-indentation-tests.el

(defvar xxx-mode-test-dir "/Users/maio/Projects/dotfiles/emacs/emacs.d/lisp/xxx/tests/"
  "Directory containing the test files.")

(makunbound 'xxx-test-files)

(defvar xxx-test-files (file-expand-wildcards (f-join xxx-mode-test-dir "*.xxx")))

(defun xxx-expect-indent (fname)
  (ert-with-test-buffer ()
    (insert-file-contents fname)
    (xxx-mode)
    (let ((expected (buffer-string))
          (actual (ert-buffer-string-reindented)))
      (when (not (equal actual expected))
        (delete-region (point-min) (point-max))
        (insert actual)
        (goto-char (point-min))
        (ert-fail "indentation doesn't match")))))

(defun xxx-gen-test (fname)
  (let ((test-name (intern (f-base fname))))
    (eval
     `(ert-deftest ,test-name ()
        (xxx-expect-indent ,fname)))))

(mapcar #'xxx-gen-test xxx-test-files)
