;;; dizzee-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (dz-subp-stop dz-comint-pop dz-pop dz-dir-excursion
;;;;;;  dz-alist-filter dz-regexp-filter dz-akeys dz-split dz-symb-concat
;;;;;;  dz-xp) "dizzee" "dizzee.el" (20895 13553 0 0))
;;; Generated autoloads from dizzee.el

(autoload 'dz-xp "dizzee" "\
Wrap the results of `expr', evaluating to t or nil when creating predicate-p functions

\(fn EXPR)" nil nil)

(autoload 'dz-symb-concat "dizzee" "\
Return the symbol created by concatenating `symb' with `suffix'

\(fn SYMB SUFFIX)" nil nil)

(autoload 'dz-split "dizzee" "\
Split list into a list of lists

\(fn LST)" nil nil)

(autoload 'dz-akeys "dizzee" "\
Return a list of the keys in `alist'

\(fn ALIST)" nil nil)

(autoload 'dz-regexp-filter "dizzee" "\
Filter LIST of strings with `regexp'.

\(fn LIST REGEXP)" nil nil)

(autoload 'dz-alist-filter "dizzee" "\
Return values from `alist' whose KEY matches `regexp'

\(fn ALIST REGEXP)" nil nil)

(autoload 'dz-dir-excursion "dizzee" "\
Perform BODY having moved to DIR before returning to the current directory

\(fn DIR BODY)" nil t)

(autoload 'dz-pop "dizzee" "\
Wraps pop-to and get buffer for `buffer'

\(fn BUFFER)" nil nil)

(autoload 'dz-comint-pop "dizzee" "\
Make a comint buffer for process `name', executing `command' with
`args' and then pop to that buffer.

\(fn NAME COMMAND &optional ARGS DONT-POP)" nil nil)

(autoload 'dz-subp-stop "dizzee" "\
Check to see if the process `name' is running stop it if so.

\(fn NAME)" nil nil)

;;;***

;;;### (autoloads nil nil ("dizzee-pkg.el") (20895 13553 301838 631000))

;;;***

(provide 'dizzee-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; dizzee-autoloads.el ends here
