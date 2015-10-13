;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     git
     clojure
     markdown
     org
     prodigy
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '(fullframe hydra)
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(rainbow-delimiters
                                    highlight-parentheses
                                    golden-ratio)
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'hybrid
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         spacemacs-dark
                         solarized-light
                         solarized-dark
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 12
                               ;; :weight normal
                               :weight medium
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to miminimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar nil
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode t
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."
  )

(defun dotspacemacs/user-config ()
  (setq evil-move-cursor-back nil
        evil-want-C-i-jump t
        evil-repeat-move-cursor nil
        evil-regexp-search t
        evil-cross-lines t)

  (setq projectile-enable-caching t
        vc-follow-symlinks t
        spacemacs-theme-org-highlight nil
        magit-diff-refine-hunk t
        powerline-default-separator nil)

  (global-hl-line-mode -1)
  (spacemacs/toggle-automatic-symbol-highlight-on)

  ;; evil
  (define-key evil-normal-state-map "Y" 'evil-yank-line)
  (define-key evil-normal-state-map "S" "vabsba")
  (define-key evil-normal-state-map "/" 'helm-swoop)
  ;; evil like emacs
  (define-key evil-normal-state-map [tab] 'evil-jump-item)
  (define-key evil-emacs-state-map (kbd "C-a") 'evil-first-non-blank)
  (define-key evil-hybrid-state-map (kbd "C-a") 'evil-first-non-blank)
  (define-key evil-normal-state-map (kbd "C-a") 'evil-first-non-blank)
  (define-key evil-normal-state-map (kbd "C-e") 'move-end-of-line)
  ;; evil + org
  (evil-define-key 'normal org-mode-map [tab] 'org-cycle)

  ;; emacs lisp
  (define-key emacs-lisp-mode-map (kbd "M-q") 'sp-indent-defun)
  (define-key emacs-lisp-mode-map (kbd "M-k") 'sp-kill-sexp)
  (define-key emacs-lisp-mode-map (kbd "C-)") 'sp-forward-slurp-sexp)

  ;; clojure
  (with-eval-after-load 'clojure-mode
    (define-key clojure-mode-map (kbd "M-q") 'sp-indent-defun)
    (define-key clojure-mode-map (kbd "M-k") 'sp-kill-sexp)
    (define-key clojure-mode-map (kbd "C-)") 'sp-forward-slurp-sexp))

  ;; fullframe
  (require 'fullframe)
  (fullframe magit-status magit-mode-quit-window)
  (fullframe magit-log magit-mode-quit-window)

  ;; window movement
  (defun windmove-right-or-create ()
    (interactive)
    (condition-case err
        (call-interactively 'windmove-right)
      (error
       (call-interactively 'split-window-right)
       (other-window 1))))

  (defun windmove-down-or-create ()
    (interactive)
    (condition-case err
        (call-interactively 'windmove-down)
      (error
       (call-interactively 'split-window-below)
       (other-window 1))))

  (setq hydra-lv nil)
  (require 'hydra-examples)
  (defhydra hydra-windows (:hint nil)
    "
_0_:close  _1_:only | buffer _p_revious  _n_ext  _b_:select | _<_:undo  _>_:redo | resize _H__J__K__L_ _=_:balance | _m_:save _'_:jump"
    ("<" winner-undo)
    (">" winner-redo)

    ("s-h" windmove-left)
    ("s-j" windmove-down-or-create)
    ("s-k" windmove-up)
    ("s-l" windmove-right-or-create)

    ("p" previous-buffer)
    ("n" next-buffer)
    ("b" ido-switch-buffer)

    ("0" delete-window)
    ("1" delete-other-windows)

    ("H" hydra-move-splitter-left)
    ("J" hydra-move-splitter-down)
    ("K" hydra-move-splitter-up)
    ("L" hydra-move-splitter-right)

    ("=" balance-windows)

    ("m" window-configuration-to-register :color blue)
    ("'" jump-to-register :color blue)

    ("RET" nil))

  (global-set-key (kbd "s-h") 'hydra-windows/windmove-left)
  (global-set-key (kbd "s-j") 'hydra-windows/windmove-down-or-create)
  (global-set-key (kbd "s-k") 'hydra-windows/windmove-up)
  (global-set-key (kbd "s-l") 'hydra-windows/windmove-right-or-create)
  (global-set-key (kbd "s-b") 'hydra-windows/ido-switch-buffer)
  ;; local stuff
  (let ((local (expand-file-name "~/.local.el")))
    (when (f-exists? local)
      (load-file local)))

  ;; light theme modifications
  (let ((fg "#111111")
        (bg "#fffff8")
        (bg-light "#ddddd8")
        (fg-light "#ddddd8")
        (bg-highlight "#FFF1AA")
        (bg-highlight-2 "LightCyan"))
    (custom-theme-set-faces
     'spacemacs-light
     `(ahs-face ((t (:background ,bg-highlight))))
     `(ahs-definition-face ((t (:background ,bg-highlight-2))))
     `(ahs-plugin-bod-face ((t (:background ,bg-highlight-2))))
     `(ahs-plugin-whole-buffer-face ((t (:background ,bg-highlight))))
     `(font-lock-type-face ((t ())))
     `(font-lock-function-name-face ((t ())))
     `(font-lock-keyword-face ((t ())))
     `(org-block-begin-line ((t (:foreground ,fg-light))))
     `(org-block-end-line ((t (:foreground ,fg-light))))
     `(region ((t (:background "#eeeee8" :foreground ,fg))))
     ))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(paradox-github-token t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
