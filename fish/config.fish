if status is-interactive
	alias vim="nvim"
	alias suod="sudo"
	alias myip="curl https://ipecho.net/plain ; echo"
	alias reload="exec fish"
	alias cls="clear -x"
	alias ls="eza --git --icons"
	alias la="ls -lha"
	alias ll="ls -lh"
	alias l="ls -a"
	alias q="exit"
	zoxide init fish | source
end
