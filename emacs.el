(setq custom-file "~/.emacs.custom.el")
(load custom-file)

;;; ---------------------------------------------------------------------------
;;; Package archives / use-package bootstrap
;;; ---------------------------------------------------------------------------
(require 'package)
(dolist (archive '(("melpa"  . "https://melpa.org/packages/")
                   ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (add-to-list 'package-archives archive t))
(unless (bound-and-true-p package--initialized)
  (package-initialize))

;; use-package ships with Emacs 29+, but install it just in case.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(defun my/setup-packages ()
  "Install and configure my preferred set of packages.

Sets up dev tooling (magit, company, which-key, projectile),
UI niceties (doom-modeline, rainbow-delimiters, evil-collection,
nerd-icons) and LSP/language support (eglot, tree-sitter, flycheck).
Run interactively with \\[my/setup-packages] to (re)install everything."
  (interactive)
  ;; Only hit the network for the archive list if we've never done it.
  (unless package-archive-contents
    (package-refresh-contents))

  ;; --- Dev tooling -------------------------------------------------------
  (use-package which-key
    :config
    (which-key-mode 1))

  (use-package magit
    :bind (("C-x g" . magit-status)
           ("C-x M-g" . magit-dispatch)))

  (use-package projectile
    :init
    (projectile-mode 1)
    :bind-keymap
    ("C-c p" . projectile-command-map))

  (use-package company
    :hook (after-init . global-company-mode)
    :config
    (setq company-idle-delay 0.1
          company-minimum-prefix-length 1))

  ;; --- Editing / UI ------------------------------------------------------
  ;; nerd-icons needs fonts on the system: M-x nerd-icons-install-fonts
  (use-package nerd-icons)

  (use-package doom-modeline
    :init
    (doom-modeline-mode 1))

  (use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))

  ;; evil is already loaded below via (require 'evil); wire evil bindings
  ;; into the rest of Emacs (magit, dired, elfeed, etc.).
  (use-package evil-collection
    :after evil
    :config
    (evil-collection-init))

  ;; --- LSP / languages ---------------------------------------------------
  ;; Automatically install & use tree-sitter grammars where available.
  (use-package treesit-auto
    :custom
    (treesit-auto-install 'prompt)
    :config
    (global-treesit-auto-mode))

  ;; Nim language support (nim-mode auto-registers .nim/.nims/.nimble files).
  (use-package nim-mode
    :mode ("\\.nim\\(s\\|ble\\)?\\'" . nim-mode))

  ;; eglot is built into Emacs 29+, so don't try to pull it from an archive.
  (use-package eglot
    :ensure nil
    :hook ((c-mode c-ts-mode
            c++-mode c++-ts-mode
            python-mode python-ts-mode
            rust-ts-mode
            js-mode js-ts-mode
            nim-mode) . eglot-ensure)
    :config
    ;; eglot doesn't ship a Nim entry; use nimlangserver (or nimlsp).
    (add-to-list 'eglot-server-programs
                 '(nim-mode . ("nimlangserver")))
    :bind (:map eglot-mode-map
                ("C-c l r" . eglot-rename)
                ("C-c l a" . eglot-code-actions)
                ("C-c l f" . eglot-format)))

  (use-package flycheck
    :init
    (global-flycheck-mode))

  ;; Make eglot report diagnostics through flycheck instead of flymake.
  (use-package flycheck-eglot
    :after (flycheck eglot)
    :config
    (global-flycheck-eglot-mode 1)))

(use-package tokyonight-themes
  :vc (:url "https://github.com/xuchengpeng/tokyonight-themes")
  :config
  (load-theme 'tokyonight-night :no-confirm))

; (use-package simpc-mode
;  :vc (:url "https://github.com/rexim/simpc-mode")
;  :config
;  (add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

;; evil-collection requires this to be nil BEFORE evil is loaded.
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)

;; Install & configure the package set defined above.
(my/setup-packages)

;; (require 'cboomer-mode)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)

;; Font: JetBrains Mono Nerd Font (install the "JetBrainsMono Nerd Font"
;; package from https://www.nerdfonts.com/ if it isn't already present).
(let ((font "JetBrainsMono Nerd Font-12"))
  (when (member "JetBrainsMono Nerd Font" (font-family-list))
    (add-to-list 'default-frame-alist (cons 'font font))
    (set-frame-font font t t)))

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(ido-mode 1)
(ido-everywhere 1)

;; elfeed (rss feed)
(keymap-global-set "C-x w" #'elfeed)
(setq elfeed-feeds
      '("https://davidbalishyan.github.io/blog/feed.xml"
        "https://feeds.bbci.co.uk/news/rss.xml"
    "https://feeds.bbci.co.uk/news/technology/rss.xml"
    "https://news.ycombinator.com/rss"
    "https://github.blog/feed/"
    "https://www.phoronix.com/rss.php"
    "https://itsfoss.com/rss/"
    "https://nullprogram.com/feed/"
    "https://www.masteringemacs.org/feed"
    ))

;; Slime ide bs
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

