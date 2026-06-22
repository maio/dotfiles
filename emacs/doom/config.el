;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;
(setq confirm-kill-emacs nil)

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marian Schubert"
      user-mail-address "marian.schubert@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; (after! evil-snipe
;;  (evil-snipe-mode -1))

(setq evil-move-cursor-back nil)

;; (add-hook 'text-mode-hook 'abbrev-mode)

;; TAB in GUI
(define-key evil-motion-state-map (kbd "<tab>") "%")
(define-key evil-visual-state-map (kbd "<tab>") "%")
;; TAB in terminal
(define-key evil-motion-state-map (kbd "TAB") "%")
(define-key evil-visual-state-map (kbd "TAB") "%")

(fullframe magit-status magit-mode-quit-window nil)
(fullframe magit-show-commit magit-mode-bury-buffer nil)

(setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?u ?i ?o ?w ?r ?e ?\;))
(setq avy-style 'at-full)
(setq avy-background nil)

;; (define-key evil-normal-state-map "s" 'avy-goto-char)

;; (super-save-mode +1)

;; (map! :leader "a p" 'prodigy)
(map! :g "<f12>" '+term/toggle)

;; IDEA compatible stuff
(map! :i "M-<backspace>" 'undo-only)
(map! :n "M-<backspace>" 'undo-only)
;; (map! :i "M-<backspace>" 'undo-tree-undo)
;; (map! :n "M-<backspace>" 'undo-tree-undo)
(map! :g "C-e" '+vertico/switch-workspace-buffer)
(map! :n "C-e" '+vertico/switch-workspace-buffer)
(map! :i "M-e" 'er/expand-region)
(map! :n "M-e" 'er/expand-region)
;; (map! :i "C-v" 'clipboard-yank)
;; (map! :n "C-v" 'clipboard-yank)
;; (map! :leader "w /" 'evil-window-vsplit)
;; (map! :leader "r R" 'projectile-run-project)
;; (map! :leader "r r" 'projectile-repeat-last-command)

(after! magit
  (defadvice magit-section-toggle (after do-recenter () activate) (recenter 3)))

(let ((local-settings "~/.local.el"))
  (when (file-exists-p local-settings)
    (message "Loading local settings...")
    (load-file local-settings)))
