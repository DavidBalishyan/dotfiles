#!/usr/bin/env bash

alias reload="exec bash"
alias q="exit"

# check if a command is installed on the system
is_installed () {
    command -v "$1" &> /dev/null
}

alias grep='grep --color=auto'
alias ls="ls --color=auto"

if is_installed eza; then
	alias ls="eza --icons --git --color"
fi

if is_installed rg; then
	alias grep="rg"
fi

if is_installed nvim; then 
	alias vim="nvim"
fi


alias ll="ls -l"
alias la="ls -A"
alias l="ls -lha"

