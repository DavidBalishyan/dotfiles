(setq custom-file "~/.emacs.custom.el")
(load custom-file)

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(require 'evil)
(evil-mode 1)
