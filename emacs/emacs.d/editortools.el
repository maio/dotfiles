;;; editortools.el --- make use of App::EditorTools Perl module
;; App::EditorTools::Command::InstallEmacs generated script
;; Version: 0.16
;; Copyright (C) 2010 Pat Regan <thehead@patshead.com>

;; Keywords: faces
;; Author: Pat Regan <thehead@patshead.com>
;; URL: http://rcs,patshead.com/dists/editortools-vim-el

;; This file is not part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2, or (at your option) any later
;; version.
;;
;; This is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;;; Commentary:

;; Requires App::EditorTools Perl module

(defun editortools-renamevariable (varname)
  "Call rename variable on buffer"
  (interactive "sNew Variable Name: ")
  (let* (
         (p (point))
         (col (+ 1 (current-column))) ; vim numbers columns differently
         (line (line-number-at-pos))
         )
    (shell-command-on-region (point-min) (point-max)
                             (format "editortools renamevariable -l %d -c %d -r %s" line col varname) t nil nil)
    (goto-char p)
    )
  )

(defun editortools-introducetemporaryvariable (varname)
  "Call introducetempoararyvariable on region"
  (interactive "sNew Variable Name: ")
  (let* (
         (p (point))
         (startline (line-number-at-pos (region-beginning)))
         (startcol (editortools-get-column (region-beginning)))
         (endline (line-number-at-pos (region-end)))
         (endcol (editortools-get-column (region-beginning)))
         )
    (shell-command-on-region (point-min) (point-max)
                             (format "editortools introducetemporaryvariable -s %d,%d -e %d,%d -v %s" startline startcol endline endcol varname) t nil nil)
    (goto-char p)
    )
  )

(defun editortools-renamepackagefrompath ()
  "Call renamepackagefrompath"
  (interactive)
  (let* (
         (p (point))
         )
    (shell-command-on-region (point-min) (point-max)
                             (format "editortools renamepackagefrompath -f %s" (buffer-file-name)) t nil nil)
    (goto-char p)
    )
  )

(defun editortools-renamepackage ()
  "Call renamepackage"
  (interactive)
  (let* (
         (p (point))
         )
    (shell-command-on-region (point-min) (point-max)
                             (format "editortools renamepackage -n %s" (buffer-file-name)) t nil nil)
    (goto-char p)
    )
  )

(defun editortools-get-column (p)
  "Get the column of a point"
  (save-excursion
    (goto-char p)
    (+ 1 (current-column)) ; vim counts columns differently
    )
  )

(define-key cperl-mode-map (kbd "C-c e r") 'editortools-renamevariable)
(define-key cperl-mode-map (kbd "C-c e t") 'editortools-introducetemporaryvariable)

(provide 'editortools)
