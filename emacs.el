(setq custom-file "~/.emacs.custom.el")
(load custom-file)

(menu-bar-mode 1)
(tool-bar-mode 1)
(scroll-bar-mode 1)
(show-paren-mode 1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(require 'evil)
(evil-mode 1)
