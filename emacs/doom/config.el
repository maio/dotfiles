;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marian Schubert"
      user-mail-address "marian.schubert@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 18))
(setq-default line-spacing 0.3)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;(setq doom-theme 'doom-dracula)
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; this determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;

(after! evil-snipe
  (evil-snipe-mode -1))

(setq projectile-project-search-path '("~/Projects/"))

(add-hook 'text-mode-hook 'abbrev-mode)

(defun open-in-idea ()
  (interactive)
  (let ((cmd (format "curl --silent --referer https://emacs.org/ 'http://localhost:63342/api/file/%s:%d:%d'" buffer-file-name (line-number-at-pos) (+ 1 (current-column) ))))
    (shell-command cmd)))

(global-set-key (kbd "s-e") #'open-in-idea)

;; TAB in GUI
(define-key evil-motion-state-map (kbd "<tab>") "%")
(define-key evil-visual-state-map (kbd "<tab>") "%")
;; TAB in terminal
(define-key evil-motion-state-map (kbd "TAB") "%")
(define-key evil-visual-state-map (kbd "TAB") "%")

(fullframe magit-status magit-mode-quit-window nil)
(fullframe magit-show-commit magit-mode-bury-buffer nil)

(define-key evil-normal-state-map (kbd "M-g") 'evil-multiedit-match-symbol-and-next)

(setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?u ?i ?o ?w ?r ?e ?\;))
(setq avy-style 'at-full)
(setq avy-background nil)

(define-key evil-normal-state-map "s" 'avy-goto-char)

(add-hook 'focus-out-hook 'save-buffer)

(defun maybe-magit-refresh ()
  (interactive)
  (when (eq major-mode 'magit-status-mode)
    (magit-refresh)))

(add-hook 'focus-in-hook 'maybe-magit-refresh)
