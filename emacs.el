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

